import SwiftUI
import UserNotifications

// MARK: - Plan de hoy (en Base)

struct DailyPlanSection: View {
    @EnvironmentObject private var store: ProgressStore

    private static let weekdayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_ES")
        f.dateFormat = "EEEE d 'de' MMMM"
        return f
    }()

    var body: some View {
        let items = store.plan()
        let progress = store.habitProgress()
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Tu plan de hoy").font(.title3.bold())
                        Text(Self.weekdayFormatter.string(from: .now).prefix(1).uppercased() + Self.weekdayFormatter.string(from: .now).dropFirst())
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                    }
                    Spacer()
                    Text("\(progress.done)/\(progress.total)")
                        .font(.title2.bold().monospacedDigit())
                        .foregroundStyle(progress.done == progress.total ? Theme.success : Theme.accent)
                }
                ProgressBar(value: Double(progress.done) / Double(max(progress.total, 1)),
                            color: progress.done == progress.total ? Theme.success : Theme.accent)
                HStack {
                    Label("\(items.reduce(0) { $0 + $1.minutes }) min en total", systemImage: "clock")
                    Spacer()
                    let streak = store.habitStreak
                    Label("Racha: \(streak) \(streak == 1 ? "día" : "días")", systemImage: "flame.fill")
                }
                .font(.caption)
                .foregroundStyle(Theme.muted)
                if progress.done == progress.total {
                    Text("Día completado. Así se construye un protector.")
                        .font(.subheadline.bold())
                        .foregroundStyle(Theme.success)
                }
            }
            .card(Theme.cardHighlight)

            ForEach(DayBlock.allCases, id: \.self) { block in
                let blockItems = items.filter { $0.block == block }
                if !blockItems.isEmpty {
                    SectionHeader(title: block.label, icon: block.icon)
                    ForEach(blockItems) { item in
                        HabitRow(item: item)
                    }
                }
            }

            NavigationLink {
                WeekPlanView()
            } label: {
                Label("Ver la semana y recordatorios", systemImage: "calendar")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
        }
    }
}

struct HabitRow: View {
    @EnvironmentObject private var store: ProgressStore
    let item: HabitItem
    @State private var showingTest = false

    private var nextLesson: (SkillModule, Lesson)? {
        for module in SkillModule.all {
            if let lesson = module.lessons.first(where: { !store.isLearned($0) }) { return (module, lesson) }
        }
        return nil
    }

    private var workout: Workout? { Workout.all.first { $0.id == item.workout } }
    private var mission: ProgramTask? { store.nextTasks(limit: 1).first }

    /// La lección y la misión ya hechas hoy muestran su nombre genérico (la siguiente sería otra).
    private var doneGeneric: Bool {
        (item.kind == .leccion || item.kind == .mision) && store.isDone(item)
    }

    private var title: String {
        if doneGeneric { return item.title }
        return resolvedTitle
    }

    private var detail: String {
        if doneGeneric { return resolvedTitle == item.title ? "Hecha." : "Hecha. Si te apetece adelantar: \(resolvedTitle)." }
        return resolvedDetail
    }

    private var resolvedTitle: String {
        switch item.kind {
        case .leccion: nextLesson.map { "Lección: \($0.1.title)" } ?? "Repasa una lección"
        case .mision: mission.map { "Misión: \($0.title)" } ?? "Misiones de la fase completadas"
        case .dojo: "Clase del Dojo · cinturón \(store.currentBelt.name.lowercased())"
        default: item.title
        }
    }

    private var resolvedDetail: String {
        switch item.kind {
        case .leccion: nextLesson.map { "\($0.0.title) · \($0.1.minutes) min. Léela y márcala como aprendida." } ?? "Ya has aprendido todas las lecciones: repasa la que peor recuerdes."
        case .mision: mission?.detail ?? "Repasa las misiones de tu fase o adelanta el test físico."
        default: item.detail
        }
    }

    var body: some View {
        let done = store.isDone(item)
        HStack(alignment: .top, spacing: 12) {
            Button {
                withAnimation(.snappy) { store.toggleHabit(item) }
            } label: {
                Image(systemName: done ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(done ? Theme.success : Theme.muted)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .strikethrough(done, color: Theme.muted)
                    .foregroundStyle(done ? Theme.muted : Color.white)
                Text(detail)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    if item.minutes > 0 {
                        Pill(text: "\(item.minutes) min", icon: "clock", color: Theme.info)
                    }
                    if item.kind.isAutomatic && !done {
                        Pill(text: "Se marca sola", icon: "wand.and.stars", color: Theme.muted)
                    }
                    Spacer()
                    link
                }
            }
        }
        .card()
        .sheet(isPresented: $showingTest) { FitnessTestForm() }
    }

