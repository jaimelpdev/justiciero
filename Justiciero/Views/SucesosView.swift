import SwiftUI
import CoreLocation

// MARK: - Noticias de sucesos

struct NewsItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let source: String
    let link: URL?
    let date: Date
    var nearby = false
}

/// Quita tildes y pasa a minúsculas para comparar nombres de barrios.
func folded(_ text: String) -> String {
    text.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: Locale(identifier: "es_ES"))
}

/// True si el título menciona alguno de los nombres como palabra completa.
func mentions(_ title: String, any names: [String]) -> Bool {
    let words = folded(title)
    return names.contains { name in
        let needle = folded(name)
        var range = words.startIndex..<words.endIndex
        while let found = words.range(of: needle, range: range) {
            let before = found.lowerBound == words.startIndex ? nil : words[words.index(before: found.lowerBound)]
            let after = found.upperBound == words.endIndex ? nil : words[found.upperBound]
            if !(before?.isLetter ?? false) && !(before?.isNumber ?? false) && !(after?.isLetter ?? false) && !(after?.isNumber ?? false) {
                return true
            }
            range = found.upperBound..<words.endIndex
        }
        return false
    }
}

enum SucesosFeed {
    /// Misma búsqueda que tools/fetch_sucesos.py, que alimenta la versión web.
    static let terms = "(sucesos OR detenido OR detenida OR robo OR atraco OR agresión OR apuñalado OR reyerta OR policía)"

