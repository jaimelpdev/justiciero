import SwiftUI

// MARK: - Reinicio

struct RebootView: View {
    @EnvironmentObject private var store: ProgressStore
    @AppStorage("reboot.barriers") private var barriersDone = ""
    @State private var confirmStop = false
    @State private var writing = false

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_ES")
        f.dateFormat = "d"
        return f
    }()

    private var doneBarriers: Set<Int> {
        Set(barriersDone.split(separator: ",").compactMap { Int($0) })
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                counter
                checkIn

                NavigationLink {
                    UrgeView()
                } label: {
                    Label("Tengo un impulso ahora", systemImage: "water.waves")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: Color.teal))

                weekCard
                history

                SectionHeader(title: "Barreras en tu entorno", icon: "lock.shield.fill")
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(Reboot.barriers.enumerated()), id: \.offset) { index, barrier in
                        Button {
                            var set = doneBarriers
                            if set.contains(index) { set.remove(index) } else { set.insert(index) }
                            barriersDone = set.sorted().map(String.init).joined(separator: ",")
                        } label: {
                            HStack(alignment: .top, spacing: 10) {
                                Image(systemName: doneBarriers.contains(index) ? "checkmark.square.fill" : "square")
                                    .foregroundStyle(doneBarriers.contains(index) ? Theme.success : Theme.muted)
                                Text(barrier)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer(minLength: 0)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .card()

                if let module = SkillModule.all.first(where: { $0.id == "reinicio" }) {
                    SectionHeader(title: "Entiende lo que te pasa", icon: "book.fill")
                    NavigationLink {
                        ModuleView(module: module)
                    } label: {
                        ModuleRow(module: module, learned: store.learnedCount(in: module))
                    }
                    .buttonStyle(.plain)
                }

                Callout(kind: .info, text: Reboot.professional)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Reinicio")
        .sheet(isPresented: $writing) {
            JournalEditor(initialKind: .reflexion, initialTitle: "Reinicio: qué pasó antes")
        }
        .confirmationDialog("¿Terminar la semana de reinicio?", isPresented: $confirmStop, titleVisibility: .visible) {
            Button("Terminar", role: .destructive) { store.stopReboot() }
        } message: {
            Text("Tu plan volverá al de tu fase. El contador y tu mejor racha se mantienen.")
        }
    }

    private var counter: some View {
        HStack(spacing: 12) {
            StatTile(value: "\(store.rebootStreak)", label: store.rebootStreak == 1 ? "día libre seguido" : "días libres seguidos",
                     icon: "flame.fill", color: Color.teal)
            StatTile(value: "\(store.bestRebootStreak)", label: "tu mejor racha", icon: "trophy.fill", color: Theme.accent)
        }
    }

    @ViewBuilder
    private var checkIn: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("¿Cómo ha ido hoy?").font(.headline)
            switch store.rebootStatus() {
            case true?:
                Text("Día libre. Uno más. Así se recupera el control.")
                    .foregroundStyle(Theme.success)
            case false?:
                Text("Has sido sincero, y eso ya es entrenar. Escribe en la Bitácora qué pasó justo antes y vuelve a empezar esta noche. Tu mejor racha sigue ahí.")
                    .foregroundStyle(Theme.muted)
                Button {
                    writing = true
                } label: {
                    Label("Escribir en la Bitácora", systemImage: "pencil")
                        .font(.subheadline.bold())
                        .foregroundStyle(Color.teal)
                }
            case nil:
                Text("Hazlo antes de dormir, con sinceridad. Las dos respuestas cuentan como hábito cumplido.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            }
            HStack(spacing: 10) {
                Button {
                    withAnimation(.snappy) { store.checkInReboot(clean: true) }
                } label: {
                    Label("Hoy libre", systemImage: "checkmark")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: store.rebootStatus() == true ? Theme.success : Theme.cardHighlight))
                Button {
                    withAnimation(.snappy) { store.checkInReboot(clean: false) }
                } label: {
                    Label("He recaído", systemImage: "arrow.counterclockwise")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: store.rebootStatus() == false ? Color.teal : Theme.cardHighlight))
            }
        }
        .card()
    }

    private var weekCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            if store.isRebootActive() {
                Label("Semana de reinicio activa", systemImage: "arrow.counterclockwise.circle.fill")
                    .font(.headline)
                    .foregroundStyle(Color.teal)
                Text("Te \(store.rebootDaysLeft == 1 ? "queda 1 día" : "quedan \(store.rebootDaysLeft) días"). Tu plan diario se centra en la mente y los hábitos, con menos carga física.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                Button("Terminar antes") { confirmStop = true }
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            } else {
                Text(Reboot.intro)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                Button {
                    store.startReboot()
                } label: {
                    Label("Empezar semana de reinicio (\(Reboot.length) días)", systemImage: "play.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: Color.teal))
            }
        }
        .card(Theme.cardHighlight)
    }

    private var history: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Últimos 28 días").font(.headline)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 6), count: 7), spacing: 6) {
                ForEach(store.rebootCalendar, id: \.self) { day in
                    let status = store.rebootStatus(on: day)
                    Text(Self.dayFormatter.string(from: day))
                        .font(.caption2.bold().monospacedDigit())
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .background(color(for: status).opacity(status == nil ? 0.4 : 0.85), in: RoundedRectangle(cornerRadius: 6))
                        .foregroundStyle(status == nil ? Theme.muted : Color.black)
                }
            }
            Text("Verde: día libre · Azul: recaída (información, no fracaso) · Gris: sin check-in")
                .font(.caption2)
                .foregroundStyle(Theme.muted)
        }
        .card()
    }

    private func color(for status: Bool?) -> Color {
        switch status {
        case true?: Theme.success
        case false?: Color.teal
        case nil: Theme.cardHighlight
        }
    }
}

