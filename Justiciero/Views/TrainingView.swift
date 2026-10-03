import SwiftUI
import UIKit

struct TrainingView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var showingTest = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Callout(kind: .tip, text: "Objetivo semanal: **3 sesiones** físicas + **2–3 clases** del Dojo a partir de la Fase 1. Puedes hacer una clase del Dojo y una sesión física el mismo día, pero deja al menos un día de descanso total a la semana.")

                    NavigationLink {
                        DojoView()
                    } label: {
                        DojoCard()
                    }
                    .buttonStyle(.plain)

                    HStack(spacing: 12) {
                        StatTile(value: "\(store.workoutsThisWeek)/3", label: "Esta semana", icon: "calendar", color: Theme.accent)
                        StatTile(value: "\(store.state.workouts.count)", label: "Totales", icon: "flame.fill", color: .orange)
                        StatTile(value: "\(store.state.tests.count)", label: "Tests físicos", icon: "chart.line.uptrend.xyaxis", color: Theme.info)
                    }

                    Button {
                        showingTest = true
                    } label: {
                        Label("Registrar test físico", systemImage: "stopwatch.fill")
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    SectionHeader(title: "Sesiones físicas", icon: "dumbbell.fill")
                    ForEach(Workout.all) { workout in
                        let locked = workout.minPhase > store.currentPhase.id
                        NavigationLink {
                            WorkoutDetailView(workout: workout)
                        } label: {
                            WorkoutRow(workout: workout, locked: locked)
                        }
                        .buttonStyle(.plain)
                        .disabled(locked)
                    }

                    if !store.state.workouts.isEmpty {
                        SectionHeader(title: "Historial reciente", icon: "clock.arrow.circlepath")
                        VStack(spacing: 0) {
                            ForEach(store.state.workouts.prefix(10)) { log in
                                HStack {
                                    Text(log.name)
                                    Spacer()
                                    Text(log.date, format: .dateTime.day().month().hour().minute())
                                        .foregroundStyle(Theme.muted)
                                }
                                .font(.subheadline)
                                .padding(.vertical, 8)
                                Divider()
                            }
                        }
                        .card()
                    }
                }
                .padding()
            }
            .screenBackground()
            .navigationTitle("Entreno")
            .sheet(isPresented: $showingTest) {
                FitnessTestForm()
            }
        }
    }
}

struct WorkoutRow: View {
    let workout: Workout
    let locked: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: locked ? "lock.fill" : (workout.blocks.first?.exercise.icon ?? "figure.run"))
                .font(.title2)
                .foregroundStyle(locked ? Theme.muted : Theme.accent)
                .frame(width: 44)
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.name).font(.headline)
                Text(workout.focus).font(.subheadline).foregroundStyle(Theme.muted)
                HStack {
                    Pill(text: "\(workout.minutes) min", icon: "clock", color: Theme.info)
                    Pill(text: workout.place, icon: "mappin", color: Theme.success)
                    if locked { Pill(text: "Fase \(workout.minPhase)", icon: "lock.fill", color: Theme.muted) }
                }
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card()
        .opacity(locked ? 0.55 : 1)
    }
}

struct WorkoutDetailView: View {
    let workout: Workout
    @State private var running = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(workout.focus).foregroundStyle(Theme.muted)
                HStack {
                    Pill(text: "\(workout.minutes) min", icon: "clock", color: Theme.info)
                    Pill(text: workout.place, icon: "mappin", color: Theme.success)
                }
                if let notes = workout.notes {
                    Callout(kind: .warning, text: notes)
                }

