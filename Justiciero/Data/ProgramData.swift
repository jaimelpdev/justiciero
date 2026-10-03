import Foundation

extension Phase {
    static let all: [Phase] = [cueva, forja, ciudad, detective, guardian, caballero]

    // MARK: Fase 0 — En casa

    static let cueva = Phase(
        id: 0,
        codename: "LA CUEVA",
        title: "Fundamentos en casa",
        weeks: 1...4,
        icon: "house.fill",
        location: "Casa",
        summary: "Todo empieza en tu habitación. Antes de pisar la calle de noche necesitas una base física, hábitos de sueño, conocer la ley y saber primeros auxilios básicos. Nada de esto requiere salir ni gastar dinero.",
        whyThisOrder: "La calle de noche no perdona la improvisación. Un cuerpo sin preparar se lesiona, una mente sin dormir decide mal y alguien que no conoce la ley puede acabar siendo él el denunciado. La cueva de Batman era su sitio seguro para prepararse: la tuya es tu casa.",
        objectives: [
            "Hacer la evaluación física inicial y conocer tu punto de partida.",
            "Entrenar 3 días por semana con tu peso corporal.",
            "Dormir 7–9 horas con horario fijo.",
            "Entender qué puedes y qué NO puedes hacer legalmente.",
            "Saber aplicar la conducta PAS y la RCP básica.",
        ],
        safetyRules: [
            "En esta fase NO sales de ronda. Ni una vez. Las salidas nocturnas llegan en la fase 2.",
            "Si tienes alguna condición médica, consulta antes con tu médico.",
            "Entrena con técnica: si algo duele (dolor agudo, no cansancio), para.",
        ],
        minorNote: "Si eres menor de edad, todo este programa en casa es perfecto para ti. Cuéntaselo a tus padres o tutores: te pueden ayudar más de lo que crees.",
        tasks: [
            ProgramTask("p0-01", 1, .mente, "Escribe tu porqué",
                        "Abre la Bitácora y escribe por qué quieres hacer esto. Sé sincero. Si la respuesta tiene que ver con rabia o venganza, habla antes con alguien de confianza o con un profesional: un protector actúa desde la calma, no desde la ira."),
            ProgramTask("p0-02", 1, .fisico, "Evaluación física inicial",
                        "Ve a Más › Perfil y registra tu primer test: flexiones máximas, sentadillas en 1 minuto, plancha máxima y burpees en 1 minuto. No importa lo bajos que sean: es tu punto de partida."),
            ProgramTask("p0-03", 1, .mente, "Chequeo médico básico",
                        "Si hace tiempo que no haces deporte o tienes alguna condición (corazón, asma, lesiones), pide cita con tu médico de cabecera antes de entrenar fuerte."),
            ProgramTask("p0-04", 1, .mente, "Fija tu horario de sueño",
                        "Elige una hora fija para acostarte y levantarte. 7–9 horas. En las películas Bruce Wayne no duerme; en la vida real, la falta de sueño te hace más lento, más irritable y peor tomando decisiones."),
            ProgramTask("p0-05", 2, .fisico, "Semana completa de entreno en casa",
                        "Completa 3 sesiones esta semana alternando Cueva A y Cueva B (pestaña Entreno). Deja al menos un día de descanso entre sesiones."),
            ProgramTask("p0-06", 2, .ley, "Estudia «Ley y límites»",
                        "En Academia, completa las lecciones de Ley y límites. Es lo que separa a un ciudadano ejemplar de alguien con antecedentes penales."),
            ProgramTask("p0-07", 2, .equipo, "Monta tu botiquín de casa",
                        "Guantes de nitrilo, gasas estériles, vendas, esparadrapo, suero fisiológico, antiséptico, manta térmica, tijeras de punta roma. Consulta Más › Equipamiento."),
            ProgramTask("p0-08", 3, .habilidad, "Aprende PAS y RCP",
                        "Completa las lecciones de Primeros auxilios. Practica las compresiones sobre un cojín firme: 100–120 por minuto (al ritmo de «Stayin' Alive»)."),
            ProgramTask("p0-09", 3, .mente, "Respiración táctica 7 días seguidos",
                        "5 minutos al día de respiración cuadrada (4 s inspirar, 4 s retener, 4 s espirar, 4 s retener). Es la herramienta n.º 1 para mantener la cabeza fría bajo estrés."),
            ProgramTask("p0-10", 3, .habilidad, "Juega 3 partidas al Juego de Kim",
                        "En Academia › Juego de Kim. Entrena la memoria visual que usarás para ser un testigo útil."),
            ProgramTask("p0-11", 4, .comunidad, "Cuéntaselo a tu «Alfred»",
                        "Elige a una persona de confianza y explícale tu plan. Añádela como contacto en Más › Perfil. Ningún justiciero real trabaja solo: Batman tenía a Alfred por algo."),
            ProgramTask("p0-12", 4, .ley, "Supera 5 escenarios en el simulador",
                        "Academia › Simulador. Consigue al menos 5 escenarios con la respuesta óptima."),
            ProgramTask("p0-13", 4, .fisico, "Repite la evaluación física",
                        "Haz el test de nuevo y compáralo con el de la semana 1. Celebra cualquier mejora."),
        ]
    )

