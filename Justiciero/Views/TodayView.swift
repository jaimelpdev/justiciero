import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var store: ProgressStore

    private var suggestedWorkout: Workout {
        let available = Workout.all.filter { $0.minPhase <= store.currentPhase.id }
        let day = Calendar.current.ordinality(of: .day, in: .era, for: .now) ?? 0
        return available[day % available.count]
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 6..<13: return "Buenos días"
        case 13..<21: return "Buenas tardes"
        default: return "Buenas noches"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    header
                    statsRow
                    phaseCard
                    missions
                    workoutCard
                    tipCard
                    quickActions
                }
                .padding()
            }
            .screenBackground()
            .navigationTitle("Base")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(greeting), \(store.state.profile.alias)")
                .font(.subheadline)
                .foregroundStyle(Theme.muted)
            HStack(spacing: 12) {
                Image(systemName: store.rank.icon)
                    .font(.title)
                    .foregroundStyle(.black)
                    .frame(width: 56, height: 56)
                    .background(Theme.accent, in: Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text(store.rank.name)
                        .font(.title2.bold())
                    Text(store.rank.motto)
                        .font(.caption)
                        .foregroundStyle(Theme.muted)
                }
            }
            ProgressBar(value: store.rankProgress)
            HStack {
                Text(verbatim: "\(store.state.xp) XP")
                Spacer()
                if let next = Rank.next(after: store.rank) {
                    Text("Siguiente: \(next.name) (\(next.minXP) XP)")
                } else {
                    Text("Rango máximo")
                }
            }
            .font(.caption)
            .foregroundStyle(Theme.muted)
        }
        .card()
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            StatTile(value: "\(store.streak)", label: "Racha (días)", icon: "flame.fill", color: .orange)
            StatTile(value: "\(store.workoutsThisWeek)", label: "Entrenos semana", icon: "figure.run", color: Theme.success)
            StatTile(value: "\(store.programWeek)", label: "Semana", icon: "calendar", color: Theme.info)
        }
    }

    private var phaseCard: some View {
        let phase = store.currentPhase
        return NavigationLink {
            PhaseDetailView(phase: phase)
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Pill(text: "FASE \(phase.id)", icon: phase.icon)
                    Spacer()
                    Text(phase.weeksLabel)
                        .font(.caption)
                        .foregroundStyle(Theme.muted)
                }
                Text(phase.codename)
                    .font(.title3.weight(.heavy))
                    .tracking(1)
                Text(phase.title)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                ProgressBar(value: store.completion(of: phase))
                Text(verbatim: "\(Int(store.completion(of: phase) * 100)) % completado · necesitas 80 % para avanzar")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            .foregroundStyle(.white)
            .card()
        }
        .buttonStyle(.plain)
    }

    private var missions: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Misiones pendientes", icon: "target")
            let tasks = store.nextTasks()
            if tasks.isEmpty {
                Text("Has completado todas las misiones de esta fase. ¡Enorme!")
                    .font(.subheadline)
                    .card()
            } else {
                ForEach(tasks) { task in
                    TaskRow(task: task, compact: true)
                }
            }
        }
    }

    private var workoutCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Entreno sugerido hoy", icon: "dumbbell.fill")
            NavigationLink {
                WorkoutDetailView(workout: suggestedWorkout)
            } label: {
                WorkoutRow(workout: suggestedWorkout, locked: false)
            }
            .buttonStyle(.plain)
            if store.currentPhase.id >= 1 {
                NavigationLink {
                    DojoView()
                } label: {
                    DojoCard()
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var tipCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionHeader(title: "Consejo del día", icon: "lightbulb.fill")
            Text(DailyTips.today)
                .font(.body.italic())
                .card()
        }
    }

    private var quickActions: some View {
        HStack(spacing: 12) {
            NavigationLink {
                SafeOutingView()
            } label: {
                QuickAction(title: "Salida segura", icon: "location.circle.fill", color: Theme.info)
            }
            NavigationLink {
                EmergencyView()
            } label: {
                QuickAction(title: "Emergencia", icon: "sos", color: Theme.danger)
            }
        }
        .buttonStyle(.plain)
    }
}

struct StatTile: View {
    let value: String
    let label: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon).foregroundStyle(color)
            Text(value).font(.title2.bold().monospacedDigit())
            Text(label).font(.caption2).foregroundStyle(Theme.muted).multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Theme.card, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct QuickAction: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon).font(.title)
            Text(title).font(.subheadline.bold())
        }
        .foregroundStyle(color)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18)
        .background(color.opacity(0.15), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct TaskRow: View {
    @EnvironmentObject private var store: ProgressStore
    let task: ProgramTask
    var compact = false
    var locked = false

    @State private var expanded = false

    var body: some View {
        let done = store.isDone(task)
        HStack(alignment: .top, spacing: 12) {
            Button {
                withAnimation(.snappy) { store.toggle(task) }
            } label: {
                Image(systemName: done ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(done ? Theme.success : Theme.muted)
            }
            .buttonStyle(.plain)
            .disabled(locked)

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Pill(text: task.category.label, icon: task.category.icon, color: task.category.color)
                    Pill(text: "Sem. \(task.week)", color: Theme.muted)
                }
                Text(task.title)
                    .font(.headline)
                    .strikethrough(done, color: Theme.muted)
                    .foregroundStyle(done ? Theme.muted : Color.white)
                Text(task.detail)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                    .lineLimit(compact && !expanded ? 2 : nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .card()
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.snappy) { expanded.toggle() }
        }
        .opacity(locked ? 0.5 : 1)
    }
}
