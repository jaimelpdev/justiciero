import Foundation

/// Monta las sesiones del plan personalizado a partir de las respuestas del cuestionario.
/// La misma lógica está copiada en web/app.js (busca «PlanEngine»): si cambias una, cambia la otra.
enum PlanEngine {
    static let totalWeeks = 12

    /// Días de entreno (lunes = 0) y tipo de sesión según los días por semana.
    static func schedule(days: Int) -> [(day: Int, kind: String)] {
        switch days {
        case 4: [(day: 0, kind: "A"), (day: 1, kind: "B"), (day: 3, kind: "C"), (day: 5, kind: "D")]
        case 5: [(day: 0, kind: "A"), (day: 1, kind: "B"), (day: 2, kind: "C"), (day: 4, kind: "E"), (day: 5, kind: "D")]
        default: [(day: 0, kind: "A"), (day: 2, kind: "B"), (day: 4, kind: "C")]
        }
    }

    static func kindName(_ kind: String) -> String {
        switch kind {
        case "A": "Fuerza · Empuje y piernas"
        case "B": "Fuerza · Tirón y cadera"
        case "C": "Combate y condición"
        case "D": "Resistencia"
        default: "Cuerpo completo"
        }
    }

    static func kindIcon(_ kind: String) -> String {
        switch kind {
        case "A": "figure.strengthtraining.traditional"
        case "B": "figure.climbing"
        case "C": "figure.boxing"
        case "D": "figure.run"
        default: "figure.cross.training"
        }
    }