    // MARK: Fase 1 — Gimnasio / dojo

    static let forja = Phase(
        id: 1,
        codename: "LA FORJA",
        title: "Cuerpo y técnica con profesionales",
        weeks: 5...12,
        icon: "flame.fill",
        location: "Casa + gimnasio/dojo",
        summary: "Ahora toca aprender de gente que sabe. Te apuntas a un arte marcial con instructor, haces un curso presencial de primeros auxilios y construyes resistencia de verdad.",
        whyThisOrder: "Los vídeos de internet no enseñan a defenderse: enseñan a creer que sabes defenderte, que es peor. Solo el entrenamiento con un instructor y compañeros que se resisten te da una idea real de tus capacidades (y de tus límites).",
        objectives: [
            "Entrenar un arte marcial o deporte de contacto 2 veces por semana.",
            "Correr 5 km seguidos.",
            "Obtener un certificado presencial de primeros auxilios / RCP.",
            "Aprender a caer sin hacerte daño.",
            "Dominar las técnicas básicas de desescalada verbal.",
        ],
        safetyRules: [
            "Todavía no sales de ronda. Correr de noche, solo por zonas iluminadas y conocidas.",
            "Nada de sparring sin supervisión de un instructor.",
            "Descansa: el músculo crece cuando descansas, no cuando entrenas.",
        ],
        minorNote: "Casi todos los clubes de judo, boxeo o BJJ tienen grupos para menores. Los cursos de primeros auxilios de Cruz Roja también tienen versiones para jóvenes.",
        tasks: [
            ProgramTask("p1-01", 5, .habilidad, "Prueba 2–3 artes marciales",
                        "La mayoría de clubes ofrecen una clase de prueba gratis. Recomendado: judo o BJJ (control sin necesidad de golpear y aprendes a caer), boxeo o muay thai (forma física y gestión del contacto). Lee Academia › Defensa personal antes de elegir."),
            ProgramTask("p1-02", 6, .habilidad, "Apúntate a un club",
                        "Elige el que tenga buen ambiente, instructor titulado y que no prometa «técnicas letales». Desconfía de quien venda invencibilidad."),
            ProgramTask("p1-03", 8, .habilidad, "Un mes de clases sin faltar",
                        "2 clases por semana durante 4 semanas. La constancia es la superpotencia."),
            ProgramTask("p1-04", 6, .fisico, "Programa de 0 a 5 km",
                        "3 días por semana, alternando caminar y trotar. Empieza con 1 min trote / 2 min caminar y ve aumentando. Objetivo: 5 km seguidos al final de la fase."),
            ProgramTask("p1-05", 7, .fisico, "3 sesiones semanales de Forja",
                        "Alterna Forja · Fuerza y Forja · Combate en tus días sin clase."),
            ProgramTask("p1-06", 7, .habilidad, "Aprende a caer",
                        "Haz la sesión «Aprender a caer» sobre colchoneta o en tu club. Saber caer evita más lesiones que saber golpear."),
            ProgramTask("p1-07", 9, .habilidad, "Curso presencial de primeros auxilios + DEA",
                        "Cruz Roja, SAMUR, Protección Civil o tu ayuntamiento los organizan (a menudo gratis o baratos). Busca uno que incluya RCP con maniquí y uso del desfibrilador (DEA)."),
            ProgramTask("p1-08", 9, .mente, "Estudia «Desescalada»",
                        "Completa el módulo en Academia. Practica las frases en voz alta: suena raro, pero en un momento de tensión saldrán solas."),
            ProgramTask("p1-09", 10, .fisico, "Aprende o mejora a nadar",
                        "Un rescatador que no nada bien se convierte en la segunda víctima. Si no sabes, apúntate a un curso en la piscina municipal."),
            ProgramTask("p1-10", 10, .mente, "Revisa tu alimentación",
                        "Proteína en cada comida, fruta y verdura, 2 litros de agua. Alcohol: lo mínimo. Batman no entrena con resaca."),
            ProgramTask("p1-11", 11, .habilidad, "Describe a 7 personas",
                        "Durante una semana, una vez al día, describe en la Bitácora (tipo Observación) a alguien que hayas visto: altura, complexión, ropa de arriba abajo, calzado y un rasgo distintivo. Sin hacer fotos ni seguir a nadie."),
            ProgramTask("p1-12", 12, .fisico, "Corre 5 km sin parar",
                        "Da igual el tiempo. Registra el tiempo en tu siguiente test físico."),
            ProgramTask("p1-13", 12, .fisico, "Test físico de fin de fase",
                        "Objetivo orientativo: 20 flexiones, 40 sentadillas/min, 60 s de plancha."),
        ]
    )

