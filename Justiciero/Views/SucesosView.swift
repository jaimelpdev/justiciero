import SwiftUI

// MARK: - Noticias de sucesos

struct NewsItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let source: String
    let link: URL?
    let date: Date
}

enum SucesosFeed {
    /// Misma búsqueda que tools/fetch_sucesos.py, que alimenta la versión web.
    static let terms = "(sucesos OR detenido OR detenida OR robo OR atraco OR agresión OR apuñalado OR reyerta OR policía)"

    static func url(for city: String) -> URL? {
        var components = URLComponents(string: "https://news.google.com/rss/search")
        components?.queryItems = [
            URLQueryItem(name: "q", value: "\"\(city)\" \(terms) when:3d"),
            URLQueryItem(name: "hl", value: "es"),
            URLQueryItem(name: "gl", value: "ES"),
            URLQueryItem(name: "ceid", value: "ES:es"),
        ]
        return components?.url
    }

    static func load(city: String) async throws -> [NewsItem] {
        guard let url = url(for: city) else { return [] }
        let (data, _) = try await URLSession.shared.data(from: url)
        let items = RSSParser().parse(data).sorted { $0.date > $1.date }
        return Array(items.prefix(30))
    }
}

final class RSSParser: NSObject, XMLParserDelegate {
    private var items: [NewsItem] = []
    private var fields: [String: String] = [:]
    private var element = ""
    private var inItem = false

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return f
    }()

    func parse(_ data: Data) -> [NewsItem] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return items
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        element = elementName
        if elementName == "item" {
            inItem = true
            fields = [:]
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        guard inItem else { return }
        fields[element, default: ""] += string
    }

    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard inItem, let string = String(data: CDATABlock, encoding: .utf8) else { return }
        fields[element, default: ""] += string
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == "item" else { return }
        inItem = false
        let source = (fields["source"] ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        var title = (fields["title"] ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if !source.isEmpty, title.hasSuffix(" - " + source) {
            title = String(title.dropLast(source.count + 3))
        }
        guard let date = Self.dateFormatter.date(from: (fields["pubDate"] ?? "").trimmingCharacters(in: .whitespacesAndNewlines)) else { return }
        let link = URL(string: (fields["link"] ?? "").trimmingCharacters(in: .whitespacesAndNewlines))
        items.append(NewsItem(title: title, source: source, link: link, date: date))
    }
}

// MARK: - Pantalla

struct SucesosView: View {
    @AppStorage("sucesos.city") private var city = ""
    @AppStorage("sucesos.seen") private var seen: Double = 0

    @State private var cityDraft = ""
    @State private var items: [NewsItem] = []
    @State private var loading = false
    @State private var failed = false
    @State private var showAll = false
    @State private var noteItem: NewsItem?
    /// Momento de la visita anterior: lo que sea más reciente se marca como nuevo.
    @State private var previousVisit: Double = 0

    private var newCount: Int {
        guard previousVisit > 0 else { return 0 }
        return items.filter { $0.date.timeIntervalSince1970 > previousVisit }.count
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Callout(kind: .danger, text: "Enterarte de un suceso **no es para ir allí**. Sirve para evitar zonas, avisar a los tuyos y estar atento. Si sabes algo útil para la investigación, llama al 091 / 062 o usa AlertCops. No difundas bulos ni datos de nadie.")

                VStack(alignment: .leading, spacing: 8) {
                    Text("Tu ciudad o pueblo").font(.caption).foregroundStyle(Theme.muted)
                    HStack {
                        TextField("Ej. Madrid", text: $cityDraft)
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.search)
                            .onSubmit(applyCity)
                        Button("OK", action: applyCity)
                            .buttonStyle(.borderedProminent)
                            .foregroundStyle(.black)
                    }
                }
                .card()

                SectionHeader(title: city.isEmpty ? "Últimos sucesos" : "Últimos sucesos en \(city)", icon: "newspaper.fill")
                feed

                SectionHeader(title: "Más fuentes", icon: "magnifyingglass")
                VStack(spacing: 0) {
                    sourceLink("Google Noticias: sucesos de hoy", icon: "newspaper", url: googleNewsURL)
                    Divider()
                    sourceLink("AlertCops: alertas oficiales y avisar a la policía", icon: "light.beacon.max.fill", url: URL(string: "https://alertcops.ses.mir.es/"))
                    Divider()
                    sourceLink("Policía Nacional (@policia)", icon: "shield.fill", url: URL(string: "https://x.com/policia"))
                    Divider()
                    sourceLink("Guardia Civil (@guardiacivil)", icon: "shield.lefthalf.filled", url: URL(string: "https://x.com/guardiacivil"))
                    Divider()
                    sourceLink("Balance de criminalidad por municipio (Interior)", icon: "chart.bar.fill", url: URL(string: "https://www.interior.gob.es/opencms/es/prensa/balances-e-informes/"))
                }
                .card()

