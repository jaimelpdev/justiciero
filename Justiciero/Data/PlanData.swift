import Foundation

/// Contenido del plan de entreno personalizado: escaleras de progresión por patrón de movimiento
/// y guía de nutrición. La lógica que monta las sesiones está en Store/PlanEngine.swift
/// (y su copia en web/app.js).
enum PlanData {
    static let intro = "Responde unas preguntas y la app te monta un programa de 12 semanas a tu medida: qué entrenar cada día, cuántas series y repeticiones, y cuándo subir de nivel. Como las apps de entreno personalizadas, pero orientado a lo que necesita un protector: fuerza, resistencia, combate y saber caer."

    /// Bloques del programa: cada 4 semanas subes un escalón en cada ejercicio. La 4.ª semana de cada bloque es de descarga.
    static let blocks: [String] = ["Base", "Construcción", "Rendimiento"]

    static let blockNotes: [String] = [
        "Aprende la técnica de cada ejercicio. Termina cada serie sintiendo que podías hacer 2 o 3 repeticiones más.",
        "Ejercicios más difíciles y más volumen. Aquí es donde tu cuerpo empieza a cambiar.",
        "Las variantes más exigentes. Ritmo e intensidad de alguien que puede responder cuando hace falta.",
    ]

    static let deloadNote = "Semana de descarga: una serie menos en cada ejercicio. El cuerpo se hace fuerte descansando; no te la saltes."

    // MARK: Escaleras de progresión (de más fácil a más difícil)

    /// Empuje principal: pecho, hombros y tríceps.
    static let push: [PlanMove] = [
        PlanMove(exercise: Exercises.inclinePushup, reps: 10, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.kneePushup, reps: 10, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pushups, reps: 8, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.declinePushup, reps: 8, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.diamondPushup, reps: 8, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.archerPushup, reps: 5, seconds: nil, perSide: true, impact: false),
    ]

    /// Empuje secundario: hombros y tríceps.
    static let push2: [PlanMove] = [
        PlanMove(exercise: Exercises.chairDips, reps: 8, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.chairDips, reps: 12, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pike, reps: 6, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pike, reps: 10, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pikeElevated, reps: 6, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pikeElevated, reps: 10, seconds: nil, perSide: false, impact: false),
    ]

    /// Tirón sin barra: espalda y bíceps.
    static let pull: [PlanMove] = [
        PlanMove(exercise: Exercises.towelRow, reps: 10, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.towelRow, reps: 15, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.invertedRow, reps: 8, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.invertedRow, reps: 12, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.rowFeetUp, reps: 8, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.towelRowOneArm, reps: 8, seconds: nil, perSide: true, impact: false),
    ]

    /// Tirón con barra de dominadas.
    static let pullBar: [PlanMove] = [
        PlanMove(exercise: Exercises.deadHang, reps: nil, seconds: 20, perSide: false, impact: false),
        PlanMove(exercise: Exercises.negativePullup, reps: 3, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.negativePullup, reps: 5, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.assistedPullup, reps: 6, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pullup, reps: 3, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pullup, reps: 6, seconds: nil, perSide: false, impact: false),
    ]

    /// Espalda baja y postura.
    static let back: [PlanMove] = [
        PlanMove(exercise: Exercises.birdDog, reps: 8, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.superman, reps: 10, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.superman, reps: 15, seconds: nil, perSide: false, impact: false),
    ]

    /// Piernas: cuádriceps y glúteos.
    static let leg: [PlanMove] = [
        PlanMove(exercise: Exercises.sitToStand, reps: 12, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.squats, reps: 15, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.reverseLunge, reps: 10, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.bulgarian, reps: 10, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.jumpSquat, reps: 12, seconds: nil, perSide: false, impact: true),
        PlanMove(exercise: Exercises.pauseSquat, reps: 12, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.pistolBox, reps: 6, seconds: nil, perSide: true, impact: false),
    ]

    /// Cadera: glúteos e isquios (la cadena que te hace rápido y potente).
    static let hinge: [PlanMove] = [
        PlanMove(exercise: Exercises.glutebridge, reps: 15, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.glutebridge, reps: 20, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.singleLegBridge, reps: 10, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.singleLegRDL, reps: 8, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.singleLegRDL, reps: 12, seconds: nil, perSide: true, impact: false),
    ]