    // MARK: Fase 2 — Conocer la ciudad

    static let ciudad = Phase(
        id: 2,
        codename: "LA CIUDAD",
        title: "Conoce tu territorio",
        weeks: 13...20,
        icon: "building.2.fill",
        location: "Tu barrio (primero de día)",
        summary: "Batman conocía Gotham calle por calle. Tú vas a conocer tu barrio: rutas, puntos seguros, desfibriladores, farmacias de guardia, comisarías. Primero de día, luego al anochecer y acompañado.",
        whyThisOrder: "Ya tienes base física, sabes la ley y primeros auxilios. Ahora sí puedes salir, pero de forma progresiva: lo desconocido es lo que más riesgo genera de noche.",
        objectives: [
            "Mapear los puntos seguros de tu barrio.",
            "Conocer 3 rutas a pie de memoria.",
            "Configurar las herramientas de emergencia del móvil.",
            "Hacer tus primeras salidas nocturnas de forma segura.",
            "Conocer a tu comunidad.",
        ],
        safetyRules: [
            "Primero de día. Después al anochecer. Después de noche. Nunca te saltes pasos.",
            "Las salidas nocturnas, siempre con «Salida segura» activada y alguien informado.",
            "Tu papel es conocer el terreno, no buscar problemas. Si ves algo, llamas y te alejas.",
            "Nada de alcohol en tus salidas.",
        ],
        minorNote: "Si eres menor, haz todas las salidas de esta fase de día o acompañado por un adulto. Las salidas nocturnas solo, cuando seas mayor de edad.",
        tasks: [
            ProgramTask("p2-01", 13, .equipo, "Configura Emergencia SOS y Ficha Médica",
                        "En el iPhone: Ajustes › Emergencia SOS (llamada con botones laterales) y la app Salud › Ficha Médica (alergias, grupo sanguíneo, contactos). Activa también compartir ubicación con tu «Alfred» en la app Buscar."),
            ProgramTask("p2-02", 13, .equipo, "Instala AlertCops",
                        "Es la app oficial del Ministerio del Interior para alertar a Policía Nacional y Guardia Civil, incluso por chat. Útil cuando no puedes hablar. (Si no estás en España, busca la app equivalente de tu país)."),
            ProgramTask("p2-03", 14, .habilidad, "Mapa de puntos seguros",
                        "Localiza y anota en la Bitácora: comisaría más cercana, centro de salud/hospital, farmacias 24 h, desfibriladores públicos (DEA), parque de bomberos y comercios abiertos hasta tarde."),
            ProgramTask("p2-04", 14, .fisico, "3 rutas a pie de día",
                        "Recorre caminando o corriendo 3 rutas diferentes por tu barrio. Fíjate en nombres de calles, números de portal, zonas oscuras, salidas y lugares con gente."),
            ProgramTask("p2-05", 15, .habilidad, "Estudia «Conciencia situacional»",
                        "Completa el módulo Ciudad y noche en Academia. Aprende el código de colores de Cooper."),
            ProgramTask("p2-06", 16, .habilidad, "Orientación sin GPS",
                        "Haz una de tus rutas sin mirar el móvil. Si alguien te pregunta en el 112 dónde estás, tienes que saberlo sin abrir mapas."),
            ProgramTask("p2-07", 16, .fisico, "Primera salida al anochecer (acompañado)",
                        "Repite una ruta conocida al anochecer con un amigo. Usa «Salida segura». Observa cómo cambia el barrio con la luz."),
            ProgramTask("p2-08", 17, .comunidad, "Conoce a tu barrio",
                        "Preséntate al de la tienda de la esquina, al conserje, a tus vecinos. Los «ojos del barrio» son la mejor red de seguridad que existe."),
            ProgramTask("p2-09", 18, .fisico, "Carrera nocturna con chaleco reflectante",
                        "Corre de noche por una ruta iluminada y conocida, con chaleco o prendas reflectantes, «Salida segura» activa y móvil cargado."),
            ProgramTask("p2-10", 19, .habilidad, "Practica el aviso al 112 (en seco)",
                        "Escribe en la Bitácora cómo describirías por teléfono una emergencia en cada una de tus 3 rutas: dirección exacta, referencia visible, qué pasa. NO llames al 112 para practicar."),
            ProgramTask("p2-11", 20, .mente, "Revisa tu porqué",
                        "Relee lo que escribiste en la semana 1. ¿Ha cambiado algo? Escribe una nueva entrada de Reflexión."),
            ProgramTask("p2-12", 20, .fisico, "Test físico de fin de fase",
                        "Objetivo orientativo: 25 flexiones, 5 km en menos de 35 min."),
        ]
    )