                SectionHeader(title: "Que te avisen", icon: "bell.fill")
                VStack(alignment: .leading, spacing: 10) {
                    Text(md("Crea una **alerta de Google** y te llegará un correo cada vez que se publique un suceso en tu ciudad o tu barrio."))
                        .font(.subheadline)
                    if let url = googleAlertsURL {
                        Link(destination: url) {
                            Label("Crear alerta por correo", systemImage: "envelope.badge.fill")
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                    }
                    Text(md("Sigue también en X o Instagram a la **Policía Local** y al **112** de tu comunidad: publican cortes, incendios y avisos en tiempo real."))
                        .font(.subheadline)
                }
                .card()
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Sucesos")
        .refreshable { await load() }
        .task(id: city) { await load() }
        .onAppear {
            cityDraft = city
            previousVisit = seen
        }
        .onDisappear {
            if !items.isEmpty { seen = Date.now.timeIntervalSince1970 }
        }
        .sheet(item: $noteItem) { item in
            JournalEditor(initialKind: .observacion, initialTitle: item.title)
        }
    }

    @ViewBuilder
    private var feed: some View {
        if city.isEmpty {
            Text("Escribe tu ciudad o tu pueblo para ver las noticias de sucesos de los últimos días.")
                .foregroundStyle(Theme.muted)
                .card()
        } else if loading && items.isEmpty {
            HStack {
                ProgressView()
                Text("Cargando noticias…").foregroundStyle(Theme.muted)
            }
            .frame(maxWidth: .infinity)
            .card()
        } else if failed && items.isEmpty {
            Callout(kind: .warning, text: "No se han podido cargar las noticias. Comprueba tu conexión y desliza hacia abajo para reintentar.")
        } else if items.isEmpty {
            Text("No hay noticias de sucesos en los últimos días. Buena señal.")
                .foregroundStyle(Theme.muted)
                .card()
        } else {
            HStack(spacing: 4) {
                Text("\(items.count) noticias de los últimos 3 días")
                if newCount > 0 {
                    Text("· \(newCount) nuevas").bold().foregroundStyle(Theme.accent)
                }
            }
            .font(.caption)
            .foregroundStyle(Theme.muted)

            ForEach(showAll ? items : Array(items.prefix(10))) { item in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("\(item.source) · \(item.date, format: .relative(presentation: .named))")
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                        Spacer()
                        if previousVisit > 0 && item.date.timeIntervalSince1970 > previousVisit {
                            Pill(text: "Nuevo")
                        }
                    }
                    Text(item.title).font(.headline)
                    HStack {
                        if let link = item.link {
                            Link(destination: link) {
                                Label("Leer noticia", systemImage: "arrow.up.right.square")
                            }
                            .font(.caption)
                        }
                        Spacer()
                        Button {
                            noteItem = item
                        } label: {
                            Label("Anotar", systemImage: "square.and.pencil")
                        }
                        .font(.caption)
                    }
                }
                .card()
            }

            if !showAll && items.count > 10 {
                Button("Ver las \(items.count) noticias") { showAll = true }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                    .foregroundStyle(.white)
            }
        }
    }

    private func sourceLink(_ title: String, icon: String, url: URL?) -> some View {
        Group {
            if let url {
                Link(destination: url) {
                    HStack(spacing: 12) {
                        Image(systemName: icon).foregroundStyle(Theme.accent).frame(width: 24)
                        Text(title).foregroundStyle(.white).multilineTextAlignment(.leading)
                        Spacer()
                        Image(systemName: "arrow.up.right").font(.caption).foregroundStyle(Theme.muted)
                    }
                    .padding(.vertical, 10)
                }
            }
        }
    }

    private var googleNewsURL: URL? {
        var components = URLComponents(string: "https://news.google.com/search")
        components?.queryItems = [
            URLQueryItem(name: "q", value: "\"\(city.isEmpty ? "España" : city)\" sucesos when:1d"),
            URLQueryItem(name: "hl", value: "es"),
            URLQueryItem(name: "gl", value: "ES"),
            URLQueryItem(name: "ceid", value: "ES:es"),
        ]
        return components?.url
    }

    private var googleAlertsURL: URL? {
        var components = URLComponents(string: "https://www.google.com/alerts")
        components?.queryItems = [URLQueryItem(name: "q", value: "\"\(city.isEmpty ? "tu ciudad" : city)\" (sucesos OR detenido OR robo)")]
        return components?.url
    }

    private func applyCity() {
        let trimmed = cityDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed != city else { return }
        items = []
        showAll = false
        city = trimmed
    }

    private func load() async {
        guard !city.isEmpty else { return }
        loading = true
        failed = false
        do {
            items = try await SucesosFeed.load(city: city)
        } catch {
            failed = true
        }
        loading = false
    }
}

struct SucesosCard: View {
    @AppStorage("sucesos.city") private var city = ""

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "newspaper.fill").font(.title2).foregroundStyle(Theme.accent).frame(width: 36)
            VStack(alignment: .leading, spacing: 2) {
                Text(city.isEmpty ? "Sucesos en tu zona" : "Sucesos en \(city)").font(.headline)
                Text(city.isEmpty ? "Elige tu ciudad para ver las noticias de sucesos" : "Lo que ha pasado en los últimos días")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card()
    }
}