                SectionHeader(title: "Ejercicios", icon: "list.number")
                ForEach(Array(workout.blocks.enumerated()), id: \.offset) { index, block in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("\(index + 1)").font(.headline).foregroundStyle(Theme.accent)
                            Image(systemName: block.exercise.icon)
                            Text(block.exercise.name).font(.headline)
                            Spacer()
                            Text(block.prescription).font(.subheadline.monospacedDigit()).foregroundStyle(Theme.accent)
                        }
                        Text(block.exercise.howTo).font(.subheadline).foregroundStyle(Theme.muted)
                        Text(md("**Más fácil:** \(block.exercise.easier)"))
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                        if block.rest > 0 {
                            Label("Descanso \(block.rest) s", systemImage: "pause.circle")
                                .font(.caption)
                                .foregroundStyle(Theme.muted)
                        }
                    }
                    .card()
                }

                Button {
                    running = true
                } label: {
                    Label("Empezar sesión", systemImage: "play.fill")
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, 8)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(workout.name)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $running) {
            WorkoutSessionView(workout: workout)
        }
    }
}

// MARK: - Sesión guiada

struct WorkoutSessionView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss

    let workout: Workout

    private enum Stage { case work, rest, finished }

    @State private var blockIndex = 0
    @State private var setIndex = 0
    @State private var stage: Stage = .work
    @State private var remaining = 0
    @State private var timerRunning = false
    @State private var startDate = Date.now
    @State private var saved = false

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var block: WorkoutBlock { workout.blocks[blockIndex] }

    private var totalSets: Int { workout.blocks.reduce(0) { $0 + $1.sets } }

    private var completedSets: Int {
        workout.blocks.prefix(blockIndex).reduce(0) { $0 + $1.sets } + setIndex
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                ProgressBar(value: Double(completedSets) / Double(max(totalSets, 1)))
                    .padding(.horizontal)

                Spacer()

                switch stage {
                case .work: workView
                case .rest: restView
                case .finished: finishedView
                }

                Spacer()
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.bg.ignoresSafeArea())
            .navigationTitle(workout.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Salir") { dismiss() }
                }
            }
        }
        .onAppear {
            startDate = .now
            prepareWork()
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onReceive(ticker) { _ in tick() }
    }

    private var workView: some View {
        VStack(spacing: 16) {
            Text("SERIE \(setIndex + 1) DE \(block.sets)")
                .font(.caption.weight(.bold))
                .tracking(1.5)
                .foregroundStyle(Theme.accent)
            Image(systemName: block.exercise.icon)
                .font(.system(size: 64))
                .foregroundStyle(Theme.accent)
            Text(block.exercise.name)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            if block.seconds != nil {
                Text(timeString(remaining))
                    .font(.system(size: 72, weight: .bold, design: .rounded).monospacedDigit())
                Button(timerRunning ? "Pausar" : "Iniciar") {
                    timerRunning.toggle()
                }
                .buttonStyle(PrimaryButtonStyle(color: timerRunning ? Theme.muted : Theme.accent))
                .padding(.horizontal, 40)
            } else {
                Text(block.reps ?? "")
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                Text("repeticiones")
                    .foregroundStyle(Theme.muted)
                Button("Hecho") { finishSet() }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal, 40)
            }

            Text(block.exercise.howTo)
                .font(.footnote)
                .foregroundStyle(Theme.muted)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
        }
    }

    private var restView: some View {
        VStack(spacing: 16) {
            Text("DESCANSO")
                .font(.caption.weight(.bold))
                .tracking(1.5)
                .foregroundStyle(Theme.info)
            Text(timeString(remaining))
                .font(.system(size: 80, weight: .bold, design: .rounded).monospacedDigit())
            Text("Respira: 4 s dentro, 4 s fuera")
                .foregroundStyle(Theme.muted)
            Text("Siguiente: \(nextLabel)")
                .font(.headline)
            Button("Saltar descanso") { advance() }
                .buttonStyle(PrimaryButtonStyle(color: Theme.info))
                .padding(.horizontal, 40)
        }
    }

    private var finishedView: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 80))
                .foregroundStyle(Theme.success)
            Text("Sesión completada")
                .font(.largeTitle.bold())
            Text("Cada sesión te acerca un paso más. Hidrátate y estira.")
                .foregroundStyle(Theme.muted)
                .multilineTextAlignment(.center)
            Button(saved ? "Guardado" : "Registrar sesión (+\(XP.workout) XP)") {
                guard !saved else { return }
                let minutes = max(1, Int(Date.now.timeIntervalSince(startDate) / 60))
                store.logWorkout(workout, minutes: minutes)
                saved = true
                dismiss()
            }
            .buttonStyle(PrimaryButtonStyle(color: Theme.success))
            .padding(.horizontal, 40)
        }
        .padding()
    }

    private var nextLabel: String {
        if setIndex + 1 < block.sets { return "\(block.exercise.name) · serie \(setIndex + 2)" }
        if blockIndex + 1 < workout.blocks.count { return workout.blocks[blockIndex + 1].exercise.name }
        return "¡Final!"
    }

    private func prepareWork() {
        stage = .work
        remaining = block.seconds ?? 0
        timerRunning = false
    }

    private func tick() {
        guard stage != .finished else { return }
        if stage == .rest || (stage == .work && timerRunning && block.seconds != nil) {
            if remaining > 0 { remaining -= 1 }
            if remaining <= 0 {
                if stage == .work { finishSet() } else { advance() }
            }
        }
    }

    private func finishSet() {
        timerRunning = false
        let isLastSet = setIndex + 1 >= block.sets && blockIndex + 1 >= workout.blocks.count
        if isLastSet {
            setIndex = block.sets
            stage = .finished
            return
        }
        if block.rest > 0 {
            stage = .rest
            remaining = block.rest
        } else {
            advance()
        }
    }

    private func advance() {
        if setIndex + 1 < block.sets {
            setIndex += 1
        } else if blockIndex + 1 < workout.blocks.count {
            blockIndex += 1
            setIndex = 0
        } else {
            stage = .finished
            return
        }
        prepareWork()
    }

    private func timeString(_ seconds: Int) -> String {
        String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}