    // MARK: Fase 3 — El detective

    static let detective = Phase(
        id: 3,
        codename: "EL DETECTIVE",
        title: "Observar, recordar, informar",
        weeks: 21...28,
        icon: "magnifyingglass",
        location: "Calle (observación pasiva)",
        summary: "La faceta más infravalorada de Batman es la de detective. En la vida real, lo más útil que puede hacer un ciudadano ante un delito casi siempre es ser un testigo excelente: ver, recordar y transmitir información precisa a quien puede actuar.",
        whyThisOrder: "Antes de implicarte en servicios reales necesitas saber observar sin intervenir. Esto te entrena la paciencia, la memoria y el criterio, que son lo que de verdad salva situaciones.",
        objectives: [
            "Describir personas y vehículos con precisión.",
            "Hacer una llamada de emergencia clara y completa.",
            "Superar todos los escenarios del simulador con la respuesta óptima.",
            "Leer de primera mano los artículos legales clave.",
        ],
        safetyRules: [
            "Observar no es vigilar a personas concretas. Nunca sigas a nadie, nunca fotografíes a desconocidos.",
            "Si detectas algo sospechoso: distancia, aviso al 091/062/112 y te vas.",
            "No publiques nada en redes sobre incidentes o personas.",
        ],
        minorNote: nil,
        tasks: [
            ProgramTask("p3-01", 21, .habilidad, "Estudia «Observación y testimonio»",
                        "Completa el módulo en Academia: descripción de personas, vehículos y la llamada perfecta al 112."),
            ProgramTask("p3-02", 21, .habilidad, "Juego de Kim: 80 % o más",
                        "Consigue al menos un 80 % en el Juego de Kim en modo difícil."),
            ProgramTask("p3-03", 22, .habilidad, "Sesión de observación en un banco",
                        "30 minutos sentado en un lugar público de día, observando el entorno sin intervenir: flujos de gente, horarios, qué es normal allí. Anota en la Bitácora qué sería «anormal» en ese sitio."),
            ProgramTask("p3-04", 23, .habilidad, "Vehículos: practica la descripción",
                        "Durante una semana, al ver un coche aparcado, di mentalmente: tipo, color, marca, y una característica (pegatina, golpe, baca). Sin apuntar matrículas de nadie."),
            ProgramTask("p3-05", 24, .ley, "Lee los artículos originales",
                        "Busca en el BOE: Código Penal art. 20 (legítima defensa) y 195 (omisión del deber de socorro), y LECrim arts. 490 y 491 (detención por particulares). Leer la fuente evita mitos."),
            ProgramTask("p3-06", 24, .ley, "Todos los escenarios con respuesta óptima",
                        "Completa el simulador entero con la máxima puntuación."),
            ProgramTask("p3-07", 25, .mente, "Estudia «Mentalidad»",
                        "Completa el módulo: el estrés agudo, el miedo y cómo afectan a tu cuerpo."),
            ProgramTask("p3-08", 26, .comunidad, "Charla o curso de mediación/desescalada",
                        "Muchos ayuntamientos, ONG y universidades organizan talleres de mediación de conflictos. Apúntate a uno."),
            ProgramTask("p3-09", 27, .fisico, "Mantén el entreno: 12 sesiones en la fase",
                        "Registra en la app al menos 12 entrenamientos durante esta fase, además de tus clases."),
            ProgramTask("p3-10", 28, .fisico, "Test físico de fin de fase",
                        "Objetivo orientativo: 30 flexiones, 5 km en menos de 32 min, 90 s de plancha."),
        ]
    )

