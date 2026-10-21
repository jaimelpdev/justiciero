import SwiftUI

// MARK: - Entrenamiento mental

struct MentalView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(Mind.intro).foregroundStyle(Theme.muted)
                Callout(kind: .info, text: Mind.professional)

                NavigationLink {
                    SOSMindView()
                } label: {
                    Label("Momento difícil: calma guiada ahora", systemImage: "heart.circle.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: Color.purple))

                SectionHeader(title: "Práctica de hoy", icon: "sun.max.fill")
                NavigationLink {
                    PracticeView(practice: store.practiceOfTheDay)
                } label: {
                    PracticeRow(practice: store.practiceOfTheDay, highlighted: true)
                }
                .buttonStyle(.plain)

                SectionHeader(title: "Todas las prácticas", icon: "list.bullet")
                ForEach(Mind.practices) { practice in
                    NavigationLink {
                        PracticeView(practice: practice)
                    } label: {
                        PracticeRow(practice: practice, highlighted: false)
                    }
                    .buttonStyle(.plain)
                }

                if let module = SkillModule.all.first(where: { $0.id == "fortaleza" }) {
                    NavigationLink {
                        ModuleView(module: module)
                    } label: {
                        ModuleRow(module: module, learned: store.learnedCount(in: module))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Entrenamiento mental")
    }
}

struct PracticeRow: View {
    let practice: MentalPractice
    let highlighted: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: practice.icon)
                .font(.title2)
                .foregroundStyle(Color.purple)
                .frame(width: 44, height: 44)
                .background(Color.purple.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 2) {
                Text(practice.title).font(.headline)
                Text("\(practice.minutes) min").font(.caption).foregroundStyle(Theme.muted)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card(highlighted ? Theme.cardHighlight : Theme.card)
    }
}

struct PracticeView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss
    let practice: MentalPractice

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: practice.icon).font(.largeTitle).foregroundStyle(Color.purple)
                    VStack(alignment: .leading) {
                        Text(practice.title).font(.title2.bold())
                        Text("\(practice.minutes) minutos").font(.caption).foregroundStyle(Theme.muted)
                    }
                }
                Callout(kind: .info, text: "**Por qué funciona:** \(practice.why)")
                SectionHeader(title: "Paso a paso", icon: "list.number")
                LessonBlockView(block: .steps(practice.steps), color: Color.purple)

                if practice.id == "respiracion" {
                    BreathingCircle()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }

                Button {
                    store.completePractice(practice)
                    dismiss()
                } label: {
                    Label("Hecho (+\(XP.mental) XP)", systemImage: "checkmark")
                }
                .buttonStyle(PrimaryButtonStyle(color: Color.purple))

                Text("Si una práctica te remueve demasiado, para. Haz el ejercicio 5-4-3-2-1 y habla con alguien de confianza o con un profesional.")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(practice.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Círculo que se expande y se contrae siguiendo la respiración cuadrada (4-4-4-4).
struct BreathingCircle: View {
    private let phases = ["Inspira", "Retén", "Suelta", "Retén"]

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1)) { context in
            let second = Int(context.date.timeIntervalSinceReferenceDate) % 16
            let phase = second / 4
            let count = second % 4 + 1
            let expanded = phase == 0 || phase == 1
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color.purple.opacity(0.25))
                        .frame(width: expanded ? 200 : 110, height: expanded ? 200 : 110)
                        .animation(.easeInOut(duration: 4), value: expanded)
                    VStack {
                        Text(phases[phase]).font(.title2.bold())
                        Text("\(count)").font(.largeTitle.bold().monospacedDigit())
                    }
                }
                .frame(width: 210, height: 210)
            }
        }
    }
}

// MARK: - Momento difícil

struct SOSMindView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.openURL) private var openURL

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Estás haciendo lo correcto. Vamos paso a paso.")
                    .font(.title3.bold())

                BreathingCircle()
                    .frame(maxWidth: .infinity)

                LessonBlockView(block: .steps(Mind.sosSteps), color: Color.purple)

                SectionHeader(title: "Habla con alguien", icon: "phone.fill")
                VStack(spacing: 10) {
                    if !store.state.profile.contactPhone.isEmpty {
                        callButton("Llamar a \(store.state.profile.contactName.isEmpty ? "tu contacto" : store.state.profile.contactName)",
                                   number: store.state.profile.contactPhone, color: Theme.success)
                    }
                    callButton("024 · Atención a la conducta suicida (gratis, 24 h)", number: "024", color: Color.purple)
                    callButton("016 · Violencia de género (gratis, 24 h, no deja rastro)", number: "016", color: Color.purple)
                    callButton("112 · Si estás en peligro ahora", number: "112", color: Theme.danger)
                }

                Callout(kind: .info, text: "Para trabajar lo que viviste con ayuda profesional y gratuita: tu médico de cabecera o la **Oficina de Asistencia a las Víctimas del Delito** de tu provincia.")
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Momento difícil")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func callButton(_ title: String, number: String, color: Color) -> some View {
        Button {
            let digits = number.filter { $0.isNumber || $0 == "+" }
            if let url = URL(string: "tel://\(digits)") { openURL(url) }
        } label: {
            Label(title, systemImage: "phone.fill")
                .font(.subheadline.bold())
                .foregroundStyle(color)
                .frame(maxWidth: .infinity, alignment: .leading)
                .card()
        }
        .buttonStyle(.plain)
    }
}