// MARK: - Tengo un impulso ahora

struct UrgeView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.openURL) private var openURL
    @State private var start: Date?

    private let duration: TimeInterval = 15 * 60

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(Reboot.urgeIntro).font(.title3.bold())

                timer

                BreathingCircle()
                    .frame(maxWidth: .infinity)

                LessonBlockView(block: .steps(Reboot.urgeSteps), color: Color.teal)

                SectionHeader(title: "Ideas para estos 15 minutos", icon: "sparkles")
                LessonBlockView(block: .bullets(Reboot.distractions), color: Color.teal)

                if !store.state.profile.contactPhone.isEmpty {
                    Button {
                        let digits = store.state.profile.contactPhone.filter { $0.isNumber || $0 == "+" }
                        if let url = URL(string: "tel://\(digits)") { openURL(url) }
                    } label: {
                        Label("Llamar a \(store.state.profile.contactName.isEmpty ? "tu contacto" : store.state.profile.contactName)", systemImage: "phone.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle(color: Theme.success))
                }

                Text("Si te sientes muy mal, no solo con el impulso, abre «Momento difícil» o habla con un profesional.")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("La ola pasa")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var timer: some View {
        if let start {
            TimelineView(.periodic(from: .now, by: 1)) { context in
                let left = max(0, duration - context.date.timeIntervalSince(start))
                VStack(spacing: 8) {
                    if left > 0 {
                        Text(String(format: "%02d:%02d", Int(left) / 60, Int(left) % 60))
                            .font(.system(size: 56, weight: .bold, design: .rounded).monospacedDigit())
                        ProgressBar(value: 1 - left / duration, color: Color.teal)
                        Text("Sigue con una distracción. El impulso está bajando aunque no lo notes.")
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                    } else {
                        Text("La ola ha pasado.").font(.title2.bold()).foregroundStyle(Theme.success)
                        Text("Lo has surfeado. Cada vez que lo haces, el siguiente impulso llega con menos fuerza.")
                            .font(.subheadline)
                            .foregroundStyle(Theme.muted)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .card(Theme.cardHighlight)
        } else {
            Button {
                start = .now
            } label: {
                Label("Empezar 15 minutos", systemImage: "timer")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButtonStyle(color: Color.teal))
        }
    }
}

/// Tarjeta de Reinicio para Base.
struct RebootCard: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "arrow.counterclockwise.circle.fill")
                .font(.title)
                .foregroundStyle(Color.teal)
            VStack(alignment: .leading, spacing: 2) {
                Text("Reinicio").font(.headline)
                Text("\(store.rebootStreak) \(store.rebootStreak == 1 ? "día libre" : "días libres") · quedan \(store.rebootDaysLeft) de \(Reboot.length)")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card()
    }
}
