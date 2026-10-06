import Foundation
import SwiftUI

struct Profile: Codable {
    var alias: String = ""
    var isAdult: Bool = true
    var onboarded: Bool = false
    var startDate: Date = .now
    var contactName: String = ""
    var contactPhone: String = ""
}

struct FitnessTest: Codable, Identifiable {
    var id = UUID()
    var date: Date = .now
    var pushups: Int
    var squats: Int
    var plankSeconds: Int
    var burpees: Int
    /// Minutos para correr 5 km (nil si aún no puedes o no lo has medido).
    var run5kMinutes: Int?
}

struct WorkoutLog: Codable, Identifiable {
    var id = UUID()
    var date: Date = .now
    var workoutID: String
    var name: String
    var minutes: Int
}

enum JournalKind: String, Codable, CaseIterable, Identifiable {
    case entrenamiento, salida, observacion, estudio, voluntariado, reflexion

    var id: String { rawValue }

    var label: String {
        switch self {
        case .entrenamiento: "Entrenamiento"
        case .salida: "Salida nocturna"
        case .observacion: "Observación"
        case .estudio: "Estudio"
        case .voluntariado: "Voluntariado"
        case .reflexion: "Reflexión"
        }
    }

    var icon: String {
        switch self {
        case .entrenamiento: "figure.run"
        case .salida: "moon.fill"
        case .observacion: "eye.fill"
        case .estudio: "book.fill"
        case .voluntariado: "heart.fill"
        case .reflexion: "pencil.and.outline"
        }
    }
}

struct JournalEntry: Codable, Identifiable {
    var id = UUID()
    var date: Date = .now
    var kind: JournalKind
    var title: String
    var notes: String
    var mood: Int = 3
}

struct AppState: Codable {
    var profile = Profile()
    var xp = 0
    var completedTasks: Set<String> = []
    var completedLessons: Set<String> = []
    var scenarioBest: [String: Int] = [:]
    var kimBest = 0
    var kimGames = 0
    var workouts: [WorkoutLog] = []
    var tests: [FitnessTest] = []
    var journal: [JournalEntry] = []
    var activeDays: Set<String> = []
    /// Clases completadas por cinturón (clave: id del cinturón).
    var dojoClasses: [String: Int] = [:]
    /// Puntos del examen marcados ("idCinturón-índice").
    var dojoExam: Set<String> = []
    /// Cinturones obtenidos.
    var dojoBelts: Set<Int> = []

    init() {}

    // Decodificación tolerante: si en una versión nueva se añaden campos,
    // el progreso guardado con la versión anterior se sigue cargando.
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        profile = try c.decodeIfPresent(Profile.self, forKey: .profile) ?? Profile()
        xp = try c.decodeIfPresent(Int.self, forKey: .xp) ?? 0
        completedTasks = try c.decodeIfPresent(Set<String>.self, forKey: .completedTasks) ?? []
        completedLessons = try c.decodeIfPresent(Set<String>.self, forKey: .completedLessons) ?? []
        scenarioBest = try c.decodeIfPresent([String: Int].self, forKey: .scenarioBest) ?? [:]
        kimBest = try c.decodeIfPresent(Int.self, forKey: .kimBest) ?? 0
        kimGames = try c.decodeIfPresent(Int.self, forKey: .kimGames) ?? 0
        workouts = try c.decodeIfPresent([WorkoutLog].self, forKey: .workouts) ?? []
        tests = try c.decodeIfPresent([FitnessTest].self, forKey: .tests) ?? []
        journal = try c.decodeIfPresent([JournalEntry].self, forKey: .journal) ?? []
        activeDays = try c.decodeIfPresent(Set<String>.self, forKey: .activeDays) ?? []
        dojoClasses = try c.decodeIfPresent([String: Int].self, forKey: .dojoClasses) ?? [:]
        dojoExam = try c.decodeIfPresent(Set<String>.self, forKey: .dojoExam) ?? []
        dojoBelts = try c.decodeIfPresent(Set<Int>.self, forKey: .dojoBelts) ?? []
    }
}

