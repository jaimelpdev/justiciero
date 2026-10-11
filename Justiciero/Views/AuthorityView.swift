import SwiftUI

struct AuthorityCard: View {
    @EnvironmentObject private var store: ProgressStore
    @AppStorage("authority.route") private var routeID = "proteccion"

    private var route: AuthorityRoute { Authority.routes.first { $0.id == routeID } ?? Authority.proteccion }

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "shield.checkered")
                .font(.title2)
                .foregroundStyle(.black)
                .frame(width: 50, height: 50)
                .background(Theme.accent, in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 6) {
                Text("Ruta a la autoridad").font(.headline)
                Text("Tu ruta: \(route.title)").font(.subheadline).foregroundStyle(Theme.muted)
                ProgressBar(value: store.completion(of: route), height: 6)
            }
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card(Theme.cardHighlight)
    }
}

struct AuthorityView: View {
    @EnvironmentObject private var store: ProgressStore
    @AppStorage("authority.route") private var routeID = "proteccion"

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(Authority.intro).foregroundStyle(Theme.muted)
                Callout(kind: .danger, text: Authority.warning)

                SectionHeader(title: "Elige tu ruta", icon: "signpost.right.and.left.fill")
                ForEach(Authority.routes) { route in
                    NavigationLink {
                        RouteView(route: route)
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 12) {
                                Image(systemName: route.icon)
                                    .font(.title2)
                                    .foregroundStyle(Theme.accent)
                                    .frame(width: 36)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(route.title).font(.headline)
                                    Text("\(route.time) · \(route.steps.count) pasos").font(.caption).foregroundStyle(Theme.muted)
                                }
                                Spacer()
                                if route.id == routeID { Pill(text: "TU RUTA", icon: "star.fill") }
                                Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                            }
                            Text(route.study).font(.subheadline).foregroundStyle(Theme.muted)
                            ProgressBar(value: store.completion(of: route), color: Theme.success, height: 6)
                        }
                        .foregroundStyle(.white)
                        .card(route.id == routeID ? Theme.cardHighlight : Theme.card)
                    }
                    .buttonStyle(.plain)
                }

                Callout(kind: .tip, text: "Puedes avanzar en varias a la vez. La ruta principal es la que el plan diario te propone cada miércoles.")
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Ruta a la autoridad")
    }
}

struct RouteView: View {
    @EnvironmentObject private var store: ProgressStore
    @AppStorage("authority.route") private var routeID = "proteccion"
    let route: AuthorityRoute

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: route.icon).font(.largeTitle).foregroundStyle(Theme.accent)
                    VStack(alignment: .leading) {
                        Text(route.title).font(.title2.bold())
                        Text("\(Int(store.completion(of: route) * 100)) % completado")
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                    }
                }
                Text(route.summary)

                if route.id == routeID {
                    Label("Es tu ruta principal", systemImage: "star.fill")
                        .font(.subheadline.bold())
                        .foregroundStyle(Theme.accent)
                } else {
                    Button {
                        routeID = route.id
                    } label: {
                        Label("Elegir como ruta principal", systemImage: "star")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }

                VStack(alignment: .leading, spacing: 10) {
                    infoRow("clock.fill", "Tiempo", route.time)
                    infoRow("book.closed.fill", "Estudio", route.study)
                    infoRow("shield.fill", "Qué puedes hacer", route.powers)
                }
                .card()

                SectionHeader(title: "Requisitos", icon: "checklist")
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(route.requirements, id: \.self) { requirement in
                        Label {
                            Text(requirement)
                        } icon: {
                            Image(systemName: "checkmark.diamond.fill").foregroundStyle(Theme.accent)
                        }
                    }
                }
                .card()

                SectionHeader(title: "Pasos", icon: "list.number")
                ForEach(route.steps) { step in
                    TaskRow(task: step)
                }

                if !route.links.isEmpty {
                    SectionHeader(title: "Enlaces", icon: "link")
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(route.links, id: \.self) { item in
                            if let url = URL(string: item.url) {
                                Link(destination: url) {
                                    Label(item.title, systemImage: "arrow.up.right.square")
                                }
                            }
                        }
                    }
                    .card()
                }

                Callout(kind: .info, text: "Los requisitos y plazos son orientativos y pueden cambiar: confírmalos siempre en la agrupación, el centro de formación o la convocatoria oficial.")
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(route.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func infoRow(_ icon: String, _ title: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon).foregroundStyle(Theme.accent).frame(width: 22)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.caption.bold()).foregroundStyle(Theme.muted)
                Text(text).font(.subheadline)
            }
        }
    }
}
