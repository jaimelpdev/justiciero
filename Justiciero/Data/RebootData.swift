import Foundation

/// Reinicio: recuperar el control sobre un hábito que te quita energía (el consumo diario de porno).
/// Nombre discreto a propósito. Complementa la ayuda profesional; no la sustituye.
enum Reboot {
    static let intro = "Un hábito que llevas años repitiendo no se rompe con fuerza de voluntad a pelo: se rompe cambiando el entorno, entendiendo tus disparadores y teniendo un plan para cuando llegue el impulso. Activa la semana de reinicio y durante 14 días tu plan diario se centra en la mente y en los hábitos, con menos carga física."

    static let professional = "Si llevas mucho tiempo intentándolo solo y no lo consigues, o te genera mucho malestar, un psicólogo o un sexólogo pueden ayudarte. Es un tema muy habitual en consulta y se trabaja sin juzgarte. Puedes empezar por tu médico de cabecera."

    static let urgeIntro = "Un impulso es una ola: sube, llega a un pico y baja sola, normalmente en 15 o 20 minutos. No tienes que ganarle a la ola, solo surfearla sin hacerle caso."

    /// Pasos del botón «Tengo un impulso ahora».
    static let urgeSteps: [String] = [
        "**Cambia de sitio ya.** Levántate, sal de la habitación y deja el móvil en otra parte. Si estás en la cama, enciende la luz.",
        "**Ponle nombre:** «Esto es un impulso. Es incómodo, pero no es una orden. Va a bajar».",
        "**Respira** 4 ciclos de respiración táctica siguiendo el círculo.",
        "**Activa el cuerpo** 2 minutos: 20 sentadillas, 10 flexiones o una ducha fría o templada.",
        "**Haz una distracción** de la lista de abajo hasta que pase el temporizador.",
        "**Si sigue fuerte**, escribe a alguien o sal a la calle a caminar 10 minutos.",
    ]

    static let distractions: [String] = [
        "Sal a caminar 10 minutos, aunque sea a la esquina.",
        "Llama o escribe a un amigo, a tu pareja o a un familiar.",
        "Una clase corta del Dojo o una serie de sombra (boxeo al aire).",
        "Ducha, lavarte la cara con agua fría, beber un vaso de agua.",
        "Algo con las manos: cocinar, ordenar un cajón, montar, tocar un instrumento.",
        "Un escenario del Simulador o una partida del Juego de Kim.",
        "Escribe en la Bitácora qué ha disparado el impulso.",
    ]

    /// Barreras recomendadas para el entorno (se marcan en la pantalla de Reinicio).
    static let barriers: [String] = [
        "Activa el bloqueo de sitios para adultos del iPhone: Ajustes › Tiempo de uso › Restricciones de contenido y privacidad › Restricciones de contenido › Contenido web › Limitar sitios web para adultos.",
        "Pon un código de Tiempo de uso que no sepas tú: que lo elija tu pareja o alguien de confianza.",
        "El móvil duerme fuera del dormitorio. Usa un despertador normal.",
        "Deja de seguir cuentas y perfiles que te llevan al contenido.",
        "Nada de pantallas en la cama ni en el baño.",
        "Ten preparada una alternativa para tus horas de riesgo (la noche, el aburrimiento, después de discutir).",
    ]

    static let checkin = HabitItem(id: "reinicio", block: .noche, kind: .reinicio, title: "Check-in de reinicio",
                                   detail: "Antes de dormir, marca si hoy ha sido un día libre o si has recaído. Con sinceridad y sin castigarte.",
                                   minutes: 1, workout: nil)
    static let phoneOut = HabitItem(id: "movil-fuera", block: .noche, kind: .habito, title: "Móvil fuera del dormitorio",
                                    detail: "Déjalo cargando en otra habitación. Es la barrera que más funciona por la noche.",
                                    minutes: 1, workout: nil)

    /// Hábitos fijos añadidos durante la semana de reinicio.
    static let daily: [HabitItem] = [checkin, phoneOut]

    static let walk = HabitItem(id: "paseo", block: .tarde, kind: .habito, title: "Paseo al aire libre",
                                detail: "30 minutos fuera de casa y sin pantallas. La luz natural y el movimiento suben el ánimo y bajan la ansiedad.",
                                minutes: 30, workout: nil)
    static let social = HabitItem(id: "contacto", block: .tarde, kind: .habito, title: "Contacto real",
                                  detail: "Queda con alguien, llama a un amigo o haz un plan con tu pareja. El aislamiento alimenta el hábito.",
                                  minutes: 30, workout: nil)
    static let hands = HabitItem(id: "manos", block: .tarde, kind: .habito, title: "Algo con las manos",
                                 detail: "Cocinar, arreglar algo, dibujar, un instrumento… Una actividad que te guste y que no sea una pantalla.",
                                 minutes: 30, workout: nil)
    static let surf = HabitItem(id: "surfear", block: .tarde, kind: .habito, title: "Ensaya tu plan de impulso",
                                detail: "Abre «Tengo un impulso ahora» y léelo con calma. Escribe en la Bitácora tu plan si-entonces: «Si es de noche y me aburro, entonces…».",
                                minutes: 10, workout: nil)
    static let outdoor = HabitItem(id: "aire-libre", block: .tarde, kind: .habito, title: "Actividad larga fuera",
                                   detail: "Una excursión, deporte con amigos o un plan con tu pareja. Llena el sábado de cosas que te gusten.",
                                   minutes: 120, workout: nil)
    static let rest = HabitItem(id: "descanso", block: .tarde, kind: .descanso, title: "Descanso activo",
                                detail: "Camina 30 minutos tranquilo y estira. Hoy toca recargar.",
                                minutes: 30, workout: nil)
    static let review = HabitItem(id: "revision", block: .noche, kind: .habito, title: "Revisión semanal",
                                  detail: "Mira tu contador de reinicio: ¿qué días fueron más difíciles y por qué? Escribe en la bitácora una barrera nueva para la semana que viene.",
                                  minutes: 10, workout: nil)
    static let cuevaA = HabitItem(id: "entreno-cueva-a", block: .tarde, kind: .entreno, title: "Cueva A · Fuerza base",
                                  detail: "El ejercicio es tu mejor aliado: descarga tensión y mejora el ánimo. Versión fácil si estás cansado.",
                                  minutes: 25, workout: "cueva-a")
    static let cuevaB = HabitItem(id: "entreno-cueva-b", block: .tarde, kind: .entreno, title: "Cueva B · Resistencia",
                                  detail: "Sesión guiada en casa. Si llega un impulso, este es un buen momento para entrenar.",
                                  minutes: 25, workout: "cueva-b")
    static let mobility = HabitItem(id: "entreno-movilidad", block: .tarde, kind: .entreno, title: "Movilidad y calma",
                                    detail: "15 minutos de movilidad y respiración para bajar revoluciones.",
                                    minutes: 15, workout: "movilidad")

    /// Plantilla de la semana de reinicio: mente y hábitos primero, poca carga física.
    static let week = WeekTemplate(minPhase: 0, days: [
        [cuevaA, walk],
        [mobility, surf],
        [cuevaB, social],
        [mobility, hands],
        [cuevaA, walk],
        [outdoor, social],
        [rest, review],
    ])

    /// Duración de la semana de reinicio (en días).
    static let length = 14
}
