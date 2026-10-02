import SwiftUI
import Charts

struct ChartPoint: Identifiable {
    let id = UUID()
    let date: Date
    let value: Int
}

struct ProfileView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var showingTest = false
    @State private var metric: Metric = .pushups

    enum Metric: String, CaseIterable, Identifiable {
        case pushups, squats, plank, burpees, run
        var id: String { rawValue }

        var label: String {
            switch self {
            case .pushups: "Flexiones"
            case .squats: "Sentadillas"
            case .plank: "Plancha (s)"
            case .burpees: "Burpees"
            case .run: "5 km (min)"
            }
        }

        func value(_ test: FitnessTest) -> Int? {
            switch self {
            case .pushups: test.pushups
            case .squats: test.squats
            case .plank: test.plankSeconds
            case .burpees: test.burpees
            case .run: test.run5kMinutes
            }
        }
    }

    var body: some View {
        Form {
            Section("Identidad") {
                TextField("Alias", text: $store.state.profile.alias)
                Toggle("Soy mayor de edad", isOn: $store.state.profile.isAdult)
                LabeledContent("Empezaste", value: store.state.profile.startDate.formatted(date: .long, time: .omitted))
                LabeledContent("Rango", value: store.rank.name)
                LabeledContent("Experiencia", value: "\(store.state.xp) XP")
            }

            Section {
                TextField("Nombre", text: $store.state.profile.contactName)
                TextField("Teléfono", text: $store.state.profile.contactPhone)
                    .keyboardType(.phonePad)
            } header: {
                Text("Tu «Alfred» (contacto de confianza)")
            } footer: {
                Text("Se usa para llamarle o enviarle un SMS desde Salida segura y Emergencias. No se envía a ningún sitio.")
            }

            Section("Evolución física") {
                if store.state.tests.isEmpty {
                    Text("Aún no has registrado ningún test.")
                        .foregroundStyle(Theme.muted)
                } else {
                    Picker("Métrica", selection: $metric) {
                        ForEach(Metric.allCases) { Text($0.label).tag($0) }
                    }
                    let points = store.state.tests.compactMap { test in
                        metric.value(test).map { ChartPoint(date: test.date, value: $0) }
                    }
                    if points.isEmpty {
                        Text("Sin datos para esta métrica.").foregroundStyle(Theme.muted)
                    } else {
                        Chart(points) { point in
                            LineMark(x: .value("Fecha", point.date), y: .value(metric.label, point.value))
                                .foregroundStyle(Theme.accent)
                            PointMark(x: .value("Fecha", point.date), y: .value(metric.label, point.value))
                                .foregroundStyle(Theme.accent)
                        }
                        .frame(height: 180)
                        if let first = points.first, let last = points.last, points.count > 1 {
                            let diff = last.value - first.value
                            let better = metric == .run ? diff < 0 : diff > 0
                            Text("Desde tu primer test: \(diff > 0 ? "+" : "")\(diff)")
                                .foregroundStyle(better ? Theme.success : Theme.muted)
                        }
                    }
                }
                Button {
                    showingTest = true
                } label: {
                    Label("Registrar nuevo test", systemImage: "plus.circle.fill")
                }
            }

            if !store.state.tests.isEmpty {
                Section("Historial de tests") {
                    ForEach(store.state.tests.reversed()) { test in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(test.date, format: .dateTime.day().month().year())
                                .font(.headline)
                            Text("Flexiones \(test.pushups) · Sentadillas \(test.squats) · Plancha \(test.plankSeconds) s · Burpees \(test.burpees)")
                                .font(.caption)
                                .foregroundStyle(Theme.muted)
                            if let run = test.run5kMinutes {
                                Text("5 km en \(run) min").font(.caption).foregroundStyle(Theme.muted)
                            }
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Theme.bg.ignoresSafeArea())
        .navigationTitle("Perfil")
        .sheet(isPresented: $showingTest) {
            FitnessTestForm()
        }
    }
}
