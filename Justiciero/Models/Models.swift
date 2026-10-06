import SwiftUI

// MARK: - Programa

enum TaskCategory: String, Codable, CaseIterable {
    case fisico, mente, ley, habilidad, comunidad, equipo

    var label: String {
        switch self {
        case .fisico: "Físico"
        case .mente: "Mente"
        case .ley: "Ley"
        case .habilidad: "Habilidad"
        case .comunidad: "Comunidad"
        case .equipo: "Equipo"
        }
    }

    var icon: String {
        switch self {
        case .fisico: "figure.run"
        case .mente: "brain.head.profile"
        case .ley: "building.columns.fill"
        case .habilidad: "cross.case.fill"
        case .comunidad: "person.3.fill"
        case .equipo: "backpack.fill"
        }
    }

    var color: Color {
        switch self {
        case .fisico: Color.orange
        case .mente: Color.purple
        case .ley: Theme.info
        case .habilidad: Theme.danger
        case .comunidad: Theme.success
        case .equipo: Theme.accent
        }
    }
}

struct ProgramTask: Identifiable, Hashable {
    let id: String
    let week: Int
    let category: TaskCategory
    let title: String
    let detail: String

    init(_ id: String, _ week: Int, _ category: TaskCategory, _ title: String, _ detail: String) {
        self.id = id
        self.week = week
        self.category = category
        self.title = title
        self.detail = detail
    }
}

struct Phase: Identifiable {
    let id: Int
    let codename: String
    let title: String
    let weeks: ClosedRange<Int>
    let icon: String
    let location: String
    let summary: String
    let whyThisOrder: String
    let objectives: [String]
    let safetyRules: [String]
    let minorNote: String?
    let tasks: [ProgramTask]

    var weeksLabel: String {
        if id == Phase.all.last?.id { return "Semana \(weeks.lowerBound)+" }
        return "Semanas \(weeks.lowerBound)–\(weeks.upperBound)"
    }
}

// MARK: - Rangos

struct Rank: Identifiable, Equatable {
    var id: String { name }
    let name: String
    let minXP: Int
    let icon: String
    let motto: String

    static let all: [Rank] = [
        Rank(name: "Recluta", minXP: 0, icon: "person.fill", motto: "Todo héroe empezó sin saber nada."),
        Rank(name: "Aprendiz", minXP: 400, icon: "figure.walk", motto: "La disciplina empieza a notarse."),
        Rank(name: "Centinela", minXP: 1000, icon: "eye.fill", motto: "Ves lo que otros no ven."),
        Rank(name: "Vigilante", minXP: 2000, icon: "shield.lefthalf.filled", motto: "Preparado para actuar con cabeza."),
        Rank(name: "Guardián", minXP: 3500, icon: "shield.fill", motto: "Tu barrio está mejor contigo en él."),
        Rank(name: "Caballero de la Noche", minXP: 5500, icon: "moon.stars.fill", motto: "No necesitas máscara: la gente sabe quién eres."),
    ]

    static func forXP(_ xp: Int) -> Rank {
        all.last(where: { xp >= $0.minXP }) ?? all[0]
    }

    static func next(after rank: Rank) -> Rank? {
        guard let index = all.firstIndex(of: rank), index + 1 < all.count else { return nil }
        return all[index + 1]
    }
}

// MARK: - Entrenamiento

struct Exercise: Identifiable, Hashable {
    let id: String
    let name: String
    let icon: String
    let howTo: String
    let easier: String
}

struct WorkoutBlock: Identifiable, Hashable {
    var id: String { exercise.id + "-\(sets)-\(reps ?? "")-\(seconds ?? 0)" }
    let exercise: Exercise
    let sets: Int
    /// Repeticiones (texto libre: "12", "máx", "10/pierna"). Nil si es por tiempo.
    let reps: String?
    /// Duración de cada serie en segundos. Nil si es por repeticiones.
    let seconds: Int?
    let rest: Int

    var prescription: String {
        if let seconds {
            let time = seconds >= 60 ? "\(seconds / 60) min" : "\(seconds) s"
            return "\(sets) × \(time)"
        }
        return "\(sets) × \(reps ?? "")"
    }
}

struct Workout: Identifiable, Hashable {
    let id: String
    let name: String
    let focus: String
    let place: String
    let minPhase: Int
    let minutes: Int
    let notes: String?
    let blocks: [WorkoutBlock]
}

// MARK: - Academia

enum LessonBlock: Hashable {
    case heading(String)
    case paragraph(String)
    case bullets([String])
    case steps([String])
    case tip(String)
    case warning(String)
    case danger(String)
}

struct Lesson: Identifiable, Hashable {
    let id: String
    let title: String
    let minutes: Int
    let blocks: [LessonBlock]
}

struct SkillModule: Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String
    let colorName: String
    let intro: String
    let lessons: [Lesson]

    var color: Color {
        switch colorName {
        case "red": Theme.danger
        case "blue": Theme.info
        case "green": Theme.success
        case "purple": Color.purple
        case "orange": Color.orange
        case "teal": Color.teal
        case "pink": Color.pink
        default: Theme.accent
        }
    }
}

struct ScenarioOption: Identifiable, Hashable {
    var id: String { text }
    let text: String
    /// 0 = peligrosa o ilegal, 1 = mejorable, 2 = óptima
    let score: Int
    let feedback: String
}

