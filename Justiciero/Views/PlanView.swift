import SwiftUI
import Charts

// MARK: - Cuestionario

struct PlanQuizView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss
    @State private var answers: PlanAnswers
    @State private var step = 0

    private let steps = 9

    init(initial: PlanAnswers? = nil) {
        _answers = State(initialValue: initial ?? PlanAnswers())
    }

    var body: some View {
        VStack(spacing: 0) {
            ProgressBar(value: Double(step + 1) / Double(steps))
                .padding(.horizontal)
                .padding(.top, 8)
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    page
                }
                .padding()
            }
            HStack(spacing: 12) {
                if step > 0 {
                    Button("Atrás") { withAnimation { step -= 1 } }
                        .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                }
                Button(step == steps - 1 ? "Crear mi plan" : "Siguiente") {
                    if step == steps - 1 {
                        store.setPlan(answers)
                        dismiss()
                    } else {
                        withAnimation { step += 1 }
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Tu plan · \(step + 1)/\(steps)")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var page: some View {
        switch step {
        case 0:
            title("¿Cuál es tu objetivo?", PlanData.intro)
            ForEach(PlanGoal.allCases) { goal in
                option(goal.label, goal.detail, icon: goal.icon, selected: answers.goal == goal) { answers.goal = goal }
            }
        case 1:
            title("¿Qué zonas quieres reforzar?", "Elige las que quieras: tendrán una serie extra.")
            ForEach(PlanFocus.allCases) { focus in
                option(focus.label, nil, icon: focus.icon, selected: answers.focus.contains(focus)) {
                    if answers.focus.contains(focus) { answers.focus.remove(focus) } else { answers.focus.insert(focus) }
                }
            }
        case 2:
            title("¿Cuántas flexiones puedes hacer seguidas?", "Con buena técnica, sin apoyar las rodillas. Sé sincero: el plan sube de nivel solo.")
            ForEach(PlanAnswers.levels.indices, id: \.self) { i in
                option(PlanAnswers.levels[i], PlanAnswers.levelNames[i], icon: "figure.strengthtraining.traditional", selected: answers.level == i) { answers.level = i }
            }
        case 3:
            title("¿Cuántos días a la semana?", "Contando solo el entreno físico. Las clases del Dojo y los hábitos siguen en tu plan diario.")
            ForEach([3, 4, 5], id: \.self) { days in
                option("\(days) días", days == 3 ? "Lunes, miércoles y viernes" : days == 4 ? "Lunes, martes, jueves y sábado" : "De lunes a sábado menos el jueves",
                       icon: "calendar", selected: answers.days == days) { answers.days = days }
            }
        case 4:
            title("¿Cuánto tiempo por sesión?", nil)
            ForEach([15, 25, 35, 45], id: \.self) { minutes in
                option("\(minutes) minutos", minutes == 15 ? "Rápida, para días con poco tiempo" : minutes == 45 ? "Completa, para progresar más rápido" : nil,
                       icon: "clock", selected: answers.minutes == minutes) { answers.minutes = minutes }
            }
        case 5:
            title("¿Tienes barra de dominadas?", "Una barra de puerta cuesta unos 20 €. Sin ella, la espalda se trabaja con remos con toalla y bajo una mesa robusta.")
            option("Sí, tengo barra", nil, icon: "figure.climbing", selected: answers.pullupBar) { answers.pullupBar = true }
            option("No, solo mi cuerpo", nil, icon: "figure.stand", selected: !answers.pullupBar) { answers.pullupBar = false }
        case 6:
            title("¿Puedes saltar?", "Si te molestan las rodillas, vives en un piso con vecinos abajo o tienes mucho peso que perder, mejor sin impacto.")
            option("Sí, con saltos", nil, icon: "figure.jumprope", selected: !answers.lowImpact) { answers.lowImpact = false }
            option("Sin impacto", "Cambia saltos y carrera por alternativas suaves", icon: "figure.walk", selected: answers.lowImpact) { answers.lowImpact = true }
        case 7:
            title("Tus datos", "Para calcular tus calorías y tu progreso. Solo se guardan en tu móvil.")
            VStack(spacing: 12) {
                Picker("Sexo", selection: $answers.sex) {
                    Text("Hombre").tag(PlanSex.hombre)
                    Text("Mujer").tag(PlanSex.mujer)
                }
                .pickerStyle(.segmented)
                Stepper("Edad: \(answers.age) años", value: $answers.age, in: 14...80)
                Stepper("Altura: \(answers.heightCm) cm", value: $answers.heightCm, in: 140...215)
                Stepper("Peso: \(answers.weightKg, specifier: "%.1f") kg", value: $answers.weightKg, in: 40...200, step: 0.5)
                Stepper("Peso objetivo: \(answers.targetKg, specifier: "%.1f") kg", value: $answers.targetKg, in: 40...200, step: 0.5)
            }
            .card()
        default:
            summary
        }
    }

    private var summary: some View {
        let n = PlanEngine.nutrition(answers, weight: answers.weightKg)
        let first = PlanEngine.sessions(answers, week: 1)
        return VStack(alignment: .leading, spacing: 14) {
            title("Tu plan está listo", "12 semanas en 3 bloques: Base, Construcción y Rendimiento. Cada 4 semanas subes un escalón en cada ejercicio.")
            HStack(spacing: 12) {
                StatTile(value: "\(answers.days)", label: "días/semana", icon: "calendar", color: Theme.accent)
                StatTile(value: "\(n.kcal)", label: "kcal al día", icon: "flame.fill", color: .orange)
                StatTile(value: String(format: "%.1f", n.bmi), label: "IMC · \(PlanEngine.bmiLabel(n.bmi))", icon: "scalemass.fill", color: Theme.info)
            }
            if n.weeksToTarget > 0 {
                Callout(kind: .tip, text: "A un ritmo sano, podrías llegar a **\(String(format: "%.1f", answers.targetKg)) kg** en unas **\(n.weeksToTarget) semanas**. Es una estimación: lo importante es la constancia.")
            }
            SectionHeader(title: "Tu primera semana", icon: "list.bullet")
            ForEach(first) { item in
                HStack {
                    Text(PlanView.dayNames[item.day]).font(.headline.monospaced()).foregroundStyle(Theme.accent).frame(width: 30)
                    Text(item.workout.name)
                    Spacer()
                    Text("\(item.workout.minutes) min").foregroundStyle(Theme.muted)
                }
                .font(.subheadline)
                .card()
            }
            Text("Si tienes alguna lesión, problema de corazón o tensión alta, consulta antes con tu médico.")
                .font(.caption)
                .foregroundStyle(Theme.muted)
        }
    }

    private func title(_ text: String, _ subtitle: String?) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(text).font(.title2.bold())
            if let subtitle { Text(subtitle).foregroundStyle(Theme.muted) }
        }
        .padding(.bottom, 4)
    }

    private func option(_ title: String, _ detail: String?, icon: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button {
            withAnimation(.snappy) { action() }
        } label: {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(selected ? Color.black : Theme.accent)
                    .frame(width: 44, height: 44)
                    .background(selected ? Theme.accent : Theme.accent.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.headline)
                    if let detail { Text(detail).font(.caption).foregroundStyle(Theme.muted) }
                }
                Spacer()
                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(selected ? Theme.accent : Theme.muted)
            }
            .foregroundStyle(.white)
            .card(selected ? Theme.cardHighlight : Theme.card)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Tarjetas