    /// Core anterior.
    static let core: [PlanMove] = [
        PlanMove(exercise: Exercises.deadBug, reps: 8, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.plank, reps: nil, seconds: 30, perSide: false, impact: false),
        PlanMove(exercise: Exercises.hollow, reps: nil, seconds: 20, perSide: false, impact: false),
        PlanMove(exercise: Exercises.plankTaps, reps: 10, seconds: nil, perSide: true, impact: false),
        PlanMove(exercise: Exercises.legRaises, reps: 10, seconds: nil, perSide: false, impact: false),
        PlanMove(exercise: Exercises.hollow, reps: nil, seconds: 45, perSide: false, impact: false),
    ]

    /// Core lateral.
    static let core2: [PlanMove] = [
        PlanMove(exercise: Exercises.sidePlank, reps: nil, seconds: 15, perSide: false, impact: false),
        PlanMove(exercise: Exercises.sidePlank, reps: nil, seconds: 25, perSide: false, impact: false),
        PlanMove(exercise: Exercises.sidePlank, reps: nil, seconds: 40, perSide: false, impact: false),
    ]

    /// Cardio por intervalos (el final que te deja sin aliento).
    static let cardio: [PlanMove] = [
        PlanMove(exercise: Exercises.march, reps: nil, seconds: 30, perSide: false, impact: false),
        PlanMove(exercise: Exercises.jumpingJacks, reps: nil, seconds: 30, perSide: false, impact: true),
        PlanMove(exercise: Exercises.climbers, reps: nil, seconds: 30, perSide: false, impact: false),
        PlanMove(exercise: Exercises.skaters, reps: nil, seconds: 30, perSide: false, impact: true),
        PlanMove(exercise: Exercises.burpees, reps: nil, seconds: 30, perSide: false, impact: true),
    ]

    /// Combate: asaltos de técnica y potencia.
    static let combat: [PlanMove] = [
        PlanMove(exercise: Exercises.shadowBoxing, reps: nil, seconds: 60, perSide: false, impact: false),
        PlanMove(exercise: Exercises.slips, reps: nil, seconds: 45, perSide: false, impact: false),
        PlanMove(exercise: Exercises.kneeStrikes, reps: nil, seconds: 30, perSide: false, impact: false),
        PlanMove(exercise: Exercises.sprawl, reps: nil, seconds: 30, perSide: false, impact: true),
    ]

    // MARK: Nutrición

    static let nutritionIntro = "Entrenar sin comer bien es como patrullar sin dormir. Estas cifras son una estimación para empezar (fórmula de Mifflin-St Jeor): ajústalas según cómo cambie tu peso en 2–3 semanas."

    static let nutritionWarning = "Si tienes o has tenido problemas con la comida (atracones, restricción, purgas), no cuentes calorías: usa solo el método del plato y habla con tu médico o un dietista-nutricionista. Si eres menor de edad, no hagas dieta para perder peso sin supervisión."

    static let plate: [String] = [
        "**Mitad del plato: verdura y hortaliza.** Ensalada, pisto, judías verdes, tumbet, crema de calabacín…",
        "**Un cuarto: proteína.** Pollo, pavo, huevos, pescado, atún, legumbres, tofu, ternera magra.",
        "**Un cuarto: hidratos.** Arroz, pasta, patata, pan integral, avena, legumbres.",
        "**Un chorrito de aceite de oliva** y fruta de postre.",
        "**Agua** como bebida principal. El alcohol frena la recuperación y el sueño.",
    ]

    static let sampleDay: [String] = [
        "**Desayuno:** tostadas de pan integral con tomate, aceite y huevos revueltos, o yogur con avena y fruta.",
        "**Media mañana:** fruta y un puñado de frutos secos, o un bocadillo pequeño de pavo.",
        "**Comida:** lentejas o garbanzos con verduras, o arroz con pollo y ensalada. Fruta.",
        "**Merienda (antes o después de entrenar):** yogur o vaso de leche con plátano.",
        "**Cena:** pescado o tortilla con verdura y patata. Si tienes hambre por la noche, más verdura.",
    ]

    static let nutritionTips: [String] = [
        "Prioriza la proteína en cada comida: ayuda a ganar músculo y a no pasar hambre.",
        "Para perder grasa, no bajes de golpe: un déficit pequeño se mantiene; uno grande se abandona.",
        "Pésate como mucho una vez por semana, el mismo día, en ayunas. Fíjate en la tendencia, no en un día.",
        "Duerme 7–9 horas: con sueño corto se come más y se recupera peor.",
        "No necesitas suplementos para empezar. Si algún día los usas, que sea con consejo profesional.",
    ]
}
