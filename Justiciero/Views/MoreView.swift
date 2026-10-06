import SwiftUI

struct MoreView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var confirmReset = false

    var body: some View {
        NavigationStack {
            List {
                Section("En la calle") {
                    NavigationLink { SucesosView() } label: {
                        Label("Sucesos en tu zona", systemImage: "newspaper.fill")
                    }
                    NavigationLink { SafeOutingView() } label: {
                        Label("Salida segura", systemImage: "location.circle.fill")
                    }
                    NavigationLink { EmergencyView() } label: {
                        Label("Emergencias", systemImage: "sos")
                    }
                    NavigationLink { GearView() } label: {
                        Label("Equipamiento", systemImage: "backpack.fill")
                    }
                }
                Section("Tu progreso") {
                    NavigationLink { ProfileView() } label: {
                        Label("Perfil y tests físicos", systemImage: "person.crop.circle.fill")
                    }
                    NavigationLink { JournalView() } label: {
                        Label("Bitácora", systemImage: "book.pages.fill")
                    }
                    NavigationLink { RanksView() } label: {
                        Label("Rangos", systemImage: "rosette")
                    }
                }
                Section("Información") {
                    NavigationLink { CodeView() } label: {
                        Label("El Código del Vigilante", systemImage: "scroll.fill")
                    }
                    NavigationLink { AboutView() } label: {
                        Label("Aviso importante", systemImage: "info.circle.fill")
                    }
                }
                Section {
                    Button("Reiniciar todo el progreso", role: .destructive) {
                        confirmReset = true
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Theme.bg.ignoresSafeArea())
            .navigationTitle("Más")
            .confirmationDialog("¿Borrar todo tu progreso? No se puede deshacer.", isPresented: $confirmReset, titleVisibility: .visible) {
                Button("Borrar todo", role: .destructive) { store.reset() }
            }
        }
    }
}

// MARK: - Emergencias

struct EmergencyNumber: Identifiable {
    var id: String { number }
    let number: String
    let name: String
    let detail: String
    let icon: String
}

struct EmergencyView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.openURL) private var openURL

    private let numbers = [
        EmergencyNumber(number: "091", name: "Policía Nacional", detail: "Delitos en ciudades", icon: "shield.fill"),
        EmergencyNumber(number: "062", name: "Guardia Civil", detail: "Delitos en zonas rurales y carreteras", icon: "shield.lefthalf.filled"),
        EmergencyNumber(number: "092", name: "Policía Local", detail: "Convivencia, tráfico, ruido", icon: "building.2.fill"),
        EmergencyNumber(number: "016", name: "Violencia de género", detail: "Gratuito, 24 h, no deja rastro en la factura", icon: "heart.fill"),
        EmergencyNumber(number: "024", name: "Conducta suicida", detail: "Gratuito, 24 h, confidencial", icon: "heart.text.square.fill"),
        EmergencyNumber(number: "900202010", name: "ANAR (menores)", detail: "Ayuda a niños y adolescentes", icon: "figure.and.child.holdinghands"),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button {
                    call("112")
                } label: {
                    VStack(spacing: 6) {
                        Text("112").font(.system(size: 64, weight: .heavy, design: .rounded))
                        Text("EMERGENCIAS").font(.headline).tracking(2)
                        Text("Gratuito · Funciona sin saldo y sin cobertura de tu operador").font(.caption)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(Theme.danger, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                }
                .buttonStyle(.plain)

                Callout(kind: .info, text: "**Qué decir:** dónde estás (calle, número, referencia), qué pasa, cuántos heridos, si hay armas y hacia dónde huyeron. No cuelgues hasta que te lo digan.")

                if !store.state.profile.contactPhone.isEmpty {
                    SectionHeader(title: "Tu contacto de confianza", icon: "person.fill.checkmark")
                    HStack(spacing: 12) {
                        Button {
                            call(store.state.profile.contactPhone)
                        } label: {
                            QuickAction(title: "Llamar a \(store.state.profile.contactName)", icon: "phone.fill", color: Theme.success)
                        }
                        Button {
                            sendSMS("Necesito ayuda. Llámame en cuanto puedas.")
                        } label: {
                            QuickAction(title: "SMS de ayuda", icon: "message.fill", color: Theme.info)
                        }
                    }
                    .buttonStyle(.plain)
                }

                SectionHeader(title: "Otros números (España)", icon: "phone.fill")
                ForEach(numbers) { item in
                    Button {
                        call(item.number)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: item.icon).font(.title2).foregroundStyle(Theme.accent).frame(width: 36)
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.detail).font(.caption).foregroundStyle(Theme.muted)
                            }
                            Spacer()
                            Text(item.number).font(.title3.bold().monospacedDigit())
                        }
                        .foregroundStyle(.white)
                        .card()
                    }
                    .buttonStyle(.plain)
                }

                Callout(kind: .tip, text: "Instala **AlertCops** (Ministerio del Interior) para alertar a la policía por chat si no puedes hablar, y configura **Emergencia SOS** en Ajustes del iPhone.")
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Emergencias")
    }

    private func call(_ number: String) {
        let digits = number.filter { $0.isNumber || $0 == "+" }
        if let url = URL(string: "tel://\(digits)") { openURL(url) }
    }

    private func sendSMS(_ body: String) {
        let phone = store.state.profile.contactPhone.filter { $0.isNumber || $0 == "+" }
        let encoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "sms:\(phone)&body=\(encoded)") { openURL(url) }
    }
}