    // MARK: Fase 4 — El guardián

    static let guardian = Phase(
        id: 4,
        codename: "EL GUARDIÁN",
        title: "Servicio real y organizado",
        weeks: 29...40,
        icon: "shield.fill",
        location: "Calle, dentro de organizaciones",
        summary: "Aquí te pones el «traje»: un uniforme oficial de voluntario. Protección Civil y Cruz Roja hacen servicios nocturnos de verdad: preventivos en fiestas y conciertos, atención a personas sin hogar en noches de frío, búsquedas, emergencias. Es lo más parecido a ser Batman que existe, y es legal, útil y con respaldo.",
        whyThisOrder: "Ya tienes forma física, formación en primeros auxilios, criterio legal y capacidad de observación. Es el momento de poner todo eso al servicio de otros, con un equipo, formación continua, seguro y coordinación con los servicios de emergencia.",
        objectives: [
            "Entrar como voluntario en una organización de emergencias.",
            "Hacer tus primeros servicios nocturnos con uniforme.",
            "Obtener una certificación de Soporte Vital Básico + DEA.",
            "Avanzar de grado en tu arte marcial.",
        ],
        safetyRules: [
            "En servicio, sigue SIEMPRE la cadena de mando y los protocolos de tu organización.",
            "Fuera de servicio, sigues siendo un ciudadano: mismos límites legales que cualquiera.",
            "No organices «patrullas» por tu cuenta. Avisar y acompañar sí; buscar problemas, no.",
        ],
        minorNote: "Cruz Roja Juventud acepta voluntarios desde muy jóvenes, y muchas agrupaciones de Protección Civil admiten aspirantes desde los 16 con permiso. Elige estas opciones y deja las salidas nocturnas para cuando seas mayor de edad.",
        tasks: [
            ProgramTask("p4-01", 29, .comunidad, "Solicita entrar en Protección Civil o Cruz Roja",
                        "Busca la agrupación de voluntarios de Protección Civil de tu municipio o la asamblea local de Cruz Roja. Pregunta por el proceso de ingreso y la formación básica."),
            ProgramTask("p4-02", 31, .comunidad, "Completa la formación básica de voluntario",
                        "Suele durar varias semanas. Aprenderás comunicaciones, organización de emergencias y primeros auxilios aplicados."),
            ProgramTask("p4-03", 33, .comunidad, "Primer servicio preventivo",
                        "Fiestas patronales, conciertos, carreras populares... Lo normal es empezar acompañando a voluntarios veteranos."),
            ProgramTask("p4-04", 35, .comunidad, "Primer servicio nocturno",
                        "Un servicio de noche con tu organización. Tu primera noche protegiendo tu ciudad de verdad."),
            ProgramTask("p4-05", 32, .habilidad, "Certificado de Soporte Vital Básico + DEA",
                        "Curso oficial (SVB/DEA). En muchas comunidades autónomas es necesario para usar un desfibrilador con plena acreditación."),
            ProgramTask("p4-06", 34, .comunidad, "Ofrece acompañamiento seguro",
                        "Ofrece a amigos o compañeros acompañarles a casa después de una noche fuera. Es simple y evita muchas situaciones."),
            ProgramTask("p4-07", 36, .comunidad, "Red de aviso vecinal",
                        "Propón a tus vecinos un grupo para avisarse de incidencias y llamar al 092 o 112. Avisar, no patrullar ni señalar a personas."),
            ProgramTask("p4-08", 37, .habilidad, "Sube de grado en tu arte marcial",
                        "Primer cinturón o primer combate amateur supervisado, según la disciplina."),
            ProgramTask("p4-09", 38, .habilidad, "Curso de socorrista o rescate acuático (opcional)",
                        "Si te gusta el agua, el título de socorrista es una de las formaciones más útiles para salvar vidas."),
            ProgramTask("p4-10", 39, .comunidad, "Usa «Salida segura» en 10 salidas",
                        "El hábito de que alguien siempre sepa dónde estás tiene que ser automático."),
            ProgramTask("p4-11", 40, .fisico, "Test físico de fin de fase",
                        "Objetivo orientativo: 35 flexiones, 5 km en menos de 30 min, 2 min de plancha."),
        ]
    )