/// Invitación a crear el plan (en Base y en Entreno).
struct PlanCTA: View {
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "sparkles")
                .font(.title)
                .foregroundStyle(.black)
                .frame(width: 52, height: 52)
                .background(Theme.accent, in: RoundedRectangle(cornerRadius: 14))
            VStack(alignment: .leading, spacing: 2) {
                Text("Crea tu plan de entreno").font(.headline)
                Text("9 preguntas y tendrás 12 semanas a tu medida, con nutrición incluida.")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card(Theme.cardHighlight)
    }
}

struct PlanCard: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        let week = store.planWeek
        let today = store.planSession()
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label("Tu plan", systemImage: "sparkles").font(.headline).foregroundStyle(Theme.accent)
                Spacer()
                Text(week > PlanEngine.totalWeeks ? "Completado" : "Semana \(week) de \(PlanEngine.totalWeeks)")
                    .font(.caption.bold())
                    .foregroundStyle(Theme.muted)
            }
            ProgressBar(value: min(1, Double(week - 1) / Double(PlanEngine.totalWeeks)))
            if let today {
                Text("Hoy: \(today.name)").font(.title3.bold())
                Text("\(today.minutes) min · \(today.blocks.count - 1) ejercicios\(store.planDone(on: .now) ? " · hecho ✓" : "")")
                    .font(.subheadline)
                    .foregroundStyle(store.planDone(on: .now) ? Theme.success : Theme.muted)
            } else {
                Text("Hoy descansas").font(.title3.bold())
                Text("Camina, estira o haz una clase suave del Dojo. El músculo crece descansando.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            }
        }
        .foregroundStyle(.white)
        .card(Theme.cardHighlight)
    }
}

