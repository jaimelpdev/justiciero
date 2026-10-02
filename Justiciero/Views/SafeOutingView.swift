import SwiftUI
import UserNotifications

/// "Modo Alfred": una lista de comprobación antes de salir de noche y un temporizador de check-in.
/// Si no confirmas que estás bien a tiempo, el móvil te avisa para que lo hagas o pidas ayuda.
struct SafeOutingView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.openURL) private var openURL

    @AppStorage("outing.endDate") private var endTimestamp: Double = 0
    @AppStorage("outing.interval") private var intervalMinutes = 45
    @AppStorage("outing.startedAt") private var startedTimestamp: Double = 0

    @State private var checks: Set<Int> = []
    @State private var now = Date.now
    @State private var showingEndSheet = false

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private let checklist = [
        "Alguien de confianza sabe dónde voy y a qué hora vuelvo",
        "Móvil por encima del 50 % (o llevo batería externa)",
        "Ubicación compartida con mi contacto",
        "Ropa visible o reflectante y calzado cómodo",
        "Botiquín de bolsillo, linterna y DNI",
        "No llevo armas ni nada que pueda parecerlo",
        "Estoy sobrio y descansado",
        "He repasado el Código del Vigilante",
    ]

    private var isActive: Bool { endTimestamp > 0 }
    private var endDate: Date { Date(timeIntervalSince1970: endTimestamp) }
    private var remaining: Int { max(0, Int(endDate.timeIntervalSince(now))) }
    private var overdue: Bool { isActive && remaining == 0 }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if store.currentPhase.id < 2 {
                    Callout(kind: .warning, text: "Estás en la fase \(store.currentPhase.id). Las salidas nocturnas de entrenamiento empiezan en la **Fase 2**. Mientras tanto, usa esto para cualquier vuelta a casa de noche.")
                }
                if !store.state.profile.isAdult {
                    Callout(kind: .warning, text: "Eres menor de edad: tus salidas nocturnas, siempre acompañado por un adulto y con permiso de tu familia.")
                }

                if isActive { activeView } else { setupView }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Salida segura")
        .onReceive(ticker) { now = $0 }
        .sheet(isPresented: $showingEndSheet) {
            JournalEditor(initialKind: .salida, initialTitle: "Salida nocturna")
        }
    }

    // MARK: Preparación

    private var setupView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Antes de salir, comprueba todo. Mientras estés fuera, la app te pedirá que confirmes que estás bien cada cierto tiempo.")
                .foregroundStyle(Theme.muted)

            SectionHeader(title: "Checklist", icon: "checklist")
            VStack(spacing: 0) {
                ForEach(checklist.indices, id: \.self) { index in
                    Button {
                        if checks.contains(index) { checks.remove(index) } else { checks.insert(index) }
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: checks.contains(index) ? "checkmark.square.fill" : "square")
                                .foregroundStyle(checks.contains(index) ? Theme.success : Theme.muted)
                                .font(.title3)
                            Text(checklist[index]).multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                    if index < checklist.count - 1 { Divider() }
                }
            }
            .card()

            SectionHeader(title: "Check-in cada", icon: "timer")
            Picker("Intervalo", selection: $intervalMinutes) {
                Text("20 min").tag(20)
                Text("45 min").tag(45)
                Text("1 h").tag(60)
                Text("1 h 30").tag(90)
            }
            .pickerStyle(.segmented)

            if store.state.profile.contactPhone.isEmpty {
                Callout(kind: .info, text: "Añade un contacto de confianza en Más › Perfil para poder avisarle con un toque.")
            }

            Button {
                start()
            } label: {
                Label("Iniciar salida", systemImage: "moon.fill")
            }
            .buttonStyle(PrimaryButtonStyle(color: checks.count == checklist.count ? Theme.accent : Theme.muted))
            .disabled(checks.count < checklist.count)

            if checks.count < checklist.count {
                Text("Marca todos los puntos para poder salir.")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: En curso

    private var activeView: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text(overdue ? "CHECK-IN PENDIENTE" : "PRÓXIMO CHECK-IN")
                    .font(.caption.weight(.bold))
                    .tracking(1.5)
                    .foregroundStyle(overdue ? Theme.danger : Theme.accent)
                Text(String(format: "%02d:%02d", remaining / 60, remaining % 60))
                    .font(.system(size: 72, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(overdue ? Theme.danger : Color.white)
                Text("Fuera desde las \(Date(timeIntervalSince1970: startedTimestamp), format: .dateTime.hour().minute())")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            .frame(maxWidth: .infinity)
            .card(overdue ? Theme.danger.opacity(0.2) : Theme.card)

            Button {
                checkIn()
            } label: {
                Label("Estoy bien", systemImage: "hand.thumbsup.fill")
            }
            .buttonStyle(PrimaryButtonStyle(color: Theme.success))

            HStack(spacing: 12) {
                Button {
                    if let url = URL(string: "tel://112") { openURL(url) }
                } label: {
                    QuickAction(title: "112", icon: "sos", color: Theme.danger)
                }
                Button {
                    sendSMS("Estoy en una salida y necesito que me llames. Mira mi ubicación compartida.")
                } label: {
                    QuickAction(title: "Avisar a \(store.state.profile.contactName.isEmpty ? "contacto" : store.state.profile.contactName)",
                                icon: "message.fill", color: Theme.info)
                }
                .disabled(store.state.profile.contactPhone.isEmpty)
            }
            .buttonStyle(.plain)

            Button {
                finish()
            } label: {
                Label("He vuelto a casa", systemImage: "house.fill")
            }
            .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))

            Callout(kind: .tip, text: "Si ves algo: **distancia, 112 y descripción**. Tu trabajo esta noche es volver a casa sano.")
        }
    }

    // MARK: Lógica

    private func start() {
        startedTimestamp = Date.now.timeIntervalSince1970
        scheduleNext()
        sendSMS("Salgo ahora. Te aviso cuando vuelva. Si no sabes nada de mí en \(intervalMinutes * 2) minutos, llámame.", onlyIfContact: true)
    }

    private func checkIn() {
        scheduleNext()
    }

    private func finish() {
        endTimestamp = 0
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["outing-checkin", "outing-overdue"])
        checks = []
        showingEndSheet = true
    }

    private func scheduleNext() {
        let next = Date.now.addingTimeInterval(TimeInterval(intervalMinutes * 60))
        endTimestamp = next.timeIntervalSince1970
        now = .now

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }
            center.removePendingNotificationRequests(withIdentifiers: ["outing-checkin", "outing-overdue"])

            let checkin = UNMutableNotificationContent()
            checkin.title = "¿Todo bien?"
            checkin.body = "Abre Justiciero y confirma que estás bien."
            checkin.sound = .default
            center.add(UNNotificationRequest(identifier: "outing-checkin", content: checkin,
                                             trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(intervalMinutes * 60), repeats: false)))

            let overdue = UNMutableNotificationContent()
            overdue.title = "Check-in sin confirmar"
            overdue.body = "Han pasado 5 minutos. Si necesitas ayuda, llama al 112 o avisa a tu contacto."
            overdue.sound = .default
            center.add(UNNotificationRequest(identifier: "outing-overdue", content: overdue,
                                             trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(intervalMinutes * 60 + 300), repeats: false)))
        }
    }

    private func sendSMS(_ body: String, onlyIfContact: Bool = false) {
        let phone = store.state.profile.contactPhone.filter { $0.isNumber || $0 == "+" }
        if phone.isEmpty && onlyIfContact { return }
        let encoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "sms:\(phone)&body=\(encoded)") { openURL(url) }
    }
}