// MARK: - Test físico

struct FitnessTestForm: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss

    @State private var pushups = 10
    @State private var squats = 20
    @State private var plank = 30
    @State private var burpees = 10
    @State private var hasRun = false
    @State private var runMinutes = 35

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Hazlo descansado, con calentamiento previo de 5 minutos y descansando 3 minutos entre pruebas. Técnica limpia: las repeticiones malas no cuentan.")
                        .font(.footnote)
                        .foregroundStyle(Theme.muted)
                }
                Section("Fuerza") {
                    Stepper("Flexiones seguidas: \(pushups)", value: $pushups, in: 0...200)
                    Stepper("Sentadillas en 1 min: \(squats)", value: $squats, in: 0...200)
                }
                Section("Core y resistencia") {
                    Stepper("Plancha: \(plank) s", value: $plank, in: 0...600, step: 5)
                    Stepper("Burpees en 1 min: \(burpees)", value: $burpees, in: 0...100)
                }
                Section("Carrera") {
                    Toggle("He corrido 5 km", isOn: $hasRun)
                    if hasRun {
                        Stepper("Tiempo: \(runMinutes) min", value: $runMinutes, in: 15...90)
                    }
                }
            }
            .navigationTitle("Test físico")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        store.addTest(FitnessTest(pushups: pushups, squats: squats, plankSeconds: plank,
                                                  burpees: burpees, run5kMinutes: hasRun ? runMinutes : nil))
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let last = store.state.tests.last {
                    pushups = last.pushups
                    squats = last.squats
                    plank = last.plankSeconds
                    burpees = last.burpees
                    if let run = last.run5kMinutes {
                        hasRun = true
                        runMinutes = run
                    }
                }
            }
        }
    }
}

struct DojoCard: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        let belt = store.currentBelt
        HStack(spacing: 14) {
            BeltBadge(belt: belt)
            VStack(alignment: .leading, spacing: 6) {
                Text("Dojo en casa").font(.headline)
                Text("Artes marciales · cinturón \(belt.name.lowercased())").font(.subheadline).foregroundStyle(Theme.muted)
                ProgressBar(value: Double(store.classesDone(belt)) / Double(belt.minClasses), height: 6)
                Text("\(store.state.dojoBelts.count) de \(Belt.all.count) cinturones").font(.caption).foregroundStyle(Theme.muted)
            }
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card(Theme.cardHighlight)
    }
}