// MARK: - Plan

struct PlanView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var showingWeight = false
    @State private var confirmDelete = false
    @State private var selectedWeek = 0

    static let dayNames = ["L", "M", "X", "J", "V", "S", "D"]
    private static let longDays = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"]

    var body: some View {
        if let answers = store.state.trainingPlan {
            content(answers)
        } else {
            PlanQuizView()
        }
    }

    private func content(_ answers: PlanAnswers) -> some View {
        let current = max(1, store.planWeek)
        let week = selectedWeek == 0 ? current : selectedWeek
        let today = PlanEngine.weekday(.now)
        return ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                PlanCard()
                if let session = store.planSession() {
                    NavigationLink {
                        WorkoutDetailView(workout: session)
                    } label: {
                        Label(store.planDone(on: .now) ? "Repetir la sesión de hoy" : "Empezar la sesión de hoy", systemImage: "play.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }

                HStack(spacing: 12) {
                    StatTile(value: "\(store.planSessionsDone)", label: "sesiones hechas", icon: "checkmark.seal.fill", color: Theme.success)
                    StatTile(value: PlanAnswers.levelNames[answers.level], label: "nivel inicial", icon: "chart.bar.fill", color: Theme.info)
                    StatTile(value: "\(answers.minutes)'", label: "por sesión", icon: "clock", color: Theme.accent)
                }

                HStack {
                    SectionHeader(title: "Semana \(week)", icon: "calendar")
                    Spacer()
                    Button { selectedWeek = max(1, week - 1) } label: { Image(systemName: "chevron.left") }
                        .disabled(week <= 1)
                    Button { selectedWeek = min(PlanEngine.totalWeeks, week + 1) } label: { Image(systemName: "chevron.right") }
                        .disabled(week >= PlanEngine.totalWeeks)
                }
                .foregroundStyle(Theme.accent)

                ForEach(PlanEngine.sessions(answers, week: week)) { item in
                    let shown = Calendar.current.isDateInToday(item.date) ? (store.planSession() ?? item.workout) : item.workout
                    let done = store.planDone(on: item.date)
                    NavigationLink {
                        WorkoutDetailView(workout: shown)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: done ? "checkmark.circle.fill" : PlanEngine.kindIcon(String(item.workout.id.suffix(1))))
                                .font(.title2)
                                .foregroundStyle(done ? Theme.success : Theme.accent)
                                .frame(width: 40)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(Self.longDays[item.day] + (week == current && item.day == today ? " · hoy" : ""))
                                    .font(.caption.bold())
                                    .foregroundStyle(week == current && item.day == today ? Theme.accent : Theme.muted)
                                Text(shown.name).font(.headline)
                                Text("\(shown.minutes) min · \(shown.blocks.count - 1) ejercicios").font(.caption).foregroundStyle(Theme.muted)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                        }
                        .foregroundStyle(.white)
                        .card()
                    }
                    .buttonStyle(.plain)
                }

                SectionHeader(title: "Nutrición y peso", icon: "fork.knife")
                NavigationLink {
                    NutritionView()
                } label: {
                    let n = PlanEngine.nutrition(answers, weight: store.currentWeight ?? answers.weightKg)
                    HStack(spacing: 14) {
                        Image(systemName: "fork.knife").font(.title2).foregroundStyle(.orange).frame(width: 40)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Tu nutrición").font(.headline)
                            Text("\(n.kcal) kcal · \(n.protein) g de proteína · \(String(format: "%.1f", n.waterLiters)) L de agua")
                                .font(.caption)
                                .foregroundStyle(Theme.muted)
                        }
                        Spacer()
                        Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                    }
                    .foregroundStyle(.white)
                    .card()
                }
                .buttonStyle(.plain)

                weightCard(answers)

                SectionHeader(title: "Ajustes", icon: "slider.horizontal.3")
                NavigationLink {
                    PlanQuizView(initial: answers)
                } label: {
                    Label("Rehacer el cuestionario", systemImage: "arrow.triangle.2.circlepath")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                Button("Borrar el plan", role: .destructive) { confirmDelete = true }
                    .frame(maxWidth: .infinity)
                Text("Al rehacer el cuestionario el plan vuelve a empezar en la semana 1. Si al terminar las 12 semanas haces más flexiones, elige un nivel más alto.")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Tu plan")
        .sheet(isPresented: $showingWeight) { WeightForm() }
        .confirmationDialog("¿Borrar el plan?", isPresented: $confirmDelete, titleVisibility: .visible) {
            Button("Borrar", role: .destructive) { store.deletePlan() }
        } message: {
            Text("Tu historial de entrenos y de peso se mantiene.")
        }
    }

    private func weightCard(_ answers: PlanAnswers) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Peso").font(.headline)
                    Text("Objetivo: \(String(format: "%.1f", answers.targetKg)) kg").font(.caption).foregroundStyle(Theme.muted)
                }
                Spacer()
                Text(String(format: "%.1f kg", store.currentWeight ?? answers.weightKg)).font(.title2.bold().monospacedDigit())
            }
            if store.state.weights.count >= 2 {
                Chart(store.state.weights) { entry in
                    LineMark(x: .value("Fecha", entry.date), y: .value("Peso", entry.kg))
                        .foregroundStyle(Theme.accent)
                    PointMark(x: .value("Fecha", entry.date), y: .value("Peso", entry.kg))
                        .foregroundStyle(Theme.accent)
                }
                .chartYScale(domain: .automatic(includesZero: false))
                .frame(height: 160)
            }
            Button {
                showingWeight = true
            } label: {
                Label("Registrar peso", systemImage: "plus")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
        }
        .card()
    }
}