enum XP {
    static let task = 20
    static let lesson = 15
    static let workout = 30
    static let scenarioPerPoint = 10
    static let test = 25
    static let journal = 5
    static let dojoClass = 40
    static let belt = 150
}

final class ProgressStore: ObservableObject {
    @Published var state: AppState {
        didSet { save() }
    }

    private static var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("justiciero.json")
    }

    init() {
        if let data = try? Data(contentsOf: Self.fileURL),
           let decoded = try? JSONDecoder().decode(AppState.self, from: data) {
            state = decoded
        } else {
            state = AppState()
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(state)
            try data.write(to: Self.fileURL, options: .atomic)
        } catch {
            print("No se pudo guardar el progreso: \(error)")
        }
    }

    func reset() {
        state = AppState()
    }

    // MARK: Actividad y racha

    private static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    private func markActive(_ date: Date = .now) {
        state.activeDays.insert(Self.dayFormatter.string(from: date))
    }

    var streak: Int {
        let calendar = Calendar.current
        var day = Date.now
        // Si hoy aún no has hecho nada, la racha cuenta hasta ayer.
        if !state.activeDays.contains(Self.dayFormatter.string(from: day)) {
            day = calendar.date(byAdding: .day, value: -1, to: day) ?? day
        }
        var count = 0
        while state.activeDays.contains(Self.dayFormatter.string(from: day)) {
            count += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = previous
        }
        return count
    }

    var daysSinceStart: Int {
        let start = Calendar.current.startOfDay(for: state.profile.startDate)
        let today = Calendar.current.startOfDay(for: .now)
        return max(0, Calendar.current.dateComponents([.day], from: start, to: today).day ?? 0)
    }

    var programWeek: Int { daysSinceStart / 7 + 1 }

    // MARK: Rango

    var rank: Rank { Rank.forXP(state.xp) }

    var rankProgress: Double {
        guard let next = Rank.next(after: rank) else { return 1 }
        return Double(state.xp - rank.minXP) / Double(next.minXP - rank.minXP)
    }

    // MARK: Programa

    func isDone(_ task: ProgramTask) -> Bool {
        state.completedTasks.contains(task.id)
    }

    func toggle(_ task: ProgramTask) {
        if state.completedTasks.contains(task.id) {
            state.completedTasks.remove(task.id)
            state.xp = max(0, state.xp - XP.task)
        } else {
            state.completedTasks.insert(task.id)
            state.xp += XP.task
            markActive()
        }
    }

    func completion(of phase: Phase) -> Double {
        guard !phase.tasks.isEmpty else { return 0 }
        let done = phase.tasks.filter { state.completedTasks.contains($0.id) }.count
        return Double(done) / Double(phase.tasks.count)
    }

    /// Una fase se desbloquea al completar el 80 % de la anterior.
    func isUnlocked(_ phase: Phase) -> Bool {
        guard phase.id > 0, let previous = Phase.all.first(where: { $0.id == phase.id - 1 }) else { return true }
        return isUnlocked(previous) && completion(of: previous) >= 0.8
    }

    var currentPhase: Phase {
        Phase.all.last(where: { isUnlocked($0) }) ?? Phase.all[0]
    }

    /// Siguientes tareas pendientes de la fase actual, priorizando las de semanas anteriores.
    func nextTasks(limit: Int = 3) -> [ProgramTask] {
        Array(currentPhase.tasks.filter { !isDone($0) }.sorted { $0.week < $1.week }.prefix(limit))
    }

    // MARK: Academia

    func isLearned(_ lesson: Lesson) -> Bool {
        state.completedLessons.contains(lesson.id)
    }

    func completeLesson(_ lesson: Lesson) {
        guard !state.completedLessons.contains(lesson.id) else { return }
        state.completedLessons.insert(lesson.id)
        state.xp += XP.lesson
        markActive()
    }

    func learnedCount(in module: SkillModule) -> Int {
        module.lessons.filter { state.completedLessons.contains($0.id) }.count
    }

    /// Registra la puntuación de un escenario. Solo da XP por mejorar tu mejor marca.
    @discardableResult
    func recordScenario(_ scenario: Scenario, score: Int) -> Int {
        let best = state.scenarioBest[scenario.id] ?? 0
        markActive()
        guard score > best else {
            if state.scenarioBest[scenario.id] == nil { state.scenarioBest[scenario.id] = score }
            return 0
        }
        state.scenarioBest[scenario.id] = score
        let gained = (score - best) * XP.scenarioPerPoint
        state.xp += gained
        return gained
    }

    var optimalScenarios: Int {
        state.scenarioBest.values.filter { $0 == 2 }.count
    }

    @discardableResult
    func recordKim(percent: Int) -> Int {
        state.kimGames += 1
        state.kimBest = max(state.kimBest, percent)
        let gained = percent / 5
        state.xp += gained
        markActive()
        return gained
    }

    // MARK: Entreno

    func logWorkout(_ workout: Workout, minutes: Int) {
        state.workouts.insert(WorkoutLog(workoutID: workout.id, name: workout.name, minutes: minutes), at: 0)
        state.xp += XP.workout
        markActive()
    }

    func doneToday(_ workout: Workout) -> Bool {
        state.workouts.contains { $0.workoutID == workout.id && Calendar.current.isDateInToday($0.date) }
    }

    var workoutsThisWeek: Int {
        guard let weekStart = Calendar.current.dateInterval(of: .weekOfYear, for: .now)?.start else { return 0 }
        return state.workouts.filter { $0.date >= weekStart }.count
    }

    func addTest(_ test: FitnessTest) {
        state.tests.append(test)
        state.tests.sort { $0.date < $1.date }
        state.xp += XP.test
        markActive()
    }

    // MARK: Dojo

    func classesDone(_ belt: Belt) -> Int {
        state.dojoClasses[String(belt.id)] ?? 0
    }

    func hasBelt(_ belt: Belt) -> Bool {
        state.dojoBelts.contains(belt.id)
    }

    /// Un cinturón se desbloquea al obtener el anterior.
    func isUnlocked(_ belt: Belt) -> Bool {
        belt.id == 0 || state.dojoBelts.contains(belt.id - 1)
    }

    /// Cinturón en el que estás entrenando ahora.
    var currentBelt: Belt {
        Belt.all.first(where: { !hasBelt($0) }) ?? Belt.all[Belt.all.count - 1]
    }

    func logDojoClass(_ belt: Belt) {
        state.dojoClasses[String(belt.id), default: 0] += 1
        state.xp += XP.dojoClass
        markActive()
    }

    func isExamChecked(_ belt: Belt, _ index: Int) -> Bool {
        state.dojoExam.contains("\(belt.id)-\(index)")
    }

    func toggleExam(_ belt: Belt, _ index: Int) {
        let key = "\(belt.id)-\(index)"
        if state.dojoExam.contains(key) { state.dojoExam.remove(key) } else { state.dojoExam.insert(key) }
    }

    func canEarn(_ belt: Belt) -> Bool {
        !hasBelt(belt) && isUnlocked(belt) && classesDone(belt) >= belt.minClasses
            && belt.exam.indices.allSatisfy { isExamChecked(belt, $0) }
    }

    func earn(_ belt: Belt) {
        guard canEarn(belt) else { return }
        state.dojoBelts.insert(belt.id)
        state.xp += XP.belt
        markActive()
    }

    // MARK: Bitácora

    func addJournal(_ entry: JournalEntry) {
        state.journal.insert(entry, at: 0)
        state.xp += XP.journal
        markActive()
    }

    func deleteJournal(at offsets: IndexSet) {
        state.journal.remove(atOffsets: offsets)
    }
}
