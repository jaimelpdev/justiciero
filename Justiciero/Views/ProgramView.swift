import SwiftUI

struct ProgramView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Callout(kind: .info, text: "Un programa de **12 meses** en 6 fases. Cada fase se desbloquea al completar el **80 %** de la anterior. No hay atajos: el orden existe para que llegues a la calle preparado.")

                    ForEach(Phase.all) { phase in
                        let unlocked = store.isUnlocked(phase)
                        NavigationLink {
                            PhaseDetailView(phase: phase)
                        } label: {
                            PhaseCard(phase: phase,
                                      unlocked: unlocked,
                                      completion: store.completion(of: phase),
                                      isCurrent: phase.id == store.currentPhase.id)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .screenBackground()
            .navigationTitle("Programa")
        }
    }
}

struct PhaseCard: View {
    let phase: Phase
    let unlocked: Bool
    let completion: Double
    let isCurrent: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: unlocked ? phase.icon : "lock.fill")
                .font(.title2)
                .foregroundStyle(unlocked ? Color.black : Theme.muted)
                .frame(width: 50, height: 50)
                .background(unlocked ? Theme.accent : Theme.cardHighlight, in: RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("FASE \(phase.id) · \(phase.weeksLabel)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Theme.muted)
                    Spacer()
                    if isCurrent { Pill(text: "ACTUAL") }
                }
                Text(phase.codename)
                    .font(.headline.weight(.heavy))
                Text(phase.title)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                Label(phase.location, systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
                if unlocked {
                    ProgressBar(value: completion, color: completion >= 0.8 ? Theme.success : Theme.accent, height: 6)
                        .padding(.top, 4)
                } else {
                    Text("Completa el 80 % de la fase anterior")
                        .font(.caption)
                        .foregroundStyle(Theme.accent)
                }
            }
        }
        .foregroundStyle(.white)
        .card(isCurrent ? Theme.cardHighlight : Theme.card)
    }
}

struct PhaseDetailView: View {
    @EnvironmentObject private var store: ProgressStore
    let phase: Phase

    private var tasksByWeek: [(week: Int, tasks: [ProgramTask])] {
        Dictionary(grouping: phase.tasks, by: \.week)
            .map { (week: $0.key, tasks: $0.value) }
            .sorted { $0.week < $1.week }
    }

    var body: some View {
        let unlocked = store.isUnlocked(phase)
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Pill(text: "FASE \(phase.id)", icon: phase.icon)
                        Pill(text: phase.location, icon: "mappin.and.ellipse", color: Theme.info)
                    }
                    Text(phase.title).font(.title2.bold())
                    Text(phase.summary).foregroundStyle(Theme.muted)
                    ProgressBar(value: store.completion(of: phase)).padding(.top, 4)
                }

                if !unlocked {
                    Callout(kind: .warning, text: "Fase bloqueada. Puedes leerla para saber lo que viene, pero no marcar tareas hasta completar el 80 % de la fase anterior.")
                }

                SectionHeader(title: "Por qué en este orden", icon: "questionmark.circle.fill")
                Text(phase.whyThisOrder).card()

                SectionHeader(title: "Objetivos", icon: "target")
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(phase.objectives, id: \.self) { objective in
                        Label {
                            Text(objective)
                        } icon: {
                            Image(systemName: "checkmark.diamond.fill").foregroundStyle(Theme.accent)
                        }
                    }
                }
                .card()

                SectionHeader(title: "Reglas de seguridad de la fase", icon: "exclamationmark.shield.fill")
                VStack(spacing: 8) {
                    ForEach(phase.safetyRules, id: \.self) { rule in
                        Callout(kind: .danger, text: rule)
                    }
                }

                if !store.state.profile.isAdult, let minorNote = phase.minorNote {
                    Callout(kind: .info, text: minorNote)
                }

                ForEach(tasksByWeek, id: \.week) { group in
                    SectionHeader(title: "Semana \(group.week)", icon: "calendar")
                    ForEach(group.tasks) { task in
                        TaskRow(task: task, locked: !unlocked)
                    }
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(phase.codename)
        .navigationBarTitleDisplayMode(.inline)
    }
}