    static func url(query: String) -> URL? {
        var components = URLComponents(string: "https://news.google.com/rss/search")
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "hl", value: "es"),
            URLQueryItem(name: "gl", value: "ES"),
            URLQueryItem(name: "ceid", value: "ES:es"),
        ]
        return components?.url
    }

    private static func fetch(_ query: String) async throws -> [NewsItem] {
        guard let url = url(query: query) else { return [] }
        let (data, _) = try await URLSession.shared.data(from: url)
        return RSSParser().parse(data)
    }

    /// Noticias de la ciudad y, si hay zona, una búsqueda específica de tu barrio o distrito.
    static func load(city: String, zones: [String]) async throws -> [NewsItem] {
        var items = try await fetch("\"\(city)\" \(terms) when:3d")
        if !zones.isEmpty {
            let names = zones.map { "\"\($0)\"" }.joined(separator: " OR ")
            let zoneItems = (try? await fetch("(\(names)) \(city) \(terms) when:7d")) ?? []
            let known = Set(items.map(\.title))
            items += zoneItems.filter { !known.contains($0.title) }.map { item in
                var copy = item
                copy.nearby = true
                return copy
            }
        }
        for index in items.indices where !items[index].nearby {
            items[index].nearby = mentions(items[index].title, any: zones)
        }
        return Array(items.sorted { $0.date > $1.date }.prefix(60))
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
    @AppStorage("sucesos.zone") private var zone = ""
    @AppStorage("sucesos.seen") private var seen: Double = 0

    @State private var cityDraft = ""
    @State private var zoneDraft = ""
    @State private var locator = ZoneLocator()
    @State private var locating = false
    @State private var locationError = false
    @State private var items: [NewsItem] = []
    @State private var loading = false
    @State private var failed = false
    @State private var showAll = false
    @State private var noteItem: NewsItem?
    /// Momento de la visita anterior: lo que sea más reciente se marca como nuevo.
    @State private var previousVisit: Double = 0

    private var zones: [String] {
        zone.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { $0.count >= 3 }
    }

    private var nearbyItems: [NewsItem] { items.filter(\.nearby) }
    private var otherItems: [NewsItem] { items.filter { !$0.nearby } }

    private var newCount: Int {
        guard previousVisit > 0 else { return 0 }
        return items.filter { $0.date.timeIntervalSince1970 > previousVisit }.count
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Callout(kind: .danger, text: "Enterarte de un suceso **no es para ir allí**. Sirve para evitar zonas, avisar a los tuyos y estar atento. Si sabes algo útil para la investigación, llama al 091 / 062 o usa AlertCops. No difundas bulos ni datos de nadie.")

                VStack(alignment: .leading, spacing: 10) {
                    Button {
                        Task { await locate() }
                    } label: {
                        Label(locating ? "Buscando tu zona…" : "Usar mi ubicación", systemImage: "location.fill")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(locating)
                    if locationError {
                        Text("No he podido obtener tu ubicación. Revisa el permiso en Ajustes › Justiciero o escribe tu zona a mano.")
                            .font(.caption)
                            .foregroundStyle(Theme.danger)
                    }
                    Text("Ciudad o pueblo").font(.caption).foregroundStyle(Theme.muted)
                    TextField("Ej. Madrid", text: $cityDraft)
                        .textFieldStyle(.roundedBorder)
                    Text("Barrio o distrito (opcional, separa varios con comas)").font(.caption).foregroundStyle(Theme.muted)
                    TextField("Ej. Latina, Aluche", text: $zoneDraft)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .onSubmit(applyZone)
                    Button("Guardar zona", action: applyZone)
                        .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                        .foregroundStyle(.white)
                    Text("Tu ubicación solo se usa para saber tu ciudad y tu barrio. No se guarda ni se envía a nadie más.")
                        .font(.caption2)
                        .foregroundStyle(Theme.muted)
                }
                .card()

                feed

                SectionHeader(title: "Más fuentes", icon: "magnifyingglass")
                VStack(spacing: 0) {
                    sourceLink("Google Noticias: sucesos en \(zones.first ?? (city.isEmpty ? "tu zona" : city)) (7 días)", icon: "newspaper", url: googleNewsURL)
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
                    Text(md("Crea una **alerta de Google** y te llegará un correo cada vez que se publique un suceso en \(zones.first ?? (city.isEmpty ? "tu zona" : city))."))
                        .font(.subheadline)
                    if let url = googleAlertsURL {
                        Link(destination: url) {
                            Label("Crear alerta por correo", systemImage: "envelope.badge.fill")
                                .foregroundStyle(.white)
                        }
                        .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                    }
                    Text(md("Sigue también en X o Instagram a la **Policía Local** y al **112** de tu comunidad, y únete al grupo de vecinos de tu barrio: suelen ser los primeros en avisar."))
                        .font(.subheadline)
                }
                .card()
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Sucesos")
        .refreshable { await load() }
        .task(id: city + "|" + zone) { await load() }
        .onAppear {
            cityDraft = city
            zoneDraft = zone
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
                Text("\(items.count) noticias recientes")
                if newCount > 0 {
                    Text("· \(newCount) nuevas").bold().foregroundStyle(Theme.accent)
                }
            }
            .font(.caption)
            .foregroundStyle(Theme.muted)

            if !zones.isEmpty {
                SectionHeader(title: "En tu zona · \(zones.joined(separator: ", "))", icon: "location.fill")
                if nearbyItems.isEmpty {
                    Text("Ninguna noticia reciente menciona \(zones.joined(separator: " o ")). Buena señal.")
                        .font(.subheadline)
                        .foregroundStyle(Theme.muted)
                        .card()
                } else {
                    ForEach(nearbyItems) { newsCard($0) }
                }
            }

            SectionHeader(title: zones.isEmpty ? "Últimos sucesos en \(city)" : "Resto de \(city)", icon: "newspaper.fill")
            if otherItems.isEmpty {
                Text("No hay más noticias de sucesos en los últimos días.")
                    .foregroundStyle(Theme.muted)
                    .card()
            } else {
                ForEach(showAll ? otherItems : Array(otherItems.prefix(10))) { newsCard($0) }
            }

            if !showAll && otherItems.count > 10 {
                Button("Ver las \(otherItems.count) noticias") { showAll = true }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                    .foregroundStyle(.white)
            }
        }
    }

    private func newsCard(_ item: NewsItem) -> some View {
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

    private var place: String {
        if let first = zones.first { return "\"\(first)\" \(city)" }
        return "\"\(city.isEmpty ? "España" : city)\""
    }

    private var googleNewsURL: URL? {
        var components = URLComponents(string: "https://news.google.com/search")
        components?.queryItems = [
            URLQueryItem(name: "q", value: "\(place) (sucesos OR detenido OR robo OR agresión) when:7d"),
            URLQueryItem(name: "hl", value: "es"),
            URLQueryItem(name: "gl", value: "ES"),
            URLQueryItem(name: "ceid", value: "ES:es"),
        ]
        return components?.url
    }

    private var googleAlertsURL: URL? {
        var components = URLComponents(string: "https://www.google.com/alerts")
        components?.queryItems = [URLQueryItem(name: "q", value: "\(place) (sucesos OR detenido OR robo)")]
        return components?.url
    }

    private func applyZone() {
        let newCity = cityDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        let newZone = zoneDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !newCity.isEmpty, newCity != city || newZone != zone else { return }
        items = []
        showAll = false
        city = newCity
        zone = newZone
    }

    private func locate() async {
        locating = true
        locationError = false
        if let placemark = await locator.locate(), let locality = placemark.locality {
            let names = [placemark.subLocality].compactMap { $0 }
            cityDraft = locality
            zoneDraft = names.joined(separator: ", ")
            applyZone()
        } else {
            locationError = true
        }
        locating = false
    }

    private func load() async {
        guard !city.isEmpty else { return }
        loading = true
        failed = false
        do {
            items = try await SucesosFeed.load(city: city, zones: zones)
        } catch {
            failed = true
        }
        loading = false
    }
}

struct SucesosCard: View {
    @AppStorage("sucesos.city") private var city = ""
    @AppStorage("sucesos.zone") private var zone = ""

    private var place: String {
        zone.split(separator: ",").first.map { $0.trimmingCharacters(in: .whitespaces) } ?? city
    }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "newspaper.fill").font(.title2).foregroundStyle(Theme.accent).frame(width: 36)
            VStack(alignment: .leading, spacing: 2) {
                Text(city.isEmpty ? "Sucesos en tu zona" : "Sucesos en \(place)").font(.headline)
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

// MARK: - Ubicación

/// Obtiene una sola vez la ubicación y la traduce a ciudad y barrio.
/// CLLocationManager se crea en el hilo principal, así que sus avisos llegan también ahí.
final class ZoneLocator: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocation?, Never>?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func locate() async -> CLPlacemark? {
        guard continuation == nil else { return nil }
        let location: CLLocation? = await withCheckedContinuation { continuation in
            self.continuation = continuation
            switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation()
            default:
                finish(nil)
            }
        }
        guard let location else { return nil }
        let placemarks = try? await CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "es_ES"))
        return placemarks?.first
    }

    private func finish(_ location: CLLocation?) {
        continuation?.resume(returning: location)
        continuation = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard continuation != nil else { return }
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways: manager.requestLocation()
        case .notDetermined: break
        default: finish(nil)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        finish(locations.last)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        finish(nil)
    }
}
