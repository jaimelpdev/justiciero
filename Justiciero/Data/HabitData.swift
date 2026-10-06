import Foundation

/// Plan de hábitos: qué hacer exactamente cada día según la fase y el día de la semana.
/// Las tareas de tipo entreno, dojo, lección, misión, kim, escenario, test y bitácora
/// se marcan solas al hacerlas en la app; el resto se marcan a mano.
enum Habits {
    /// Hábitos fijos de todos los días.
    static let daily: [HabitItem] = [
        HabitItem(id: "despertar", block: .manana, kind: .habito, title: "Levántate a tu hora",
                  detail: "La misma hora todos los días, también el fin de semana. Nada más levantarte, un vaso grande de agua y abre la persiana.",
                  minutes: 2, workout: nil),
        HabitItem(id: "respiracion", block: .manana, kind: .habito, title: "Respiración táctica",
                  detail: "5 minutos sentado: 4 s inspirar, 4 s retener, 4 s soltar, 4 s retener. Es lo que te mantendrá con la cabeza fría.",
                  minutes: 5, workout: nil),
        HabitItem(id: "leccion", block: .manana, kind: .leccion, title: "Lección del día",
                  detail: "Lee la siguiente lección de la Academia y márcala como aprendida.",
                  minutes: 5, workout: nil),
        HabitItem(id: "bitacora", block: .noche, kind: .bitacora, title: "Bitácora",
                  detail: "2 minutos: qué has entrenado, qué has observado hoy y cómo te has sentido.",
                  minutes: 2, workout: nil),
        HabitItem(id: "dormir", block: .noche, kind: .habito, title: "A dormir a tu hora",
                  detail: "Pantallas fuera 30 minutos antes. Prepara la ropa de entrenar de mañana. 7–9 horas de sueño.",
                  minutes: 0, workout: nil),
    ]

    static let weeks: [WeekTemplate] = [cueva, forja, ciudad, guardian]

    private static let rest = HabitItem(id: "descanso", block: .tarde, kind: .descanso, title: "Descanso activo",
                                        detail: "Hoy no entrenas fuerte. Camina 30 minutos tranquilo y estira lo que notes cargado. El músculo crece descansando.",
                                        minutes: 30, workout: nil)
    private static let review = HabitItem(id: "revision", block: .noche, kind: .habito, title: "Revisión semanal",
                                          detail: "Mira la semana en «Ver la semana»: ¿qué días cumpliste? Escribe en la bitácora una cosa que mejorar la semana que viene.",
                                          minutes: 10, workout: nil)
    private static let mission = HabitItem(id: "mision", block: .tarde, kind: .mision, title: "Misión del programa",
                                           detail: "Avanza en la siguiente misión pendiente de tu fase.",
                                           minutes: 15, workout: nil)
    private static let kim = HabitItem(id: "kim", block: .tarde, kind: .kim, title: "Juego de Kim",
                                       detail: "Una partida para entrenar la memoria visual. Si superas el 80 %, pasa a modo difícil.",
                                       minutes: 3, workout: nil)
    private static let scenario = HabitItem(id: "escenario", block: .tarde, kind: .escenario, title: "Simulador",
                                            detail: "Resuelve un escenario. Si ya los tienes todos en óptimo, repite uno sin mirar y explica en voz alta por qué es la mejor opción.",
                                            minutes: 5, workout: nil)
    private static let dojo = HabitItem(id: "dojo", block: .tarde, kind: .dojo, title: "Clase del Dojo",
                                        detail: "La clase de tu cinturón con el entrenador por voz. Antes, repasa la técnica que peor te salga.",
                                        minutes: 30, workout: nil)
    private static let jog = HabitItem(id: "trote", block: .tarde, kind: .habito, title: "Trote: de 0 a 5 km",
                                       detail: "25 minutos alternando trote y caminar. Semana 1: 1 min trote / 2 min caminar. Cada semana, 1 minuto más de trote. Por zonas iluminadas.",
                                       minutes: 25, workout: nil)

    private static func workout(_ id: String, _ title: String, _ detail: String, _ minutes: Int) -> HabitItem {
        HabitItem(id: "entreno-" + id, block: .tarde, kind: .entreno, title: title, detail: detail, minutes: minutes, workout: id)
    }