struct Scenario: Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String
    let situation: String
    let options: [ScenarioOption]
    let lesson: String
}

// MARK: - Equipo

enum GearStatus: String {
    case recomendado, condicionado, prohibido

    var label: String {
        switch self {
        case .recomendado: "Recomendado"
        case .condicionado: "Con condiciones"
        case .prohibido: "No llevar"
        }
    }

    var color: Color {
        switch self {
        case .recomendado: Theme.success
        case .condicionado: Theme.accent
        case .prohibido: Theme.danger
        }
    }

    var icon: String {
        switch self {
        case .recomendado: "checkmark.seal.fill"
        case .condicionado: "exclamationmark.triangle.fill"
        case .prohibido: "xmark.octagon.fill"
        }
    }
}

struct GearItem: Identifiable {
    var id: String { name }
    let name: String
    let icon: String
    let status: GearStatus
    let why: String
}

struct CodeRule: Identifiable {
    var id: Int { number }
    let number: Int
    let title: String
    let text: String
}

// MARK: - Dojo

enum TechniqueKind: String, CaseIterable {
    case postura, golpe, patada, defensa, suelo, caida, autodefensa

    var label: String {
        switch self {
        case .postura: "Postura y movimiento"
        case .golpe: "Golpes"
        case .patada: "Piernas"
        case .defensa: "Defensa"
        case .suelo: "Suelo"
        case .caida: "Caídas"
        case .autodefensa: "Autodefensa"
        }
    }

    var icon: String {
        switch self {
        case .postura: "figure.stand"
        case .golpe: "figure.boxing"
        case .patada: "figure.kickboxing"
        case .defensa: "shield.lefthalf.filled"
        case .suelo: "figure.wrestling"
        case .caida: "figure.fall"
        case .autodefensa: "hand.raised.fill"
        }
    }
}

struct Technique: Identifiable, Hashable {
    let id: String
    let name: String
    let kind: TechniqueKind
    let summary: String
    let steps: [String]
    let errors: [String]
    let drill: String
    /// Variante opcional con compañero (siempre lenta y controlada), si la hay.
    let partner: String?
}

enum RoundKind: String {
    case calentamiento, tecnica, sombra, suelo, acondicionamiento, calma

    var label: String {
        switch self {
        case .calentamiento: "Calentamiento"
        case .tecnica: "Técnica"
        case .sombra: "Sombra"
        case .suelo: "Suelo"
        case .acondicionamiento: "Acondicionamiento"
        case .calma: "Vuelta a la calma"
        }
    }

    var icon: String {
        switch self {
        case .calentamiento: "flame"
        case .tecnica: "scope"
        case .sombra: "figure.boxing"
        case .suelo: "figure.wrestling"
        case .acondicionamiento: "bolt.heart.fill"
        case .calma: "wind"
        }
    }
}

struct DojoRound: Hashable {
    let title: String
    let kind: RoundKind
    /// Duración de cada asalto en segundos.
    let seconds: Int
    let repeats: Int
    let rest: Int
    let cue: String
    /// Combinaciones que el entrenador va cantando al azar durante el asalto.
    let calls: [String]
    /// Segundos entre cada combinación cantada.
    let pace: Int
}

struct Belt: Identifiable, Hashable {
    let id: Int
    let name: String
    let colorHex: String
    let theme: String
    let goal: String
    let minClasses: Int
    let techniques: [String]
    let exam: [String]
    let rounds: [DojoRound]

    var color: Color { Color(hex: colorHex) }
    var minutes: Int { rounds.reduce(0) { $0 + ($1.seconds * $1.repeats + $1.rest * max(0, $1.repeats - 1)) } / 60 }
}

extension Color {
    init(hex: String) {
        let value = UInt64(hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")), radix: 16) ?? 0xFFFFFF
        self.init(red: Double((value >> 16) & 0xFF) / 255,
                  green: Double((value >> 8) & 0xFF) / 255,
                  blue: Double(value & 0xFF) / 255)
    }
}

// MARK: - Hábitos

enum DayBlock: String, CaseIterable {
    case manana, tarde, noche

    var label: String {
        switch self {
        case .manana: "Mañana"
        case .tarde: "Tarde"
        case .noche: "Noche"
        }
    }

    var icon: String {
        switch self {
        case .manana: "sunrise.fill"
        case .tarde: "sun.max.fill"
        case .noche: "moon.fill"
        }
    }
}

enum HabitKind: String {
    case habito, entreno, dojo, leccion, mision, kim, escenario, bitacora, test, salida, voluntariado, descanso

    /// Las tareas de estos tipos se marcan solas al hacerlas en la app.
    var isAutomatic: Bool {
        switch self {
        case .entreno, .dojo, .leccion, .mision, .kim, .escenario, .bitacora, .test: true
        default: false
        }
    }
}

struct HabitItem: Identifiable, Hashable {
    let id: String
    let block: DayBlock
    let kind: HabitKind
    let title: String
    let detail: String
    let minutes: Int
    /// Para tareas de entreno: el id de la sesión.
    let workout: String?
}

struct WeekTemplate {
    let minPhase: Int
    /// 7 días, de lunes a domingo.
    let days: [[HabitItem]]
}
