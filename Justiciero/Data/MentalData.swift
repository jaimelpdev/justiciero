import Foundation

/// Entrenamiento mental: prácticas guiadas con respaldo psicológico y el botón «Momento difícil».
/// Complementan la ayuda profesional; no la sustituyen.
enum Mind {
    static let intro = "La fortaleza mental no es no sentir miedo, rabia o tristeza: es sentirlos y aun así poder pensar con claridad y elegir qué hacer. Se entrena como un músculo, poco cada día. Cada día te toca una práctica distinta; puedes hacer cualquier otra cuando quieras."

    static let professional = "Si has vivido maltrato, agresiones o acoso, lo más eficaz es trabajarlo con un psicólogo con experiencia en trauma. Es gratis a través de tu médico de cabecera o de la Oficina de Asistencia a las Víctimas del Delito de tu provincia. Estas prácticas te ayudan en el día a día, pero no sustituyen esa ayuda."

    static let practices: [MentalPractice] = [
        MentalPractice(id: "respiracion", title: "Respiración táctica", icon: "wind", minutes: 5,
                       why: "Es la forma más rápida de bajar las pulsaciones y recuperar el control del cuerpo. La usan policías, militares y deportistas de élite.",
                       steps: [
                           "Siéntate con la espalda recta y los pies en el suelo.",
                           "Inspira por la nariz contando 4.",
                           "Retén el aire contando 4.",
                           "Suelta por la boca, despacio, contando 4.",
                           "Mantén los pulmones vacíos contando 4.",
                           "Repite durante 5 minutos. Si te cuesta, empieza con 3 segundos en cada fase.",
                       ]),
        MentalPractice(id: "anclaje", title: "Volver al presente (5-4-3-2-1)", icon: "hand.point.up.left.fill", minutes: 3,
                       why: "Cuando un recuerdo o una situación te dispara, la mente se va al pasado o al peor futuro. Los sentidos te traen de vuelta al aquí y ahora, donde estás a salvo.",
                       steps: [
                           "Nombra en voz baja 5 cosas que puedes ver.",
                           "4 cosas que puedes tocar. Tócalas y fíjate en su textura.",
                           "3 cosas que puedes oír.",
                           "2 cosas que puedes oler.",
                           "1 cosa que puedes saborear, o una cosa buena de ti.",
                           "Termina con tres respiraciones lentas y di: «Estoy aquí. Ahora estoy a salvo».",
                       ]),
        MentalPractice(id: "musculos", title: "Relajación muscular", icon: "figure.mind.and.body", minutes: 10,
                       why: "El cuerpo guarda la tensión de lo que hemos vivido. Aprender a notar la diferencia entre tensión y relajación te da control sobre él.",
                       steps: [
                           "Túmbate o siéntate cómodo.",
                           "Aprieta fuerte los puños durante 5 segundos… y suelta de golpe. Nota la diferencia 15 segundos.",
                           "Haz lo mismo con brazos, hombros (súbelos a las orejas), cara (aprieta los ojos y la mandíbula), abdomen, piernas y pies.",
                           "Termina recorriendo el cuerpo de arriba abajo con la atención, soltando lo que quede tenso.",
                           "Hazlo por la noche: también te ayudará a dormir.",
                       ]),
        MentalPractice(id: "pensamientos", title: "Responder a la voz que te frena", icon: "text.bubble.fill", minutes: 10,
                       why: "Después de vivir agresiones es normal tener una voz interior que dice «eres débil», «no vales», «te va a volver a pasar». No puedes callarla a la fuerza, pero sí aprender a responderle.",
                       steps: [
                           "Escribe en la Bitácora una situación reciente que te hizo sentir mal.",
                           "Anota el pensamiento exacto que tuviste («soy un cobarde»).",
                           "Pregúntate: ¿qué pruebas tengo de que es verdad? ¿Y de que no lo es?",
                           "¿Qué le dirías a un amigo que pensara eso de sí mismo?",
                           "Escribe una respuesta más justa y realista («Me bloqueé porque mi cuerpo intentó protegerme. Estoy entrenando para responder mejor»).",
                       ]),
        MentalPractice(id: "logros", title: "Diario de logros", icon: "star.fill", minutes: 5,
                       why: "La mente que ha sufrido tiende a ver solo los fallos. Registrar lo que haces bien entrena a tu cerebro para ver también tu fuerza.",
                       steps: [
                           "Escribe en la Bitácora 3 cosas que has hecho bien hoy, por pequeñas que sean.",
                           "Para cada una, escribe qué dice de ti («he entrenado aunque no me apetecía: soy constante»).",
                           "Una vez a la semana, relee las entradas anteriores.",
                       ]),
        MentalPractice(id: "escalera", title: "Escalera de valentía", icon: "chart.line.uptrend.xyaxis", minutes: 10,
                       why: "El miedo se reduce enfrentándolo poco a poco, nunca de golpe. Así se gana confianza real y no solo valor de un día.",
                       steps: [
                           "Haz una lista de 10 situaciones cotidianas que te dan miedo o ansiedad (hablar con un desconocido, decir que no, caminar por cierta calle de día…).",
                           "Puntúa cada una del 0 al 10 según el miedo que te da.",
                           "Empieza por una de 3 o 4. Hazla, y quédate en la situación hasta que la ansiedad baje a la mitad.",
                           "Repítela hasta que ya no te cueste. Luego sube un peldaño.",
                           "Importante: esta escalera es para situaciones del día a día. Los recuerdos traumáticos se trabajan con un profesional, no a solas.",
                       ]),
        MentalPractice(id: "ensayo", title: "Ensayo mental", icon: "brain.head.profile", minutes: 7,
                       why: "Imaginar con detalle cómo respondes bien a una situación prepara al cerebro para hacerlo de verdad. Lo usan deportistas y equipos de emergencias.",
                       steps: [
                           "Cierra los ojos y respira lento un minuto.",
                           "Elige un escenario del Simulador y visualízalo con todo detalle: el lugar, la luz, los sonidos.",
                           "Nota cómo se acelera tu corazón… y cómo haces la respiración táctica.",
                           "Visualízate actuando bien: valoras en 2 segundos, llamas al 112, usas tu voz con firmeza o te alejas.",
                           "Termina imaginando que vuelves a casa sano. Abre los ojos.",
                       ]),
        MentalPractice(id: "autocompasion", title: "Carta a tu yo del pasado", icon: "envelope.open.fill", minutes: 10,
                       why: "Muchas personas que han sufrido violencia cargan con culpa o vergüenza que no les corresponde. Tratarte con la compasión con la que tratarías a otro es una de las bases de la fortaleza.",
                       steps: [
                           "Piensa en ti en uno de esos momentos difíciles (en el instituto, en esa relación).",
                           "Escríbele una carta en la Bitácora como lo haría alguien que le quiere y le entiende.",
                           "Dile lo que necesitaba oír entonces: que no era culpa suya, que hizo lo que pudo.",
                           "Termina contándole en quién te estás convirtiendo.",
                           "Si te remueve mucho, para, haz el ejercicio 5-4-3-2-1 y habla con tu Alfred o con un profesional.",
                       ]),
        MentalPractice(id: "red", title: "Tu red de apoyo", icon: "person.3.fill", minutes: 5,
                       why: "Batman tenía a Alfred, a Gordon y a Robin. Nadie es fuerte solo. Saber a quién acudir antes de necesitarlo es parte del entrenamiento.",
                       steps: [
                           "Escribe en la Bitácora el nombre de 3 personas con las que puedes hablar cuando estés mal.",
                           "Para cada una, apunta cuándo y cómo contactarla.",
                           "Añade un profesional: tu médico de cabecera, un psicólogo o la Oficina de Asistencia a las Víctimas de tu provincia.",
                           "Esta semana, escribe o llama a una de esas personas sin motivo, solo para mantener el contacto.",
                       ]),
    ]

    /// Pasos del botón «Momento difícil».
    static let sosSteps: [String] = [
        "Para lo que estés haciendo. Si puedes, siéntate o apóyate en una pared.",
        "Respira conmigo: 4 dentro, 4 retener, 4 fuera, 4 retener. Sigue el círculo de arriba.",
        "Mira a tu alrededor y nombra 5 cosas que ves, 4 que tocas, 3 que oyes.",
        "Pon una mano en el pecho y dite: «Esto es una reacción de mi cuerpo. Va a pasar. Ahora estoy a salvo».",
        "Si sigue siendo muy fuerte, llama a tu contacto de confianza o a uno de los teléfonos de abajo. Pedir ayuda es parte del entrenamiento.",
    ]
}