// MARK: - Equipamiento

struct GearView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("El cinturón de Batman, versión legal. Tu equipo sirve para ayudar, avisar y protegerte, no para atacar.")
                    .foregroundStyle(Theme.muted)
                ForEach([GearStatus.recomendado, .condicionado, .prohibido], id: \.self) { status in
                    SectionHeader(title: status.label, icon: status.icon)
                    ForEach(GearItem.all.filter { $0.status == status }) { item in
                        HStack(alignment: .top, spacing: 14) {
                            Image(systemName: item.icon)
                                .font(.title2)
                                .foregroundStyle(status.color)
                                .frame(width: 36)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name).font(.headline)
                                Text(item.why).font(.subheadline).foregroundStyle(Theme.muted)
                            }
                        }
                        .card()
                    }
                }
                Callout(kind: .info, text: "Información orientativa basada en la normativa española. La legislación cambia y depende del país: ante la duda, consulta a la policía local.")
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Equipamiento")
    }
}

// MARK: - Rangos

struct RanksView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Callout(kind: .info, text: "Ganas XP con cada misión (\(XP.task)), sesión de entreno (\(XP.workout)), test físico (\(XP.test)), lección (\(XP.lesson)), clase del Dojo (\(XP.dojoClass)), cinturón (\(XP.belt)), escenario mejorado y partida del Juego de Kim.")
                ForEach(Rank.all) { rank in
                    let reached = store.state.xp >= rank.minXP
                    HStack(spacing: 14) {
                        Image(systemName: rank.icon)
                            .font(.title2)
                            .foregroundStyle(reached ? Color.black : Theme.muted)
                            .frame(width: 50, height: 50)
                            .background(reached ? Theme.accent : Theme.cardHighlight, in: Circle())
                        VStack(alignment: .leading, spacing: 2) {
                            Text(rank.name).font(.headline)
                            Text(rank.motto).font(.caption).foregroundStyle(Theme.muted)
                            Text("\(rank.minXP) XP").font(.caption.monospacedDigit()).foregroundStyle(Theme.accent)
                        }
                        Spacer()
                        if rank == store.rank { Pill(text: "TÚ") }
                    }
                    .card(rank == store.rank ? Theme.cardHighlight : Theme.card)
                    .opacity(reached ? 1 : 0.6)
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Rangos")
    }
}

// MARK: - Aviso

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("Batman no existe. Tú sí.")
                    .font(.title.bold())
                Text("Esta app toma la idea del justiciero nocturno y la convierte en algo real: una persona en forma, formada en primeros auxilios, que conoce la ley, observa con atención y protege a su comunidad desde dentro de la legalidad.")
                Callout(kind: .danger, text: "Esta app **no** te anima a enfrentarte a delincuentes, patrullar por tu cuenta, perseguir, retener ni castigar a nadie. Hacerlo es peligroso y, en la mayoría de los casos, ilegal.")
                Callout(kind: .warning, text: "El contenido es divulgativo y no sustituye a la formación presencial (primeros auxilios, artes marciales), al consejo médico ni al asesoramiento jurídico. La información legal se refiere a España y puede cambiar.")
                Callout(kind: .info, text: "Antes de empezar un programa de ejercicio, consulta con tu médico si tienes cualquier condición de salud.")
                Text("Tus datos se guardan solo en tu dispositivo.")
                    .font(.footnote)
                    .foregroundStyle(Theme.muted)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Aviso")
    }
}