    // MARK: Fase 5 — Caballero de la noche

    static let caballero = Phase(
        id: 5,
        codename: "CABALLERO DE LA NOCHE",
        title: "Hazlo tu vida",
        weeks: 41...52,
        icon: "moon.stars.fill",
        location: "Donde te necesiten",
        summary: "Ya eres una persona preparada, en forma y útil en una emergencia. La última fase es decidir hasta dónde quieres llevarlo: profesionalizarte (policía, bombero, técnico de emergencias, vigilante de seguridad, socorrista) o seguir como voluntario y convertirte en mentor de otros.",
        whyThisOrder: "Batman no es un año de entrenamiento: es una vida de compromiso. Esta fase no termina; se convierte en tu rutina de mantenimiento.",
        objectives: [
            "Elegir tu camino a largo plazo.",
            "Enseñar lo que sabes a otras personas.",
            "Mantener la forma física y la formación al día.",
        ],
        safetyRules: [
            "La experiencia trae exceso de confianza: repasa el Código del Vigilante cada mes.",
            "Cuida tu salud mental. Lo que ves en emergencias pesa: habla de ello.",
        ],
        minorNote: "Si eres menor, esta fase es para planificar: ¿qué estudios o formación necesitas para el camino que te gusta? Empieza a prepararlo.",
        tasks: [
            ProgramTask("p5-01", 41, .comunidad, "Estudia «Caminos reales»",
                        "Lee el módulo en Academia con todas las vías profesionales y de voluntariado."),
            ProgramTask("p5-02", 42, .comunidad, "Elige tu camino y sus requisitos",
                        "Investiga requisitos de edad, estudios, pruebas físicas y temario del camino que elijas. Escríbelo en la Bitácora."),
            ProgramTask("p5-03", 44, .comunidad, "Primer paso formal",
                        "Matricúlate en el curso, la FP o la academia de oposiciones, o asume más responsabilidad en tu agrupación."),
            ProgramTask("p5-04", 45, .comunidad, "Enseña RCP a 5 personas",
                        "Familia, amigos, compañeros. Cada persona que sabe RCP es un posible salvavidas más en tu ciudad."),
            ProgramTask("p5-05", 46, .comunidad, "Dona sangre",
                        "Cada donación puede ayudar a varias personas. Hombres hasta 4 veces al año y mujeres hasta 3."),
            ProgramTask("p5-06", 48, .comunidad, "Organiza una jornada en tu barrio",
                        "Con tu agrupación, el ayuntamiento o una asociación: taller de RCP, seguridad vial o prevención."),
            ProgramTask("p5-07", 50, .mente, "Carta a tu yo de la semana 1",
                        "Escribe en la Bitácora qué le dirías a la persona que empezó este programa."),
            ProgramTask("p5-08", 52, .fisico, "Test físico final",
                        "Compara con tu primer test. Mira todo lo que has construido."),
            ProgramTask("p5-09", 52, .mente, "Plan de mantenimiento",
                        "Define tu semana tipo para siempre: entrenos, clases, servicios, descanso y formación continua (reciclaje de RCP cada 1–2 años)."),
        ]
    )
}