    @ViewBuilder
    private var link: some View {
        switch item.kind {
        case .entreno:
            if let workout {
                NavigationLink { WorkoutDetailView(workout: workout) } label: { goLabel }
            }
        case .dojo:
            NavigationLink { BeltView(belt: store.currentBelt) } label: { goLabel }
        case .leccion:
            if let next = nextLesson {
                NavigationLink { LessonView(lesson: next.1, color: next.0.color) } label: { goLabel }
            }
        case .mision:
            NavigationLink { PhaseDetailView(phase: store.currentPhase) } label: { goLabel }
        case .kim:
            NavigationLink { KimGameView() } label: { goLabel }
        case .escenario:
            NavigationLink { ScenarioListView() } label: { goLabel }
        case .bitacora:
            NavigationLink { JournalView() } label: { goLabel }
        case .salida:
            NavigationLink { SafeOutingView() } label: { goLabel }
        case .test:
            Button { showingTest = true } label: { goLabel }
        default:
            EmptyView()
        }
    }

    private var goLabel: some View {
        Label("Ir", systemImage: "arrow.right.circle.fill")
            .font(.subheadline.bold())
            .foregroundStyle(Theme.accent)
    }
}

// MARK: - Semana

struct WeekPlanView: View {
    @EnvironmentObject private var store: ProgressStore
    @AppStorage("habits.reminders") private var reminders = false

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "es_ES")
        f.dateFormat = "EEEE d"
        return f
    }()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Cada día tiene los mismos hábitos fijos (levantarte a tu hora, respiración, lección, bitácora y dormir a tu hora) más el entrenamiento que toca. El plan cambia cuando avanzas de fase.")
                    .foregroundStyle(Theme.muted)

                ForEach(store.currentWeekDays, id: \.self) { day in
                    let isToday = Calendar.current.isDateInToday(day)
                    let isFuture = day > Date.now && !isToday
                    let progress = store.habitProgress(on: day)
                    let specific = store.plan(for: day).filter { item in !Habits.daily.contains(where: { $0.id == item.id }) }
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text(Self.dayFormatter.string(from: day).capitalized).font(.headline)
                            if isToday { Pill(text: "HOY") }
                            Spacer()
                            if !isFuture {
                                Text("\(progress.done)/\(progress.total)")
                                    .font(.subheadline.bold().monospacedDigit())
                                    .foregroundStyle(progress.done == progress.total ? Theme.success : Theme.muted)
                            }
                        }
                        ForEach(specific) { item in
                            Label(item.title, systemImage: icon(for: item.kind))
                                .font(.subheadline)
                                .foregroundStyle(Theme.muted)
                        }
                    }
                    .card(isToday ? Theme.cardHighlight : Theme.card)
                }

                SectionHeader(title: "Recordatorios", icon: "bell.fill")
                VStack(alignment: .leading, spacing: 8) {
                    Toggle("Avisarme cada día", isOn: $reminders)
                        .onChange(of: reminders) { _, enabled in scheduleReminders(enabled) }
                    Text("A las 8:00 para empezar el día y a las 21:30 para la bitácora y preparar el descanso.")
                        .font(.caption)
                        .foregroundStyle(Theme.muted)
                }
                .card()
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Tu semana")
    }

    private func icon(for kind: HabitKind) -> String {
        switch kind {
        case .entreno: "figure.strengthtraining.traditional"
        case .dojo: "figure.martial.arts"
        case .mision: "target"
        case .kim: "eye.fill"
        case .escenario: "theatermask.and.paintbrush.fill"
        case .test: "stopwatch.fill"
        case .salida: "location.fill"
        case .voluntariado: "heart.fill"
        case .descanso: "bed.double.fill"
        default: "checkmark.circle"
        }
    }

    private func scheduleReminders(_ enabled: Bool) {
        let center = UNUserNotificationCenter.current()
        let ids = ["habit-morning", "habit-night"]
        center.removePendingNotificationRequests(withIdentifiers: ids)
        guard enabled else { return }
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else { return }
            let reminders: [(String, Int, Int, String, String)] = [
                (ids[0], 8, 0, "Tu plan de hoy", "Abre Justiciero y mira qué toca hoy. Empieza por lo más fácil."),
                (ids[1], 21, 30, "Cierra el día", "Bitácora de 2 minutos, prepara la ropa de mañana y a dormir a tu hora."),
            ]
            for (id, hour, minute, title, body) in reminders {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = .default
                var components = DateComponents()
                components.hour = hour
                components.minute = minute
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                center.add(UNNotificationRequest(identifier: id, content: content, trigger: trigger))
            }
        }
    }
}