    // MARK: Fase 0: en casa

    static let cueva = WeekTemplate(minPhase: 0, days: [
        [workout("cueva-a", "Cueva A · Fuerza base", "Sesión guiada en casa. Si es tu primera semana, usa la versión fácil de cada ejercicio.", 25), mission],
        [workout("movilidad", "Movilidad y calma", "15 minutos de movilidad y respiración. Recupera para mañana.", 15), kim],
        [workout("cueva-b", "Cueva B · Resistencia", "Sesión guiada en casa. Descansa lo que marque cada serie, no menos.", 25), mission],
        [workout("movilidad", "Movilidad y calma", "15 minutos de movilidad y respiración.", 15), scenario],
        [workout("cueva-a", "Cueva A · Fuerza base", "Intenta hacer una repetición más que el lunes en flexiones.", 25), mission],
        [scenario, kim,
         HabitItem(id: "equipo", block: .tarde, kind: .habito, title: "Revisa tu equipo",
                   detail: "Botiquín (caducidades), linterna, batería externa cargada. Si te falta algo, apúntalo.", minutes: 10, workout: nil)],
        [rest, review],
    ])

    // MARK: Fase 1: dojo en casa

    static let forja = WeekTemplate(minPhase: 1, days: [
        [workout("forja-fuerza", "Forja · Fuerza", "Fuerza con tu peso. Después, si te quedan ganas, 10 minutos de técnica lenta del Dojo.", 35)],
        [dojo, mission],
        [jog, workout("caidas", "Aprender a caer", "Sobre colchoneta. Barbilla al pecho siempre.", 20)],
        [dojo, mission],
        [workout("forja-fuerza", "Forja · Fuerza", "Intenta mejorar una repetición en cada ejercicio respecto al lunes.", 35), jog],
        [dojo, scenario, kim],
        [rest, review],
    ])

    // MARK: Fase 2 y 3: la ciudad

    static let ciudad = WeekTemplate(minPhase: 2, days: [
        [workout("forja-fuerza", "Forja · Fuerza", "Fuerza con tu peso.", 35), dojo],
        [dojo, mission],
        [workout("carrera", "Reconocimiento", "Carrera por tu barrio, de día o por zonas iluminadas. Fíjate en calles, portales y puntos seguros.", 40)],
        [dojo, mission],
        [workout("agilidad", "Agilidad urbana", "En un parque, a ras de suelo. Nada de alturas.", 30), scenario],
        [dojo, mission,
         HabitItem(id: "ruta", block: .tarde, kind: .salida, title: "Ruta de observación",
                   detail: "Recorre una de tus rutas a pie, de día o al anochecer acompañado, con «Salida segura» activada. Observa, no intervengas. Anota algo en la bitácora.",
                   minutes: 45, workout: nil)],
        [rest, review],
    ])

    // MARK: Fase 4 y 5: servicio

    static let guardian = WeekTemplate(minPhase: 4, days: [
        [workout("guardian", "Circuito del Guardián", "Preparación física para pruebas de acceso.", 45)],
        [dojo, mission],
        [workout("carrera", "Reconocimiento", "Carrera por tu barrio. Intenta bajar tu tiempo en 5 km.", 40)],
        [dojo, mission],
        [workout("forja-fuerza", "Forja · Fuerza", "Fuerza con tu peso.", 35), scenario],
        [HabitItem(id: "voluntariado", block: .tarde, kind: .voluntariado, title: "Servicio o formación",
                   detail: "Servicio con tu agrupación de Protección Civil o Cruz Roja, o una formación. Si no hay ninguno esta semana, haz una clase del Dojo.",
                   minutes: 120, workout: nil)],
        [rest, review],
    ])

    /// Cada 4 semanas, el domingo toca test físico.
    static let test = HabitItem(id: "test", block: .manana, kind: .test, title: "Test físico",
                                detail: "Han pasado 4 semanas: registra tu test (flexiones, sentadillas, plancha, burpees y, si puedes, 5 km). Calienta antes.",
                                minutes: 20, workout: nil)
}