enum DailyTips {
    static let all: [String] = [
        "Los héroes reales llevan chaleco reflectante, no capa.",
        "Bruce Wayne tardó años en formarse. La constancia gana a la intensidad.",
        "Si dudas entre intervenir o llamar, llama. Siempre puedes hacer ambas cosas.",
        "Dormir 8 horas es entrenamiento invisible.",
        "Ten siempre presente en qué calle y número estás: es lo primero que te preguntará el 112.",
        "Un buen testigo vale más que diez puños.",
        "Practica la respiración cuadrada antes de dormir: 4-4-4-4.",
        "Tu batería es parte de tu equipo. Sal siempre con el móvil por encima del 50 %.",
        "¿Sabes dónde está el desfibrilador más cercano a tu casa?",
        "Alcohol y noche son la combinación que más peleas provoca. Sal sobrio.",
        "Saber caer evita más lesiones que saber golpear.",
        "La confianza se gana en el barrio: saluda, conoce, escucha.",
        "Nunca grabes para redes. Si grabas algo, es para entregarlo a la policía.",
        "El miedo es información, no debilidad. Escúchalo.",
        "Revisa tu botiquín una vez al mes: caducidades y reposiciones.",
        "Batman tenía a Alfred. Ten siempre a alguien que sepa dónde estás.",
        "Correr bien es autodefensa: la mejor forma de ganar una pelea es no estar en ella.",
        "Aunque sean 10 minutos, entrena hoy.",
        "Un objeto robado se recupera. Una vida no. Si te piden el móvil con un arma, dalo.",
        "Proteger, Avisar, Socorrer: en ese orden, siempre.",
        "El ego es el villano más peligroso de todos.",
        "Hidrátate: 2 litros de agua al día, más si entrenas.",
        "Si alguien te sigue, entra en un comercio abierto o un lugar con gente y llama.",
        "Ayudar a una persona mayor a cruzar también cuenta. El heroísmo real es casi siempre pequeño.",
    ]

    static var today: String {
        let day = Calendar.current.ordinality(of: .day, in: .era, for: .now) ?? 0
        return all[day % all.count]
    }
}