struct WeightForm: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss
    @State private var kg = 75.0

    var body: some View {
        NavigationStack {
            Form {
                Stepper("\(kg, specifier: "%.1f") kg", value: $kg, in: 40...200, step: 0.1)
                Text("Pésate como mucho una vez por semana, el mismo día y en ayunas.")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            .navigationTitle("Registrar peso")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancelar") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        store.addWeight(kg)
                        dismiss()
                    }
                }
            }
            .onAppear { kg = store.currentWeight ?? 75 }
        }
    }
}

// MARK: - Nutrición

struct NutritionView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let answers = store.state.trainingPlan {
                    let n = PlanEngine.nutrition(answers, weight: store.currentWeight ?? answers.weightKg)
                    Text(PlanData.nutritionIntro).foregroundStyle(Theme.muted)
                    VStack(spacing: 8) {
                        Text("\(n.kcal)").font(.system(size: 48, weight: .bold, design: .rounded).monospacedDigit())
                        Text("kcal al día · \(answers.goal.label.lowercased())").font(.subheadline).foregroundStyle(Theme.muted)
                    }
                    .frame(maxWidth: .infinity)
                    .card(Theme.cardHighlight)
                    HStack(spacing: 12) {
                        StatTile(value: "\(n.protein) g", label: "proteína", icon: "fish.fill", color: Theme.danger)
                        StatTile(value: "\(n.carbs) g", label: "hidratos", icon: "leaf.fill", color: Theme.accent)
                        StatTile(value: "\(n.fat) g", label: "grasa", icon: "drop.fill", color: Theme.success)
                    }
                    HStack(spacing: 12) {
                        StatTile(value: String(format: "%.1f L", n.waterLiters), label: "agua", icon: "waterbottle.fill", color: Theme.info)
                        StatTile(value: String(format: "%.1f", n.bmi), label: "IMC · \(PlanEngine.bmiLabel(n.bmi))", icon: "scalemass.fill", color: Theme.muted)
                    }
                    if answers.age < 18 {
                        Callout(kind: .info, text: "Como eres menor de edad, las calorías son las de mantenimiento: estás creciendo y no conviene hacer dieta sin supervisión.")
                    }
                    Callout(kind: .warning, text: PlanData.nutritionWarning)
                    SectionHeader(title: "El método del plato", icon: "circle.grid.cross.fill")
                    LessonBlockView(block: .bullets(PlanData.plate), color: .orange)
                    SectionHeader(title: "Un día de ejemplo", icon: "sun.max.fill")
                    LessonBlockView(block: .bullets(PlanData.sampleDay), color: .orange)
                    SectionHeader(title: "Claves", icon: "lightbulb.fill")
                    LessonBlockView(block: .bullets(PlanData.nutritionTips), color: .orange)
                    Text("El IMC no distingue músculo de grasa: si entrenas fuerza, fíjate también en el espejo y en cómo te queda la ropa.")
                        .font(.caption)
                        .foregroundStyle(Theme.muted)
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Nutrición")
    }
}
