import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var store: ProgressStore

    @State private var page = 0
    @State private var alias = ""
    @State private var isAdult = true
    @State private var acceptedRisks = false
    @State private var contactName = ""
    @State private var contactPhone = ""

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $page) {
                welcome.tag(0)
                truth.tag(1)
                safety.tag(2)
                identity.tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))

            footer
                .padding()
        }
        .background(Theme.bg.ignoresSafeArea())
    }

    // MARK: Páginas

    private var welcome: some View {
        OnboardingPage(icon: "moon.stars.fill",
                       title: "Justiciero",
                       subtitle: "Un programa de 12 meses para convertirte en alguien que protege a los demás por la noche. De verdad.") {
            VStack(alignment: .leading, spacing: 12) {
                feature("figure.strengthtraining.traditional", "Entrenamiento progresivo, empezando en casa")
                feature("figure.martial.arts", "Dojo en casa: 7 cinturones con entrenador por voz")
                feature("cross.case.fill", "Primeros auxilios, la habilidad que más vidas salva")
                feature("building.columns.fill", "Lo que la ley te permite y lo que no")
                feature("eye.fill", "Observación y memoria de detective")
                feature("theatermask.and.paintbrush.fill", "Simulador de situaciones reales")
                feature("shield.fill", "Del entrenamiento al servicio real")
            }
        }
    }

    private var truth: some View {
        OnboardingPage(icon: "exclamationmark.bubble.fill",
                       title: "La verdad sobre Batman",
                       subtitle: "En la vida real, un justiciero enmascarado que pega a delincuentes acaba herido, detenido o las dos cosas.") {
            VStack(spacing: 12) {
                Callout(kind: .danger, text: "Nada de armas, persecuciones, máscaras ni «dar lecciones».")
                Callout(kind: .tip, text: "Lo que sí funciona: estar en forma, saber primeros auxilios, ser un testigo excelente, saber desescalar y unirte a quienes ya protegen la ciudad de noche (Protección Civil, Cruz Roja, emergencias...).")
                Text("Esta app te convierte en ese tipo de héroe. El que llega a casa entero y ha ayudado de verdad.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            }
        }
    }

    private var safety: some View {
        OnboardingPage(icon: "heart.text.square.fill",
                       title: "Antes de empezar",
                       subtitle: "Unas reglas para que esto sea seguro.") {
            VStack(alignment: .leading, spacing: 12) {
                feature("stethoscope", "Si tienes alguna condición de salud, consulta a tu médico antes de entrenar.")
                feature("house.fill", "Las primeras semanas son en casa. La calle llega cuando estés preparado.")
                feature("figure.martial.arts", "Artes marciales en tu propio dojo: técnica lenta y limpia, y nunca contra personas sin control.")
                feature("phone.fill", "Ante cualquier peligro: distancia y 112.")
                Toggle(isOn: $acceptedRisks) {
                    Text("Entiendo que esta app no sustituye a la formación presencial ni me autoriza a intervenir en situaciones peligrosas.")
                        .font(.subheadline)
                }
                .padding(.top, 8)
            }
        }
    }

    private var identity: some View {
        OnboardingPage(icon: "person.crop.circle.badge.checkmark",
                       title: "Tu identidad",
                       subtitle: "Todo se guarda solo en tu iPhone.") {
            VStack(alignment: .leading, spacing: 14) {
                TextField("Tu alias de vigilante", text: $alias)
                    .textFieldStyle(.roundedBorder)
                Toggle("Soy mayor de edad", isOn: $isAdult)
                if !isAdult {
                    Callout(kind: .info, text: "Perfecto, puedes hacer el programa. Las partes de calle se adaptan: siempre de día o con un adulto, y el voluntariado a través de programas juveniles.")
                }
                Text("Tu «Alfred»: alguien de confianza que siempre sepa dónde estás (opcional, puedes añadirlo después).")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                TextField("Nombre", text: $contactName)
                    .textFieldStyle(.roundedBorder)
                TextField("Teléfono", text: $contactPhone)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.phonePad)
            }
        }
    }

    // MARK: Pie

    private var canContinue: Bool {
        switch page {
        case 2: acceptedRisks
        case 3: !alias.trimmingCharacters(in: .whitespaces).isEmpty
        default: true
        }
    }

    private var footer: some View {
        Button {
            if page < 3 {
                withAnimation { page += 1 }
            } else {
                finish()
            }
        } label: {
            Text(page < 3 ? "Siguiente" : "Empezar en La Cueva")
        }
        .buttonStyle(PrimaryButtonStyle(color: canContinue ? Theme.accent : Theme.muted))
        .disabled(!canContinue)
    }

    private func finish() {
        var profile = store.state.profile
        profile.alias = alias.trimmingCharacters(in: .whitespaces)
        profile.isAdult = isAdult
        profile.contactName = contactName
        profile.contactPhone = contactPhone
        profile.startDate = .now
        profile.onboarded = true
        store.state.profile = profile
    }

    private func feature(_ icon: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(Theme.accent)
                .frame(width: 28)
            Text(text)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct OnboardingPage<Content: View>: View {
    let icon: String
    let title: String
    let subtitle: String
    @ViewBuilder let content: Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: icon)
                    .font(.system(size: 56))
                    .foregroundStyle(Theme.accent)
                    .padding(.top, 40)
                Text(title)
                    .font(.largeTitle.weight(.heavy))
                Text(subtitle)
                    .font(.title3)
                    .foregroundStyle(Theme.muted)
                content
            }
            .padding(24)
            .padding(.bottom, 40)
        }
    }
}
