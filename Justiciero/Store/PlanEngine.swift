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
        let today = weekday(date)
        guard week(answers, on: date) > 0, let slot = schedule(days: answers.days).first(where: { $0.day == today }) else { return nil }
        return build(answers, date: date, kind: slot.kind)
    }

    struct PlanDay: Identifiable {
        let day: Int
        let date: Date
        let workout: Workout
        var id: Int { day }
    }

    /// Sesiones de una semana del plan.
    static func sessions(_ answers: PlanAnswers, week: Int) -> [PlanDay] {
        let first = Calendar.current.date(byAdding: .day, value: (week - 1) * 7, to: monday(of: answers.start)) ?? answers.start
        return schedule(days: answers.days).compactMap { slot in
            guard let date = Calendar.current.date(byAdding: .day, value: slot.day, to: first) else { return nil }
            return PlanDay(day: slot.day, date: date, workout: build(answers, date: date, kind: slot.kind))
        }
    }

    static func dayNumber(_ date: Date) -> Int {
        let c = Calendar.current.dateComponents([.year, .month, .day], from: date)
        return (c.year ?? 2000) * 10000 + (c.month ?? 1) * 100 + (c.day ?? 1)
    }

    static func date(fromDayNumber n: Int) -> Date? {
        Calendar.current.date(from: DateComponents(year: n / 10000, month: n / 100 % 100, day: n % 100, hour: 12))
    }

    /// Reconstruye una sesión a partir de su id ("plan-d20261110-A").
    static func workout(id: String, answers: PlanAnswers) -> Workout? {
        let parts = id.split(separator: "-")
        guard parts.count == 3, parts[0] == "plan", parts[1].hasPrefix("d"),
              let n = Int(parts[1].dropFirst()), let date = date(fromDayNumber: n) else { return nil }
        return build(answers, date: date, kind: String(parts[2]))
    }

    /// Tras la semana 12 se repite el último bloque como mantenimiento.
    static func cycleWeek(_ week: Int) -> Int {
        week <= totalWeeks ? week : 9 + (week - 9) % 4
    }

    /// Generador pseudoaleatorio con semilla (mulberry32). Igual que en la web, para que
    /// el mismo día salga la misma sesión en el iPhone y en la web.
    struct Seeded {
        var state: UInt32
        mutating func next() -> Double {
            state = state &+ 0x6D2B79F5
            var t = state
            t = (t ^ (t >> 15)) &* (1 | t)
            t = (t &+ ((t ^ (t >> 7)) &* (61 | t))) ^ t
            return Double(t ^ (t >> 14)) / 4_294_967_296
        }
        mutating func index(_ count: Int) -> Int { min(count - 1, Int(next() * Double(count))) }
    }

    static let formats = ["series", "circuito", "superseries"]

    static func formatName(_ format: String?) -> String? {
        switch format {
        case "circuito": "Circuito"
        case "superseries": "Superseries"
        default: nil
        }
    }

    static func formatNote(_ format: String?) -> String? {
        switch format {
        case "circuito": "Hoy en circuito: haz un ejercicio detrás de otro descansando solo 15 s y descansa al terminar cada vuelta."
        case "superseries": "Hoy en superseries: ejercicios por parejas, uno detrás de otro, y descansas después de la pareja."
        default: nil
        }
    }

    static func build(_ a: PlanAnswers, date: Date, kind: String) -> Workout {
        let weekNumber = max(1, week(a, on: date))
        let w = cycleWeek(weekNumber)
        let block = (w - 1) / 4
        let deload = (w - 1) % 4 == 3
        let step = deload ? 0 : (w - 1) % 4
        let focus = weekNumber > totalWeeks
            ? "Semana \(weekNumber) · Mantenimiento (repites el bloque Rendimiento)"
            : "Semana \(weekNumber) de \(totalWeeks) · Bloque \(PlanData.blocks[block])\(deload ? " · descarga" : "")"
        let note = deload ? PlanData.deloadNote : PlanData.blockNotes[block]
        let id = "plan-d\(dayNumber(date))-\(kind)"
        var rng = Seeded(state: UInt32(dayNumber(date)))

        if kind == "D" { return run(a, id: id, focus: focus, note: note, week: w, deload: deload, rng: &rng) }

        let format = formats[rng.index(formats.count)]
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
        var chosen = Array(slots.prefix(count))
        // Cada día cambia el orden (el primer ejercicio, el principal, se queda el primero).
        if chosen.count > 2 {
            for i in stride(from: chosen.count - 1, to: 1, by: -1) {
                let j = 1 + rng.index(i)
                chosen.swapAt(i, j)
            }
        }

        var blocks = [WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 90, rest: 10)]
        for slot in chosen {
            let (move, easier) = pick(slot, answers: a, block: block, rng: &rng)
            let fast = slot == "cardio" || slot.hasPrefix("combat")
            let core = slot == "core" || slot == "core2" || slot == "back"
            let sets = max(1, baseSets + (emphasized(slot, a.focus) ? 1 : 0) - (deload ? 1 : 0))
            let rest = fast ? fastRest : core ? max(30, strengthRest - 15) : strengthRest
            if let seconds = move.seconds {
                blocks.append(WorkoutBlock(exercise: move.exercise, sets: sets, reps: nil, seconds: seconds + 5 * step + (easier ? 10 : 0), rest: rest))
            } else {
                let base = move.reps ?? 8
                let reps = base + step * (base <= 6 ? 1 : 2) + (easier ? 2 : 0)
                blocks.append(WorkoutBlock(exercise: move.exercise, sets: sets, reps: move.perSide ? "\(reps)/lado" : "\(reps)", seconds: nil, rest: rest))
            }
        }

        let name = [kindName(kind), formatName(format)].compactMap { $0 }.joined(separator: " · ")
        let notes = [formatNote(format), note].compactMap { $0 }.joined(separator: " ")
        let workout = Workout(id: id, name: name, focus: focus, place: "Casa", minPhase: 0,
                              minutes: 0, notes: notes, blocks: blocks, format: format == "series" ? nil : format)
        return Workout(id: id, name: name, focus: focus, place: "Casa", minPhase: 0,
                       minutes: estimate(expanded(workout).blocks), notes: notes, blocks: blocks, format: workout.format)
    }

    /// Bloques en el orden en que se hacen: los circuitos y superseries se despliegan serie a serie.
    static func expanded(_ w: Workout) -> Workout {
        guard let format = w.format, w.blocks.count > 1 else { return w }
        let warm = w.blocks[0]
        let main = Array(w.blocks.dropFirst())
        var out = [warm]
        let one = { (b: WorkoutBlock, rest: Int) in WorkoutBlock(exercise: b.exercise, sets: 1, reps: b.reps, seconds: b.seconds, rest: rest) }
        if format == "circuito" {
            let rounds = main.map(\.sets).max() ?? 1
            for round in 0..<rounds {
                let inRound = main.filter { $0.sets > round }
                for (i, b) in inRound.enumerated() {
                    out.append(one(b, i == inRound.count - 1 ? (round == rounds - 1 ? 0 : 75) : 15))
                }
            }
        } else {
            for start in stride(from: 0, to: main.count, by: 2) {
                let pair = Array(main[start..<min(start + 2, main.count)])
                let sets = pair.map(\.sets).max() ?? 1
                for s in 0..<sets {
                    let active = pair.filter { $0.sets > s }
                    for (i, b) in active.enumerated() {
                        out.append(one(b, i == active.count - 1 ? b.rest : 10))
                    }
                }
            }
        }
        return Workout(id: w.id, name: w.name, focus: w.focus, place: w.place, minPhase: w.minPhase,
                       minutes: w.minutes, notes: w.notes, blocks: out, format: nil)
    }

    private static func run(_ a: PlanAnswers, id: String, focus: String, note: String, week w: Int, deload: Bool, rng: inout Seeded) -> Workout {
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
            let strides = 4 + 2 * rng.index(2)
            blocks.append(WorkoutBlock(exercise: Exercises.strides, sets: strides, reps: nil, seconds: 20, rest: 40))
            runNote += "Carrera continua a ritmo de conversación y \(strides) progresivos al final."
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

    /// Elige el ejercicio del día para un hueco. Devuelve también si es una variante más fácil
    /// (a la que se le suman repeticiones o segundos).
    private static func pick(_ slot: String, answers a: PlanAnswers, block: Int, rng: inout Seeded) -> (PlanMove, Bool) {
        if slot.hasPrefix("combat"), let i = Int(slot.dropFirst(6)) {
            let move = PlanData.combat[i]
            return (a.lowImpact && move.impact ? PlanData.cardio[0] : move, false)
        }
        let moves = ladder(slot).filter { !(a.lowImpact && $0.impact) }
        let top = min(a.level + block, moves.count - 1)
        if slot == "cardio" || slot == "core" {
            return (moves[rng.index(top + 1)], false)
        }
        let easier = top > 0 && rng.next() < 0.35
        return (moves[easier ? top - 1 : top], easier)
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