    private static func monday(of date: Date) -> Date {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: date)
        let offset = (calendar.component(.weekday, from: day) + 5) % 7
        return calendar.date(byAdding: .day, value: -offset, to: day) ?? day
    }

    /// Semana del plan (1 = la semana en la que lo creaste). 0 si la fecha es anterior.
    static func week(_ answers: PlanAnswers, on date: Date) -> Int {
        let days = Calendar.current.dateComponents([.day], from: monday(of: answers.start), to: monday(of: date)).day ?? 0
        return days < 0 ? 0 : days / 7 + 1
    }

    static func weekday(_ date: Date) -> Int {
        (Calendar.current.component(.weekday, from: date) + 5) % 7
    }

    /// Sesión que toca ese día, o nil si es día de descanso.
    static func session(_ answers: PlanAnswers, on date: Date) -> Workout? {
        let number = week(answers, on: date)
        let today = weekday(date)
        guard number > 0, let slot = schedule(days: answers.days).first(where: { $0.day == today }) else { return nil }
        return build(answers, week: number, kind: slot.kind)
    }

    struct PlanDay: Identifiable {
        let day: Int
        let workout: Workout
        var id: Int { day }
    }

    /// Sesiones de una semana del plan.
    static func sessions(_ answers: PlanAnswers, week: Int) -> [PlanDay] {
        schedule(days: answers.days).map { PlanDay(day: $0.day, workout: build(answers, week: week, kind: $0.kind)) }
    }

    /// Reconstruye una sesión a partir de su id ("plan-w3-A").
    static func workout(id: String, answers: PlanAnswers) -> Workout? {
        let parts = id.split(separator: "-")
        guard parts.count == 3, parts[0] == "plan", parts[1].hasPrefix("w"), let number = Int(parts[1].dropFirst()) else { return nil }
        return build(answers, week: number, kind: String(parts[2]))
    }

    /// Tras la semana 12 se repite el último bloque como mantenimiento.
    static func cycleWeek(_ week: Int) -> Int {
        week <= totalWeeks ? week : 9 + (week - 9) % 4
    }

    static func build(_ a: PlanAnswers, week: Int, kind: String) -> Workout {
        let w = cycleWeek(max(week, 1))
        let block = (w - 1) / 4
        let deload = (w - 1) % 4 == 3
        let step = deload ? 0 : (w - 1) % 4
        let focus = week > totalWeeks
            ? "Semana \(week) · Mantenimiento (repites el bloque Rendimiento)"
            : "Semana \(week) de \(totalWeeks) · Bloque \(PlanData.blocks[block])\(deload ? " · descarga" : "")"
        let note = deload ? PlanData.deloadNote : PlanData.blockNotes[block]
        let id = "plan-w\(week)-\(kind)"

        if kind == "D" { return run(a, id: id, focus: focus, note: note, week: w, deload: deload) }

        let baseSets = a.minutes >= 45 ? 4 : a.minutes >= 25 ? 3 : 2
        let count = a.minutes >= 45 ? 7 : a.minutes >= 35 ? 6 : a.minutes >= 25 ? 5 : 4
        let strengthRest = a.goal == .grasa ? 40 : a.goal == .musculo ? 75 : 60
        let fastRest = a.goal == .grasa ? 20 : 30

        var slots: [String]
        switch kind {
        case "A": slots = ["push", "leg", "push2", "core", "cardio", "hinge", "core2"]
        case "B": slots = a.pullupBar
            ? ["pullBar", "hinge", "pull", "core", "cardio", "leg", "back"]
            : ["pull", "hinge", "back", "core", "cardio", "leg", "core2"]
        case "C": slots = ["combat0", "cardio", "combat2", "combat1", "core", "combat3", "core2"]
        default: slots = ["leg", "push", a.pullupBar ? "pullBar" : "pull", "hinge", "core", "cardio", "push2"]
        }
        // Para perder grasa, el cardio entra siempre aunque la sesión sea corta.
        if a.goal == .grasa, kind != "C", let i = slots.firstIndex(of: "cardio") {
            slots.remove(at: i)
            slots.insert("cardio", at: 1)
        }

        var blocks = [WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 90, rest: 10)]
        for slot in slots.prefix(count) {
            let move = pick(slot, answers: a, block: block)
            let fast = slot == "cardio" || slot.hasPrefix("combat")
            let core = slot == "core" || slot == "core2" || slot == "back"
            let sets = max(1, baseSets + (emphasized(slot, a.focus) ? 1 : 0) - (deload ? 1 : 0))
            let rest = fast ? fastRest : core ? max(30, strengthRest - 15) : strengthRest
            if let seconds = move.seconds {
                blocks.append(WorkoutBlock(exercise: move.exercise, sets: sets, reps: nil, seconds: seconds + 5 * step, rest: rest))
            } else {
                let base = move.reps ?? 8
                let reps = base + step * (base <= 6 ? 1 : 2)
                blocks.append(WorkoutBlock(exercise: move.exercise, sets: sets, reps: move.perSide ? "\(reps)/lado" : "\(reps)", seconds: nil, rest: rest))
            }
        }

        return Workout(id: id, name: kindName(kind), focus: focus, place: "Casa", minPhase: 0,
                       minutes: estimate(blocks), notes: note, blocks: blocks)
    }

    private static func run(_ a: PlanAnswers, id: String, focus: String, note: String, week w: Int, deload: Bool) -> Workout {
        var blocks = [WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 90, rest: 10)]
        let available = max(10, a.minutes - 5) * 60
        var runNote = "Por zonas iluminadas o de día. "
        if a.lowImpact {
            blocks.append(WorkoutBlock(exercise: Exercises.briskWalk, sets: 1, reps: nil, seconds: deload ? available * 3 / 4 : available, rest: 0))
            runNote += "Caminata rápida: sin impacto para tus articulaciones."
        } else if a.level <= 1 || (w <= 4 && a.level == 2) {
            let runS = min(300, 60 + 30 * (w - 1))
            let walkS = w <= 4 ? 90 : 60
            let rounds = max(2, available / (runS + walkS) - (deload ? 1 : 0))
            blocks.append(WorkoutBlock(exercise: Exercises.easyRun, sets: rounds, reps: nil, seconds: runS, rest: walkS))
            runNote += "Intervalos de carrera: en cada descanso, camina en vez de pararte."
        } else {
            blocks.append(WorkoutBlock(exercise: Exercises.warmJog, sets: 1, reps: nil, seconds: 300, rest: 0))
            let main = max(300, available - 300 - 240 - (deload ? 300 : 0))
            blocks.append(WorkoutBlock(exercise: Exercises.easyRun, sets: 1, reps: nil, seconds: main / 60 * 60, rest: 60))
            blocks.append(WorkoutBlock(exercise: Exercises.strides, sets: 4, reps: nil, seconds: 20, rest: 40))
            runNote += "Carrera continua a ritmo de conversación y 4 progresivos al final."
        }
        return Workout(id: id, name: kindName("D"), focus: focus, place: "Exterior", minPhase: 0,
                       minutes: estimate(blocks), notes: "\(runNote) \(note)", blocks: blocks)
    }

    private static func ladder(_ slot: String) -> [PlanMove] {
        switch slot {
        case "push": PlanData.push
        case "push2": PlanData.push2
        case "pull": PlanData.pull
        case "pullBar": PlanData.pullBar
        case "back": PlanData.back
        case "leg": PlanData.leg
        case "hinge": PlanData.hinge
        case "core": PlanData.core
        case "core2": PlanData.core2
        default: PlanData.cardio
        }
    }

    private static func pick(_ slot: String, answers a: PlanAnswers, block: Int) -> PlanMove {
        if slot.hasPrefix("combat"), let i = Int(slot.dropFirst(6)) {
            let move = PlanData.combat[i]
            return a.lowImpact && move.impact ? PlanData.cardio[0] : move
        }
        let moves = ladder(slot).filter { !(a.lowImpact && $0.impact) }
        return moves[min(a.level + block, moves.count - 1)]
    }

    private static func emphasized(_ slot: String, _ focus: Set<PlanFocus>) -> Bool {
        switch slot {
        case "push", "push2": focus.contains(.pecho)
        case "pull", "pullBar", "back": focus.contains(.espalda)
        case "leg", "hinge": focus.contains(.piernas)
        case "core", "core2": focus.contains(.abdomen)
        default: focus.contains(.resistencia)
        }
    }

    /// Duración aproximada: unos 3 s por repetición más los descansos.
    static func estimate(_ blocks: [WorkoutBlock]) -> Int {
        let seconds = blocks.reduce(0) { total, b in
            let reps = Int(b.reps?.prefix { $0.isNumber } ?? "") ?? 0
            let work = b.seconds ?? reps * 3 * (b.reps?.contains("lado") == true ? 2 : 1)
            return total + b.sets * (work + b.rest)
        }
        return max(10, Int((Double(seconds) / 60).rounded()))
    }

    // MARK: Nutrición

    struct Nutrition {
        let bmi: Double
        let kcal: Int
        let protein: Int
        let fat: Int
        let carbs: Int
        let waterLiters: Double
        let weeksToTarget: Int
    }

    static func nutrition(_ a: PlanAnswers, weight: Double) -> Nutrition {
        let height = Double(a.heightCm)
        let bmi = weight / pow(height / 100, 2)
        let bmr = 10 * weight + 6.25 * height - 5 * Double(a.age) + (a.sex == .hombre ? 5 : -161)
        let tdee = bmr * (a.days >= 4 ? 1.55 : 1.375)
        let adult = a.age >= 18
        let factor = !adult ? 1 : a.goal == .grasa ? 0.85 : a.goal == .musculo ? 1.1 : 1
        let floor: Double = a.sex == .hombre ? 1500 : 1200
        let kcal = Int((max(tdee * factor, floor) / 50).rounded()) * 50
        let reference = bmi > 30 ? a.targetKg : weight
        let protein = Int((1.8 * reference).rounded())
        let fat = Int((0.8 * reference).rounded())
        let carbs = max(0, (kcal - protein * 4 - fat * 9) / 4)
        let water = (weight * 0.035 * 10).rounded() / 10
        let diff = a.targetKg - weight
        let weeks = abs(diff) < 0.5 ? 0 : Int((abs(diff) / (diff < 0 ? 0.5 : 0.25)).rounded(.up))
        return Nutrition(bmi: bmi, kcal: kcal, protein: protein, fat: fat, carbs: carbs, waterLiters: water, weeksToTarget: weeks)
    }

    static func bmiLabel(_ bmi: Double) -> String {
        switch bmi {
        case ..<18.5: "Bajo peso"
        case ..<25: "Normal"
        case ..<30: "Sobrepeso"
        default: "Obesidad"
        }
    }
}
