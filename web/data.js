// Generado por tools/swift_data_to_js.py a partir de Justiciero/Data/*.swift. No editar a mano.

const T = (id, week, category, title, detail) => ({ id, week, category, title, detail });

const B = (type, value) => ({ type, value });

const PHASES = (() => {
    const all = () => [cueva, forja, ciudad, detective, guardian, caballero]


    const cueva = {
        id: 0,
        codename: "LA CUEVA",
        title: "Fundamentos en casa",
        weeks: [1, 4],
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
            T("p0-01", 1, "mente", "Escribe tu porqué",
                        "Abre la Bitácora y escribe por qué quieres hacer esto. Sé sincero. Si la respuesta tiene que ver con rabia o venganza, habla antes con alguien de confianza o con un profesional: un protector actúa desde la calma, no desde la ira."),
            T("p0-02", 1, "fisico", "Evaluación física inicial",
                        "Ve a Más › Perfil y registra tu primer test: flexiones máximas, sentadillas en 1 minuto, plancha máxima y burpees en 1 minuto. No importa lo bajos que sean: es tu punto de partida."),
            T("p0-03", 1, "mente", "Chequeo médico básico",
                        "Si hace tiempo que no haces deporte o tienes alguna condición (corazón, asma, lesiones), pide cita con tu médico de cabecera antes de entrenar fuerte."),
            T("p0-04", 1, "mente", "Fija tu horario de sueño",
                        "Elige una hora fija para acostarte y levantarte. 7–9 horas. En las películas Bruce Wayne no duerme; en la vida real, la falta de sueño te hace más lento, más irritable y peor tomando decisiones."),
            T("p0-05", 2, "fisico", "Semana completa de entreno en casa",
                        "Completa 3 sesiones esta semana alternando Cueva A y Cueva B (pestaña Entreno). Deja al menos un día de descanso entre sesiones."),
            T("p0-06", 2, "ley", "Estudia «Ley y límites»",
                        "En Academia, completa las lecciones de Ley y límites. Es lo que separa a un ciudadano ejemplar de alguien con antecedentes penales."),
            T("p0-07", 2, "equipo", "Monta tu botiquín de casa",
                        "Guantes de nitrilo, gasas estériles, vendas, esparadrapo, suero fisiológico, antiséptico, manta térmica, tijeras de punta roma. Consulta Más › Equipamiento."),
            T("p0-08", 3, "habilidad", "Aprende PAS y RCP",
                        "Completa las lecciones de Primeros auxilios. Practica las compresiones sobre un cojín firme: 100–120 por minuto (al ritmo de «Stayin' Alive»)."),
            T("p0-09", 3, "mente", "Respiración táctica 7 días seguidos",
                        "5 minutos al día de respiración cuadrada (4 s inspirar, 4 s retener, 4 s espirar, 4 s retener). Es la herramienta n.º 1 para mantener la cabeza fría bajo estrés."),
            T("p0-10", 3, "habilidad", "Juega 3 partidas al Juego de Kim",
                        "En Academia › Juego de Kim. Entrena la memoria visual que usarás para ser un testigo útil."),
            T("p0-11", 4, "comunidad", "Cuéntaselo a tu «Alfred»",
                        "Elige a una persona de confianza y explícale tu plan. Añádela como contacto en Más › Perfil. Ningún justiciero real trabaja solo: Batman tenía a Alfred por algo."),
            T("p0-12", 4, "ley", "Supera 5 escenarios en el simulador",
                        "Academia › Simulador. Consigue al menos 5 escenarios con la respuesta óptima."),
            T("p0-13", 4, "fisico", "Repite la evaluación física",
                        "Haz el test de nuevo y compáralo con el de la semana 1. Celebra cualquier mejora."),
        ]
    }


    const forja = {
        id: 1,
        codename: "LA FORJA",
        title: "Cuerpo y técnica de combate",
        weeks: [5, 12],
        icon: "flame.fill",
        location: "Casa (tu dojo)",
        summary: "Montas tu dojo en casa y empiezas el camino de los cinturones: guardia, golpes, caídas y suelo con clases guiadas por la app. Además, haces un curso presencial de primeros auxilios y construyes resistencia de verdad.",
        whyThisOrder: "La técnica de combate se construye igual que la fuerza: poco a poco y sin saltarse pasos. Primero la guardia y los pies, luego los golpes, luego la defensa y por último la autodefensa aplicada. Grabarte y ser honesto en cada examen es lo que sustituye al ojo de un instructor.",
        objectives: [
            "Entrenar en el Dojo de la app 2–3 veces por semana y obtener el cinturón blanco.",
            "Correr 5 km seguidos.",
            "Obtener un certificado presencial de primeros auxilios / RCP.",
            "Aprender a caer sin hacerte daño.",
            "Dominar las técnicas básicas de desescalada verbal.",
        ],
        safetyRules: [
            "Todavía no sales de ronda. Correr de noche, solo por zonas iluminadas y conocidas.",
            "Nada de sparring ni golpes a personas. Con compañero, solo los ejercicios técnicos del Dojo, al 30 % y sin tocar la cabeza.",
            "Descansa: el músculo crece cuando descansas, no cuando entrenas.",
        ],
        minorNote: "El Dojo es apto para menores: entrena las caídas siempre sobre colchoneta y, si practicas con alguien, que haya un adulto delante. Los cursos de primeros auxilios de Cruz Roja también tienen versiones para jóvenes.",
        tasks: [
            T("p1-01", 5, "equipo", "Monta tu dojo en casa",
                        "Entreno › Dojo en casa › Monta tu dojo. Despeja 2 × 2 m, pon una colchoneta o un colchón viejo para las caídas y coloca el móvil o un espejo para verte."),
            T("p1-02", 5, "habilidad", "Tu primera clase del Dojo",
                        "Haz la clase del cinturón blanco con el entrenador por voz activado. Antes, lee las técnicas de la guardia, el jab y el directo."),
            T("p1-03", 8, "habilidad", "Un mes de dojo sin faltar",
                        "2–3 clases del Dojo por semana durante 4 semanas. La constancia es la superpotencia."),
            T("p1-04", 6, "fisico", "Programa de 0 a 5 km",
                        "3 días por semana, alternando caminar y trotar. Empieza con 1 min trote / 2 min caminar y ve aumentando. Objetivo: 5 km seguidos al final de la fase."),
            T("p1-05", 7, "fisico", "3 sesiones semanales de Forja",
                        "Alterna Forja · Fuerza y Forja · Combate en tus días sin clase."),
            T("p1-06", 7, "habilidad", "Aprende a caer",
                        "Domina la caída hacia atrás del cinturón blanco (Entreno › Dojo) y haz la sesión «Aprender a caer». Siempre sobre colchoneta. Saber caer evita más lesiones que saber golpear."),
            T("p1-07", 9, "habilidad", "Curso presencial de primeros auxilios + DEA",
                        "Cruz Roja, SAMUR, Protección Civil o tu ayuntamiento los organizan (a menudo gratis o baratos). Busca uno que incluya RCP con maniquí y uso del desfibrilador (DEA)."),
            T("p1-08", 9, "mente", "Estudia «Desescalada»",
                        "Completa el módulo en Academia. Practica las frases en voz alta: suena raro, pero en un momento de tensión saldrán solas."),
            T("p1-09", 10, "fisico", "Aprende o mejora a nadar",
                        "Un rescatador que no nada bien se convierte en la segunda víctima. Si no sabes, apúntate a un curso en la piscina municipal."),
            T("p1-10", 10, "mente", "Revisa tu alimentación",
                        "Proteína en cada comida, fruta y verdura, 2 litros de agua. Alcohol: lo mínimo. Batman no entrena con resaca."),
            T("p1-11", 11, "habilidad", "Describe a 7 personas",
                        "Durante una semana, una vez al día, describe en la Bitácora (tipo Observación) a alguien que hayas visto: altura, complexión, ropa de arriba abajo, calzado y un rasgo distintivo. Sin hacer fotos ni seguir a nadie."),
            T("p1-12", 12, "fisico", "Corre 5 km sin parar",
                        "Da igual el tiempo. Registra el tiempo en tu siguiente test físico."),
            T("p1-14", 12, "habilidad", "Cinturón blanco",
                        "Completa 8 clases y todos los puntos del examen del cinturón blanco. Grábate para comprobarlo."),
            T("p1-13", 12, "fisico", "Test físico de fin de fase",
                        "Objetivo orientativo: 20 flexiones, 40 sentadillas/min, 60 s de plancha."),
        ]
    }


    const ciudad = {
        id: 2,
        codename: "LA CIUDAD",
        title: "Conoce tu territorio",
        weeks: [13, 20],
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
            T("p2-01", 13, "equipo", "Configura Emergencia SOS y Ficha Médica",
                        "En el iPhone: Ajustes › Emergencia SOS (llamada con botones laterales) y la app Salud › Ficha Médica (alergias, grupo sanguíneo, contactos). Activa también compartir ubicación con tu «Alfred» en la app Buscar."),
            T("p2-02", 13, "equipo", "Instala AlertCops",
                        "Es la app oficial del Ministerio del Interior para alertar a Policía Nacional y Guardia Civil, incluso por chat. Útil cuando no puedes hablar. (Si no estás en España, busca la app equivalente de tu país)."),
            T("p2-03", 14, "habilidad", "Mapa de puntos seguros",
                        "Localiza y anota en la Bitácora: comisaría más cercana, centro de salud/hospital, farmacias 24 h, desfibriladores públicos (DEA), parque de bomberos y comercios abiertos hasta tarde."),
            T("p2-04", 14, "fisico", "3 rutas a pie de día",
                        "Recorre caminando o corriendo 3 rutas diferentes por tu barrio. Fíjate en nombres de calles, números de portal, zonas oscuras, salidas y lugares con gente."),
            T("p2-05", 15, "habilidad", "Estudia «Conciencia situacional»",
                        "Completa el módulo Ciudad y noche en Academia. Aprende el código de colores de Cooper."),
            T("p2-06", 16, "habilidad", "Orientación sin GPS",
                        "Haz una de tus rutas sin mirar el móvil. Si alguien te pregunta en el 112 dónde estás, tienes que saberlo sin abrir mapas."),
            T("p2-07", 16, "fisico", "Primera salida al anochecer (acompañado)",
                        "Repite una ruta conocida al anochecer con un amigo. Usa «Salida segura». Observa cómo cambia el barrio con la luz."),
            T("p2-08", 17, "comunidad", "Conoce a tu barrio",
                        "Preséntate al de la tienda de la esquina, al conserje, a tus vecinos. Los «ojos del barrio» son la mejor red de seguridad que existe."),
            T("p2-09", 18, "fisico", "Carrera nocturna con chaleco reflectante",
                        "Corre de noche por una ruta iluminada y conocida, con chaleco o prendas reflectantes, «Salida segura» activa y móvil cargado."),
            T("p2-10", 19, "habilidad", "Practica el aviso al 112 (en seco)",
                        "Escribe en la Bitácora cómo describirías por teléfono una emergencia en cada una de tus 3 rutas: dirección exacta, referencia visible, qué pasa. NO llames al 112 para practicar."),
            T("p2-11", 20, "mente", "Revisa tu porqué",
                        "Relee lo que escribiste en la semana 1. ¿Ha cambiado algo? Escribe una nueva entrada de Reflexión."),
            T("p2-13", 20, "habilidad", "Cinturón amarillo",
                        "Sigue con 2–3 clases del Dojo por semana y obtén el cinturón amarillo: los 6 golpes, esquivas y paradas."),
            T("p2-12", 20, "fisico", "Test físico de fin de fase",
                        "Objetivo orientativo: 25 flexiones, 5 km en menos de 35 min."),
        ]
    }


    const detective = {
        id: 3,
        codename: "EL DETECTIVE",
        title: "Observar, recordar, informar",
        weeks: [21, 28],
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
        minorNote: null,
        tasks: [
            T("p3-01", 21, "habilidad", "Estudia «Observación y testimonio»",
                        "Completa el módulo en Academia: descripción de personas, vehículos y la llamada perfecta al 112."),
            T("p3-02", 21, "habilidad", "Juego de Kim: 80 % o más",
                        "Consigue al menos un 80 % en el Juego de Kim en modo difícil."),
            T("p3-03", 22, "habilidad", "Sesión de observación en un banco",
                        "30 minutos sentado en un lugar público de día, observando el entorno sin intervenir: flujos de gente, horarios, qué es normal allí. Anota en la Bitácora qué sería «anormal» en ese sitio."),
            T("p3-04", 23, "habilidad", "Vehículos: practica la descripción",
                        "Durante una semana, al ver un coche aparcado, di mentalmente: tipo, color, marca, y una característica (pegatina, golpe, baca). Sin apuntar matrículas de nadie."),
            T("p3-05", 24, "ley", "Lee los artículos originales",
                        "Busca en el BOE: Código Penal art. 20 (legítima defensa) y 195 (omisión del deber de socorro), y LECrim arts. 490 y 491 (detención por particulares). Leer la fuente evita mitos."),
            T("p3-06", 24, "ley", "Todos los escenarios con respuesta óptima",
                        "Completa el simulador entero con la máxima puntuación."),
            T("p3-07", 25, "mente", "Estudia «Mentalidad»",
                        "Completa el módulo: el estrés agudo, el miedo y cómo afectan a tu cuerpo."),
            T("p3-08", 26, "comunidad", "Charla o curso de mediación/desescalada",
                        "Muchos ayuntamientos, ONG y universidades organizan talleres de mediación de conflictos. Apúntate a uno."),
            T("p3-09", 27, "fisico", "Mantén el entreno: 12 sesiones en la fase",
                        "Registra en la app al menos 12 entrenamientos durante esta fase, además de tus clases."),
            T("p3-11", 28, "habilidad", "Cinturones naranja y verde",
                        "Patadas, defensa en movimiento y rodadas. Si vas más lento, no pasa nada: la técnica limpia es más importante que la velocidad."),
            T("p3-10", 28, "fisico", "Test físico de fin de fase",
                        "Objetivo orientativo: 30 flexiones, 5 km en menos de 32 min, 90 s de plancha."),
        ]
    }


    const guardian = {
        id: 4,
        codename: "EL GUARDIÁN",
        title: "Servicio real y organizado",
        weeks: [29, 40],
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
            T("p4-01", 29, "comunidad", "Solicita entrar en Protección Civil o Cruz Roja",
                        "Busca la agrupación de voluntarios de Protección Civil de tu municipio o la asamblea local de Cruz Roja. Pregunta por el proceso de ingreso y la formación básica."),
            T("p4-02", 31, "comunidad", "Completa la formación básica de voluntario",
                        "Suele durar varias semanas. Aprenderás comunicaciones, organización de emergencias y primeros auxilios aplicados."),
            T("p4-03", 33, "comunidad", "Primer servicio preventivo",
                        "Fiestas patronales, conciertos, carreras populares... Lo normal es empezar acompañando a voluntarios veteranos."),
            T("p4-04", 35, "comunidad", "Primer servicio nocturno",
                        "Un servicio de noche con tu organización. Tu primera noche protegiendo tu ciudad de verdad."),
            T("p4-05", 32, "habilidad", "Certificado de Soporte Vital Básico + DEA",
                        "Curso oficial (SVB/DEA). En muchas comunidades autónomas es necesario para usar un desfibrilador con plena acreditación."),
            T("p4-06", 34, "comunidad", "Ofrece acompañamiento seguro",
                        "Ofrece a amigos o compañeros acompañarles a casa después de una noche fuera. Es simple y evita muchas situaciones."),
            T("p4-07", 36, "comunidad", "Red de aviso vecinal",
                        "Propón a tus vecinos un grupo para avisarse de incidencias y llamar al 092 o 112. Avisar, no patrullar ni señalar a personas."),
            T("p4-08", 37, "habilidad", "Cinturón azul: autodefensa",
                        "Liberarte de agarres, defenderte en el suelo y escapar. Practica las variantes con compañero, despacio y con alguien de confianza."),
            T("p4-09", 38, "habilidad", "Curso de socorrista o rescate acuático (opcional)",
                        "Si te gusta el agua, el título de socorrista es una de las formaciones más útiles para salvar vidas."),
            T("p4-10", 39, "comunidad", "Usa «Salida segura» en 10 salidas",
                        "El hábito de que alguien siempre sepa dónde estás tiene que ser automático."),
            T("p4-11", 40, "fisico", "Test físico de fin de fase",
                        "Objetivo orientativo: 35 flexiones, 5 km en menos de 30 min, 2 min de plancha."),
        ]
    }


    const caballero = {
        id: 5,
        codename: "CABALLERO DE LA NOCHE",
        title: "Hazlo tu vida",
        weeks: [41, 52],
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
            T("p5-01", 41, "comunidad", "Estudia «Caminos reales»",
                        "Lee el módulo en Academia con todas las vías profesionales y de voluntariado."),
            T("p5-02", 42, "comunidad", "Elige tu camino y sus requisitos",
                        "Investiga requisitos de edad, estudios, pruebas físicas y temario del camino que elijas. Escríbelo en la Bitácora."),
            T("p5-03", 44, "comunidad", "Primer paso formal",
                        "Matricúlate en el curso, la FP o la academia de oposiciones, o asume más responsabilidad en tu agrupación."),
            T("p5-04", 45, "comunidad", "Enseña RCP a 5 personas",
                        "Familia, amigos, compañeros. Cada persona que sabe RCP es un posible salvavidas más en tu ciudad."),
            T("p5-05", 46, "comunidad", "Dona sangre",
                        "Cada donación puede ayudar a varias personas. Hombres hasta 4 veces al año y mujeres hasta 3."),
            T("p5-06", 48, "comunidad", "Organiza una jornada en tu barrio",
                        "Con tu agrupación, el ayuntamiento o una asociación: taller de RCP, seguridad vial o prevención."),
            T("p5-07", 50, "mente", "Carta a tu yo de la semana 1",
                        "Escribe en la Bitácora qué le dirías a la persona que empezó este programa."),
            T("p5-10", 50, "habilidad", "Cinturones marrón y negro",
                        "Técnica bajo presión y maestría. El cinturón negro incluye enseñar los fundamentos a otra persona."),
            T("p5-08", 52, "fisico", "Test físico final",
                        "Compara con tu primer test. Mira todo lo que has construido."),
            T("p5-09", 52, "mente", "Plan de mantenimiento",
                        "Define tu semana tipo para siempre: entrenos, clases, servicios, descanso y formación continua (reciclaje de RCP cada 1–2 años)."),
        ]
    }

  return all();
})();

const WORKOUTS = (() => {
    const jumpingJacks = {id: "jacks", name: "Jumping jacks", icon: "figure.mixed.cardio",
        howTo: "Salta abriendo piernas y brazos a la vez, y vuelve a cerrar. Ritmo constante.",
        easier: "Sin saltar: abre una pierna cada vez mientras subes los brazos."}
    const squats = {id: "squat", name: "Sentadillas", icon: "figure.strengthtraining.functional",
        howTo: "Pies al ancho de hombros. Baja como si te sentaras en una silla, espalda recta, rodillas en la dirección de los pies. Sube empujando con los talones.",
        easier: "Siéntate y levántate de una silla de verdad."}
    const pushups = {id: "pushup", name: "Flexiones", icon: "figure.strengthtraining.traditional",
        howTo: "Manos algo más anchas que los hombros, cuerpo en línea recta de cabeza a talones. Baja el pecho casi al suelo y empuja. Codos a unos 45°, no abiertos en cruz.",
        easier: "Apoya las rodillas, o hazlas con las manos en una mesa o pared."}
    const glutebridge = {id: "bridge", name: "Puente de glúteo", icon: "figure.cooldown",
        howTo: "Tumbado boca arriba, rodillas dobladas. Eleva la cadera apretando glúteos hasta formar una línea recta hombros-rodillas. Aguanta 1 s arriba.",
        easier: "Reduce el recorrido."}
    const plank = {id: "plank", name: "Plancha", icon: "figure.core.training",
        howTo: "Apoyado en antebrazos y puntas de los pies. Cuerpo recto, abdomen y glúteos apretados. No dejes caer la cadera.",
        easier: "Apoya las rodillas."}
    const sidePlank = {id: "sideplank", name: "Plancha lateral", icon: "figure.core.training",
        howTo: "De lado, apoyado en un antebrazo, cadera arriba y cuerpo recto. El tiempo indicado es por cada lado.",
        easier: "Apoya la rodilla de abajo."}
    const superman = {id: "superman", name: "Superman", icon: "figure.pilates",
        howTo: "Boca abajo, eleva a la vez brazos estirados y piernas, aguanta 2 s y baja despacio. Fortalece la espalda.",
        easier: "Eleva solo brazo y pierna contrarios alternando."}
    const climbers = {id: "climbers", name: "Mountain climbers", icon: "figure.run",
        howTo: "En posición de flexión, lleva las rodillas al pecho alternando, rápido pero sin perder la línea del cuerpo.",
        easier: "Hazlo despacio, paso a paso."}
    const lunges = {id: "lunge", name: "Zancadas", icon: "figure.walk",
        howTo: "Da un paso largo y baja hasta que ambas rodillas formen 90°. La rodilla trasera casi roza el suelo. Alterna piernas.",
        easier: "Paso más corto y bajada parcial, apoyándote en una pared."}
    const chairDips = {id: "dips", name: "Fondos en silla", icon: "figure.strengthtraining.traditional",
        howTo: "Manos en el borde de una silla estable (contra la pared), piernas delante. Baja doblando codos hasta 90° y sube.",
        easier: "Piernas dobladas y recorrido corto."}
    const burpees = {id: "burpee", name: "Burpees", icon: "figure.cross.training",
        howTo: "De pie, agáchate, manos al suelo, salta atrás a plancha, vuelve a recoger y salta arriba. Ritmo controlado.",
        easier: "Sin flexión y sin salto: da los pasos atrás y adelante."}
    const invertedRow = {id: "row", name: "Remo invertido", icon: "figure.strengthtraining.traditional",
        howTo: "Bajo una mesa MUY robusta (o con barra baja en un parque), agarra el borde y tira del pecho hacia él con el cuerpo recto. Comprueba antes que la mesa no vuelque.",
        easier: "Con toalla en una puerta cerrada: tira de ti hacia la puerta inclinado hacia atrás."}
    const bulgarian = {id: "bulgarian", name: "Sentadilla búlgara", icon: "figure.strengthtraining.functional",
        howTo: "Pie trasero apoyado en una silla o sofá, baja con la pierna delantera. Repeticiones por pierna.",
        easier: "Zancada estática con ambos pies en el suelo."}
    const hollow = {id: "hollow", name: "Hollow hold", icon: "figure.core.training",
        howTo: "Boca arriba, zona lumbar pegada al suelo, eleva hombros y piernas estiradas formando una «banana». Aguanta.",
        easier: "Rodillas dobladas o brazos a los lados."}
    const shadowBoxing = {id: "shadow", name: "Sombra (boxeo)", icon: "figure.boxing",
        howTo: "Guardia alta, barbilla abajo. Golpes rectos y desplazamientos ligeros. Respira al golpear. Usa la técnica que hayas aprendido en el Dojo.",
        easier: "Ritmo suave, solo desplazamientos y guardia."}
    const sprawl = {id: "sprawl", name: "Sprawls", icon: "figure.cross.training",
        howTo: "Como un burpee rápido sin salto: echa las piernas atrás y la cadera al suelo para «defender un derribo», y vuelve a guardia.",
        easier: "Pasos atrás en vez de salto."}
    const breakfallBack = {id: "ukemi-back", name: "Caída hacia atrás", icon: "figure.fall",
        howTo: "SOBRE COLCHONETA O COLCHÓN. Desde sentado: barbilla al pecho, ruedas hacia atrás y golpeas el suelo con ambos brazos estirados a 45° para repartir el impacto. Cuando lo domines, desde cuclillas.",
        easier: "Solo el gesto de barbilla al pecho y rodar suave sobre la espalda."}
    const breakfallSide = {id: "ukemi-side", name: "Caída lateral", icon: "figure.fall",
        howTo: "SOBRE COLCHONETA. Desde cuclillas, extiende una pierna cruzando por delante, cae de lado y golpea el suelo con el brazo de ese lado. Barbilla siempre al pecho. Alterna lados.",
        easier: "Desde sentado, solo el balanceo y el golpe de brazo."}
    const roll = {id: "roll", name: "Rodada hacia delante", icon: "figure.gymnastics",
        howTo: "SOBRE COLCHONETA. Rodada diagonal por el hombro (no por la cabeza) hasta la cadera contraria y te levantas. Sigue la progresión de la técnica «Rodada hacia delante» del Dojo.",
        easier: "Rodada desde rodillas, muy despacio."}
    const mobility = {id: "mobility", name: "Movilidad articular", icon: "figure.flexibility",
        howTo: "Círculos de cuello, hombros, cadera, rodillas y tobillos. 10 en cada sentido, sin forzar.",
        easier: "Sentado en una silla."}
    const hipStretch = {id: "hip", name: "Estiramiento de cadera", icon: "figure.flexibility",
        howTo: "Postura de zancada con rodilla trasera en el suelo, empuja la cadera adelante. Tiempo por lado.",
        easier: "Apoya las manos en una silla."}
    const hamstring = {id: "hamstring", name: "Estiramiento isquios", icon: "figure.flexibility",
        howTo: "Sentado con piernas estiradas, inclínate hacia delante con la espalda recta. Sin rebotes.",
        easier: "Una pierna cada vez, la otra doblada."}
    const boxBreathing = {id: "breath", name: "Respiración cuadrada", icon: "wind",
        howTo: "4 s inspirar por la nariz, 4 s retener, 4 s soltar por la boca, 4 s retener. Repetir.",
        easier: "Usa 3 s en cada fase."}
    const warmJog = {id: "jog-warm", name: "Calentamiento caminando/trote", icon: "figure.walk",
        howTo: "Camina rápido o trota muy suave. Deberías poder hablar sin problema.",
        easier: "Solo caminar."}
    const easyRun = {id: "jog", name: "Carrera suave", icon: "figure.run",
        howTo: "Ritmo en el que puedas mantener una conversación. Si te ahogas, camina 1 min y vuelve a trotar.",
        easier: "Alterna 1 min trote y 1 min caminando."}
    const strides = {id: "strides", name: "Progresivos", icon: "figure.run",
        howTo: "Acelera poco a poco durante 20 s hasta casi tu máxima velocidad y vuelve caminando.",
        easier: "Llega solo al 70 % de tu velocidad."}
    const balance = {id: "balance", name: "Equilibrio en línea", icon: "figure.stand",
        howTo: "Camina sobre una línea del suelo o un bordillo BAJO (menos de 20 cm), mirando al frente. Ida y vuelta.",
        easier: "Sobre una línea pintada en el suelo."}
    const precision = {id: "precision", name: "Saltos de precisión", icon: "figure.jumprope",
        howTo: "A nivel del suelo: salta con los pies juntos de una marca a otra (1–1,5 m) y aterriza suave y en silencio, sobre la parte delantera del pie, flexionando rodillas.",
        easier: "Distancia más corta."}
    const stepUps = {id: "stepup", name: "Subidas a banco", icon: "figure.step.training",
        howTo: "Sube a un banco o escalón estable con una pierna, baja controlado. Repeticiones por pierna.",
        easier: "Escalón más bajo."}
    const quadruped = {id: "quad", name: "Cuadrupedia", icon: "figure.play",
        howTo: "A cuatro patas con rodillas a 2 cm del suelo, avanza moviendo mano y pie contrarios a la vez.",
        easier: "Rodillas apoyadas."}


    const all = () => [cuevaA, cuevaB, movilidad, caidas, forjaFuerza, forjaCombate, carrera, agilidad, guardian]

    const cuevaA = {
        id: "cueva-a", name: "Cueva A · Fuerza base", focus: "Fuerza general con tu peso",
        place: "Casa", minPhase: 0, minutes: 25, notes: "Si es tu primera vez, haz la versión fácil de cada ejercicio. Termina la sesión con sensación de que podías más.",
        blocks: [
            {exercise: jumpingJacks, sets: 2, reps: null, seconds: 40, rest: 20},
            {exercise: squats, sets: 3, reps: "12", seconds: null, rest: 60},
            {exercise: pushups, sets: 3, reps: "máx. con buena técnica", seconds: null, rest: 60},
            {exercise: glutebridge, sets: 3, reps: "15", seconds: null, rest: 45},
            {exercise: plank, sets: 3, reps: null, seconds: 30, rest: 45},
            {exercise: superman, sets: 2, reps: "12", seconds: null, rest: 45},
        ]}

    const cuevaB = {
        id: "cueva-b", name: "Cueva B · Resistencia", focus: "Cardio y resistencia muscular",
        place: "Casa", minPhase: 0, minutes: 25, notes: null,
        blocks: [
            {exercise: mobility, sets: 1, reps: null, seconds: 120, rest: 10},
            {exercise: climbers, sets: 3, reps: null, seconds: 30, rest: 30},
            {exercise: lunges, sets: 3, reps: "10/pierna", seconds: null, rest: 60},
            {exercise: chairDips, sets: 3, reps: "8", seconds: null, rest: 60},
            {exercise: burpees, sets: 3, reps: "6", seconds: null, rest: 60},
            {exercise: sidePlank, sets: 2, reps: null, seconds: 20, rest: 30},
        ]}

    const movilidad = {
        id: "movilidad", name: "Movilidad y calma", focus: "Recuperación, flexibilidad y control del estrés",
        place: "Casa", minPhase: 0, minutes: 15, notes: "Perfecta para los días de descanso o antes de dormir.",
        blocks: [
            {exercise: mobility, sets: 1, reps: null, seconds: 180, rest: 10},
            {exercise: hipStretch, sets: 2, reps: null, seconds: 40, rest: 10},
            {exercise: hamstring, sets: 2, reps: null, seconds: 45, rest: 10},
            {exercise: boxBreathing, sets: 1, reps: null, seconds: 300, rest: 0},
        ]}

    const caidas = {
        id: "caidas", name: "Aprender a caer", focus: "Caídas seguras (ukemi)",
        place: "Casa (colchoneta)", minPhase: 1, minutes: 20,
        notes: "Solo sobre superficie blanda: colchoneta gruesa, colchón en el suelo o tatami. Lee antes las técnicas de caídas del Dojo. Si tienes problemas de cuello o espalda, consulta antes con tu médico.",
        blocks: [
            {exercise: mobility, sets: 1, reps: null, seconds: 120, rest: 10},
            {exercise: breakfallBack, sets: 3, reps: "8", seconds: null, rest: 45},
            {exercise: breakfallSide, sets: 3, reps: "6/lado", seconds: null, rest: 45},
            {exercise: roll, sets: 3, reps: "4", seconds: null, rest: 60},
        ]}

    const forjaFuerza = {
        id: "forja-fuerza", name: "Forja · Fuerza", focus: "Fuerza relativa y control corporal",
        place: "Casa o parque", minPhase: 1, minutes: 35, notes: null,
        blocks: [
            {exercise: jumpingJacks, sets: 2, reps: null, seconds: 45, rest: 15},
            {exercise: pushups, sets: 4, reps: "12–15", seconds: null, rest: 75},
            {exercise: invertedRow, sets: 4, reps: "8", seconds: null, rest: 75},
            {exercise: bulgarian, sets: 3, reps: "10/pierna", seconds: null, rest: 75},
            {exercise: chairDips, sets: 3, reps: "12", seconds: null, rest: 60},
            {exercise: hollow, sets: 3, reps: null, seconds: 30, rest: 45},
        ]}

    const forjaCombate = {
        id: "forja-combate", name: "Forja · Combate", focus: "Resistencia anaeróbica tipo asalto",
        place: "Casa", minPhase: 1, minutes: 30,
        notes: "Simula la intensidad de un asalto, que es agotadora incluso para gente en forma. Complementa las clases del Dojo.",
        blocks: [
            {exercise: mobility, sets: 1, reps: null, seconds: 120, rest: 10},
            {exercise: shadowBoxing, sets: 5, reps: null, seconds: 60, rest: 30},
            {exercise: sprawl, sets: 4, reps: null, seconds: 30, rest: 30},
            {exercise: burpees, sets: 3, reps: "10", seconds: null, rest: 60},
            {exercise: plank, sets: 2, reps: null, seconds: 60, rest: 30},
            {exercise: boxBreathing, sets: 1, reps: null, seconds: 120, rest: 0},
        ]}

    const carrera = {
        id: "carrera", name: "Reconocimiento", focus: "Carrera aeróbica por tu barrio",
        place: "Exterior", minPhase: 2, minutes: 40,
        notes: "De día o por zonas iluminadas. Si es de noche: chaleco reflectante, «Salida segura» activada y ruta conocida. Aprovecha para fijarte en calles y puntos seguros.",
        blocks: [
            {exercise: warmJog, sets: 1, reps: null, seconds: 300, rest: 0},
            {exercise: easyRun, sets: 1, reps: null, seconds: 1500, rest: 60},
            {exercise: strides, sets: 5, reps: null, seconds: 20, rest: 60},
            {exercise: hamstring, sets: 1, reps: null, seconds: 60, rest: 0},
        ]}

    const agilidad = {
        id: "agilidad", name: "Agilidad urbana", focus: "Equilibrio, aterrizajes y control (parkour seguro)",
        place: "Parque", minPhase: 2, minutes: 30,
        notes: "Nada de alturas, tejados ni propiedad privada. Esto es control del cuerpo a ras de suelo. Si quieres más, busca un club de parkour con monitores.",
        blocks: [
            {exercise: mobility, sets: 1, reps: null, seconds: 120, rest: 10},
            {exercise: balance, sets: 3, reps: null, seconds: 60, rest: 30},
            {exercise: precision, sets: 3, reps: "8", seconds: null, rest: 60},
            {exercise: stepUps, sets: 3, reps: "12/pierna", seconds: null, rest: 60},
            {exercise: quadruped, sets: 3, reps: null, seconds: 30, rest: 45},
        ]}

    const guardian = {
        id: "guardian", name: "Circuito del Guardián", focus: "Preparación física para pruebas de acceso",
        place: "Casa o parque", minPhase: 4, minutes: 45,
        notes: "Inspirado en las pruebas físicas de cuerpos de seguridad y bomberos. Ajusta el volumen a tu nivel.",
        blocks: [
            {exercise: jumpingJacks, sets: 2, reps: null, seconds: 60, rest: 15},
            {exercise: burpees, sets: 4, reps: "12", seconds: null, rest: 60},
            {exercise: pushups, sets: 4, reps: "20", seconds: null, rest: 60},
            {exercise: invertedRow, sets: 4, reps: "12", seconds: null, rest: 60},
            {exercise: bulgarian, sets: 3, reps: "12/pierna", seconds: null, rest: 60},
            {exercise: strides, sets: 6, reps: null, seconds: 20, rest: 45},
            {exercise: hollow, sets: 3, reps: null, seconds: 45, rest: 30},
        ]}

  return all();
})();

const MODULES = (() => {
    const all = () => [ley, auxilios, desescalada, defensa, intervencion, observacion, ciudad, mentalidad, caminos, ciber]


    const ley = {
        id: "ley", title: "Ley y límites", icon: "building.columns.fill", colorName: "blue",
        intro: "Batman, en el mundo real, acabaría en prisión. Aquí aprendes qué puede hacer legalmente un ciudadano (bastante) y qué no (mucho). Basado en la legislación española; si vives en otro país, consulta la tuya.",
        lessons: [
            {id: "ley-1", title: "Por qué Batman sería ilegal", minutes: 4, blocks: [
                B("paragraph", "Ningún país permite que un particular se tome la justicia por su mano. Patrullar buscando delincuentes, interrogar, retener a alguien «por si acaso», ocultar tu identidad para intimidar o castigar a alguien son, en sí mismos, delitos."),
                B("bullets", [
                    "Pegar a un delincuente que ya no es una amenaza: **delito de lesiones**.",
                    "Retener a alguien fuera de los casos permitidos: **detención ilegal**.",
                    "Hacerte pasar por policía o llevar insignias que lo parezcan: **usurpación de funciones públicas** (art. 402 CP) y uso indebido de uniforme (art. 402 bis).",
                    "Amenazar a alguien para que «deje el barrio»: **amenazas o coacciones**.",
                ]),
                B("paragraph", "La buena noticia: la ley sí te permite (y en algunos casos te obliga a) ayudar. Socorrer, avisar, ser testigo, defenderte y defender a otros de forma proporcional, y en casos concretos detener a alguien in fraganti."),
                B("tip", "La pregunta correcta no es «¿qué puedo hacerle al malo?», sino «¿cómo consigo que la víctima esté a salvo y que la policía tenga lo necesario?»."),
            ]},
            {id: "ley-2", title: "Legítima defensa", minutes: 5, blocks: [
                B("paragraph", "El **artículo 20.4 del Código Penal** exime de responsabilidad a quien actúa en defensa de la persona o derechos **propios o ajenos**, siempre que se cumplan tres requisitos:"),
                B("steps", [
                    "**Agresión ilegítima**: un ataque real, actual o inminente. No vale un insulto, ni una amenaza vaga, ni algo que ya terminó.",
                    "**Necesidad racional del medio empleado**: tu respuesta debe ser proporcionada. Contra un empujón no cabe un golpe con un objeto.",
                    "**Falta de provocación suficiente** por tu parte: si tú iniciaste o buscaste la pelea, no hay legítima defensa.",
                ]),
                B("warning", "La legítima defensa termina cuando termina la agresión. Si el agresor huye, cae o deja de atacar y tú sigues, ya eres tú el agresor."),
                B("paragraph", "Los jueces valoran cada caso. Por eso la regla práctica es: **haz lo mínimo necesario para estar a salvo y vete**."),
            ]},
            {id: "ley-3", title: "Omisión del deber de socorro", minutes: 3, blocks: [
                B("paragraph", "El **artículo 195 del Código Penal** castiga a quien no socorre a una persona desamparada y en peligro manifiesto y grave, **cuando pueda hacerlo sin riesgo propio ni de terceros**."),
                B("paragraph", "Y si no puedes socorrer tú, estás obligado a **pedir auxilio urgente** (llamar al 112)."),
                B("tip", "La ley no te pide ser un héroe que se juega la vida. Te pide no mirar hacia otro lado. Llamar al 112 ya es cumplir con tu deber, y muchas veces es lo más útil que puedes hacer."),
            ]},
            {id: "ley-4", title: "Detener a alguien: cuándo sí y cuándo no", minutes: 5, blocks: [
                B("paragraph", "La **Ley de Enjuiciamiento Criminal (art. 490)** permite a cualquier persona detener, entre otros casos, al que intenta cometer un delito en el momento de ir a cometerlo y al **delincuente in fraganti**."),
                B("bullets", [
                    "Tiene que ser en el momento: no puedes «detener» a alguien horas después porque crees que fue él.",
                    "Debes usar la fuerza mínima imprescindible.",
                    "Debes entregar a la persona a la policía **inmediatamente**: llamas al 091/062/112 desde el primer segundo.",
                    "Según el art. 491, si el detenido lo exige, tendrás que justificar que actuaste por motivos racionalmente suficientes.",
                ]),
                B("danger", "Que la ley lo permita NO significa que sea buena idea. Una persona acorralada puede llevar un arma, puede tener amigos cerca y puede reaccionar con violencia extrema. La gran mayoría de las veces, la opción correcta es **no detener a nadie**: observa, memoriza y avisa."),
                B("paragraph", "Retener a alguien fuera de estos supuestos puede ser un delito de **detención ilegal** (art. 163 CP)."),
            ]},
            {id: "ley-5", title: "Armas, máscaras y grabaciones", minutes: 5, blocks: [
                B("heading", "Armas"),
                B("paragraph", "El **Reglamento de Armas** prohíbe a los particulares, entre otras, las porras y defensas extensibles, las nudilleras, las armas eléctricas tipo táser, los bastones-estoque y las navajas automáticas. Portar armas o instrumentos peligrosos en la vía pública puede sancionarse según la **Ley de Seguridad Ciudadana** (LO 4/2015)."),
                B("tip", "Llevar un arma no te hace más seguro: te hace más propenso a escalar el conflicto, y puede ser usada contra ti."),
                B("heading", "Ocultar tu identidad"),
                B("paragraph", "Ir por la calle con la cara tapada para «patrullar» genera alarma, dificulta que la gente confíe en ti y puede traerte problemas con la policía. Los héroes de verdad llevan la cara descubierta y un chaleco que dice quiénes son."),
                B("heading", "Grabar"),
                B("paragraph", "Grabar un delito para entregarlo a la policía puede ser útil. **Difundirlo** en redes con caras identificables puede vulnerar el derecho a la propia imagen y la protección de datos, perjudicar la investigación y ponerte en peligro."),
                B("warning", "Nunca grabes si eso te expone. Tu prioridad es tu seguridad y la de la víctima, no el vídeo."),
            ]},
            {id: "ley-6", title: "Anonimato: protegerte sin máscara", minutes: 5, blocks: [
                B("paragraph", "El miedo a que te reconozcan y haya represalias es lógico. Pero la máscara no te protege de eso y te crea problemas nuevos."),
                B("heading", "Por qué la máscara juega en tu contra"),
                B("bullets", [
                    "**La policía te parará**: una persona con la cara tapada rondando de noche es exactamente lo que alguien denuncia. Tendrás que identificarte igualmente, y negarte es sancionable (Ley de Seguridad Ciudadana).",
                    "**Agrava cualquier problema**: si pasa algo, actuar con disfraz es una circunstancia agravante (art. 22.2 del Código Penal), y a un juez le costará más creer que actuabas de buena fe.",
                    "**Asusta a la víctima**: para alguien en peligro, un enmascarado que se acerca es otra amenaza.",
                    "**No te hace irreconocible**: tu altura, tu forma de andar, tu ropa, tu voz y las cámaras siguen ahí.",
                ]),
                B("heading", "Lo que sí te protege"),
                B("steps", [
                    "**No te enfrentes a nadie.** Si no peleas, no persigues y no te pones delante, nadie tiene motivo para buscarte. Un testigo que llama desde lejos es casi invisible.",
                    "**Avisa sin dar tu nombre.** En el 091 y el 062 no estás obligado a identificarte para dar un aviso, y las webs de la Policía Nacional y la Guardia Civil tienen apartados de colaboración ciudadana. Lo tienes en Emergencias › Avisar de forma anónima.",
                    "**Cero rastro en redes.** Nada de vídeos, fotos ni comentarios sobre lo que veas o hagas. Tampoco lo cuentes por el barrio.",
                    "**Si tienes que declarar como testigo y temes represalias**, pide que te apliquen la Ley de Protección de Testigos (LO 19/1994): pueden ocultar tu nombre, tu domicilio y tu imagen.",
                    "**Cuando hagas servicio, que sea con uniforme de voluntario.** Con el chaleco de Protección Civil o Cruz Roja eres parte de un equipo con respaldo, no alguien que se metió en un asunto ajeno.",
                ]),
                B("tip", "La mejor forma de que no sepan quién eres es que nunca hayas sido parte de la historia: observa, avisa y deja que actúen quienes tienen la autoridad para hacerlo."),
            ]},
        ]}


    const auxilios = {
        id: "auxilios", title: "Primeros auxilios", icon: "cross.case.fill", colorName: "red",
        intro: "La habilidad con la que más vidas salvarás. Un justiciero que sabe RCP vale más que cien que saben pelear. Esto es una introducción: haz un curso presencial con maniquí.",
        lessons: [
            {id: "aux-1", title: "PAS: Proteger, Avisar, Socorrer", minutes: 3, blocks: [
                B("steps", [
                    "**Proteger**: asegúrate de que la escena es segura para ti, para la víctima y para otros (tráfico, fuego, cables, agresores). Si no lo es, no entres.",
                    "**Avisar**: llama al 112. Di dónde estás, qué ha pasado, cuántas víctimas y su estado. Pon el altavoz y no cuelgues.",
                    "**Socorrer**: aplica lo que sepas hasta que lleguen los servicios de emergencia.",
                ]),
                B("warning", "Si te conviertes en la segunda víctima, no ayudas a nadie y los equipos tendrán que atender a dos personas."),
                B("tip", "Si hay más gente, señala a alguien concreto: «Tú, el de la chaqueta roja, llama al 112». En grupo, todos piensan que otro ya ha llamado."),
            ]},
            {id: "aux-2", title: "RCP: reanimación cardiopulmonar", minutes: 6, blocks: [
                B("steps", [
                    "Comprueba si responde: háblale fuerte y sacúdele suavemente los hombros.",
                    "Si no responde, pide ayuda y abre la vía aérea: una mano en la frente, dos dedos en la barbilla, inclina la cabeza hacia atrás.",
                    "Comprueba si respira normalmente: mira, escucha y siente durante no más de 10 segundos. Las bocanadas aisladas NO son respiración normal.",
                    "Si no respira con normalidad: llama al 112 (altavoz) y pide que alguien traiga un desfibrilador (DEA).",
                    "Compresiones: talón de la mano en el centro del pecho, la otra encima, brazos rectos. Hunde 5–6 cm a un ritmo de 100–120 por minuto.",
                    "Si estás formado, alterna 30 compresiones y 2 insuflaciones. Si no, haz solo compresiones sin parar.",
                    "En cuanto llegue el DEA, enciéndelo y sigue sus instrucciones de voz. Están diseñados para que cualquiera los use.",
                    "No pares hasta que llegue la ayuda, la persona respire con normalidad o estés agotado (turnaos cada 2 minutos si hay alguien más).",
                ]),
                B("tip", "Ritmo: «Stayin' Alive» de los Bee Gees o «La Macarena» van a unos 100–120 pulsaciones por minuto."),
                B("warning", "Puede que oigas o notes costillas romperse. Es normal y no debes parar: una costilla rota se cura; sin RCP, la persona muere."),
            ]},
            {id: "aux-3", title: "Posición lateral de seguridad", minutes: 3, blocks: [
                B("paragraph", "Si la persona está **inconsciente pero respira con normalidad** y no sospechas lesión de columna (caída, golpe fuerte, accidente), colócala de lado para que no se ahogue con vómito o con su lengua."),
                B("steps", [
                    "Arrodíllate a su lado. Brazo más cercano a ti en ángulo recto, palma hacia arriba.",
                    "El otro brazo, cruzado sobre el pecho, con el dorso de la mano contra su mejilla.",
                    "Dobla la rodilla más lejana y tira de ella hacia ti para girar el cuerpo de lado.",
                    "Inclina la cabeza ligeramente hacia atrás para mantener abierta la vía aérea.",
                    "Abrígala y vigila su respiración hasta que llegue la ayuda.",
                ]),
            ]},
            {id: "aux-4", title: "Atragantamiento", minutes: 3, blocks: [
                B("bullets", [
                    "Si puede **toser**: anímale a seguir tosiendo con fuerza. No le des golpes.",
                    "Si **no puede toser, hablar ni respirar**: colócate a su lado, inclínale hacia delante y dale hasta **5 golpes** firmes entre los omóplatos con el talón de la mano.",
                    "Si no funciona: hasta **5 compresiones abdominales** (maniobra de Heimlich). Detrás de la persona, puño encima del ombligo, la otra mano encima, tira hacia dentro y hacia arriba.",
                    "Alterna 5 y 5. Si pierde la consciencia: llama al 112 y empieza RCP.",
                ]),
                B("warning", "En embarazadas y personas con obesidad, las compresiones se hacen en el pecho. En bebés la técnica es diferente: apréndela en un curso."),
            ]},
            {id: "aux-5", title: "Hemorragias, quemaduras y convulsiones", minutes: 5, blocks: [
                B("heading", "Hemorragias"),
                B("bullets", [
                    "Ponte guantes si los tienes.",
                    "Presión directa y firme sobre la herida con gasas o tela limpia. Mantén la presión sin levantar para mirar.",
                    "Si se empapa, pon más gasas encima; no retires las primeras.",
                    "El torniquete es solo para hemorragias masivas en extremidades, y conviene haber sido formado para usarlo.",
                    "Si hay un objeto clavado, NO lo saques: inmovilízalo y presiona alrededor.",
                ]),
                B("heading", "Quemaduras"),
                B("bullets", [
                    "Agua corriente a temperatura ambiente durante al menos 20 minutos.",
                    "Quita anillos y pulseras antes de que se hinche. No despegues ropa adherida.",
                    "Nada de pasta de dientes, aceite ni hielo directo.",
                ]),
                B("heading", "Convulsiones"),
                B("bullets", [
                    "Aparta objetos peligrosos y protege la cabeza con algo blando.",
                    "NO le sujetes ni le metas nada en la boca.",
                    "Cronometra la crisis. Si dura más de 5 minutos, se repite o es la primera vez, llama al 112.",
                    "Al terminar, posición lateral de seguridad.",
                ]),
            ]},
        ]}


    const desescalada = {
        id: "desescalada", title: "Desescalada", icon: "bubble.left.and.bubble.right.fill", colorName: "green",
        intro: "El arte de bajar la temperatura de un conflicto sin que nadie salga herido. Es la técnica de combate más avanzada que existe.",
        lessons: [
            {id: "des-1", title: "Distancia, postura y voz", minutes: 4, blocks: [
                B("bullets", [
                    "**Distancia**: al menos dos brazos. Te da tiempo de reaccionar y no invade a la otra persona.",
                    "**Ángulo**: colócate ligeramente de lado, no de frente. Es menos desafiante y más estable.",
                    "**Manos visibles y abiertas** a la altura del pecho, como si dijeras «tranquilo». Comunican paz y, a la vez, están listas para protegerte.",
                    "**Voz**: baja, lenta y calmada. Si la otra persona grita, no subas el volumen: bájalo.",
                    "**Salida**: nunca acorrales a nadie y no te dejes acorralar. Ambos necesitáis una salida.",
                ]),
                B("tip", "Tu calma se contagia. Tu nerviosismo, también."),
            ]},
            {id: "des-2", title: "Qué decir (y qué no)", minutes: 5, blocks: [
                B("heading", "Funciona"),
                B("bullets", [
                    "«Veo que estás muy enfadado. ¿Qué ha pasado?»",
                    "«Tienes razón en que eso es injusto.» (Validar la emoción no es dar la razón en todo.)",
                    "«Quiero que esto acabe bien para todos.»",
                    "Preguntar el nombre y usarlo.",
                    "Ofrecer opciones: «¿Prefieres que hablemos aquí o vamos fuera a tomar el aire?»",
                ]),
                B("heading", "Empeora"),
                B("bullets", [
                    "«Cálmate.» (Casi nunca calma a nadie.)",
                    "Amenazar, retar, burlarse o hacer bromas.",
                    "Tocar a la persona sin permiso.",
                    "Discutir quién tiene razón en ese momento.",
                    "Hablar con desprecio delante de otros: nadie quiere quedar mal ante su grupo.",
                ]),
            ]},
            {id: "des-3", title: "Saber retirarse", minutes: 3, blocks: [
                B("paragraph", "Desescalar no siempre funciona. Las drogas, el alcohol, una crisis de salud mental o un grupo que se jalea pueden hacer imposible razonar."),
                B("bullets", [
                    "Señales de que va a haber agresión: puños apretados, mandíbula tensa, mirada fija o que se desvía buscando objetivo, se quita la chaqueta o las gafas, acorta la distancia, deja de hablar de repente.",
                    "Si ves estas señales: aumenta la distancia, retírate hacia tu salida y llama al 112.",
                ]),
                B("tip", "Retirarse no es perder. Quien vuelve sano a casa, gana."),
            ]},
        ]}


    const defensa = {
        id: "defensa", title: "Defensa personal realista", icon: "figure.martial.arts", colorName: "orange",
        intro: "La verdad que no venden en los vídeos: en la calle no hay reglas, no hay árbitro, puede haber armas, varios agresores y suelo de cemento. La mejor defensa casi siempre es no estar allí.",
        lessons: [
            {id: "def-1", title: "La pirámide de prioridades", minutes: 4, blocks: [
                B("steps", [
                    "**Evitar**: no ir, cambiar de acera, salir antes, no responder a provocaciones.",
                    "**Escapar**: si puedes irte, vete. Correr es una técnica de autodefensa excelente.",
                    "**Desescalar**: hablar para enfriar la situación.",
                    "**Defenderse**: solo si no queda otra opción, con lo mínimo imprescindible para poder escapar.",
                ]),
                B("danger", "Si alguien te amenaza con un arma para robarte, DALE LO QUE PIDE. Ningún móvil, cartera ni zapatillas vale tu vida. Memoriza su descripción y llama después."),
            ]},
            {id: "def-2", title: "Qué aprendes en el Dojo y por qué", minutes: 5, blocks: [
                B("paragraph", "El Dojo de la app (Entreno › Dojo en casa) mezcla lo más útil de varias disciplinas para un objetivo concreto: **protegerte lo justo para poder escapar**."),
                B("bullets", [
                    "**Del boxeo**: la guardia, los desplazamientos, los 6 golpes de puño y las esquivas. Es la base más práctica para protegerte la cabeza.",
                    "**Del kickboxing y el muay thai**: la patada frontal para crear distancia, la patada baja, la rodilla y cómo defender patadas.",
                    "**Del judo**: las caídas. Es lo que más te puede salvar en una situación real (un empujón, un resbalón).",
                    "**Del jiu-jitsu y la lucha**: el puente, el escape de cadera, el sprawl y levantarte del suelo sin quedar expuesto.",
                    "**De la defensa personal**: la valla, liberarte de agarres y, sobre todo, la idea de que cada técnica termina escapando.",
                ]),
                B("tip", "En casa, tu instructor eres tú con el móvil: grábate, compara con los pasos de cada técnica y sé honesto en los exámenes. La constancia durante años importa más que cualquier disciplina."),
                B("warning", "Lo que el Dojo no puede darte es un rival que se resiste. Por eso las técnicas de autodefensa tienen variantes con compañero, siempre lentas. Y desconfía de cualquiera que te venda «técnicas letales» o ataques «que funcionan siempre»."),
            ]},
            {id: "def-3", title: "Lo que la calle tiene de distinto", minutes: 4, blocks: [
                B("bullets", [
                    "**Armas ocultas**: asume que cualquiera puede llevar una navaja. Muchas víctimas de apuñalamiento ni la vieron.",
                    "**Varios agresores**: el suelo es mortal si hay más de uno. Prioriza mantenerte de pie y salir.",
                    "**Superficies**: un golpe de cabeza contra el bordillo puede matar. A ti o al otro (y eso también te arruina la vida).",
                    "**Adrenalina**: perderás coordinación fina, visión periférica y noción del tiempo. Solo funciona lo que has entrenado cientos de veces.",
                ]),
                B("paragraph", "Por eso este programa no te convierte en un luchador callejero, sino en alguien en forma, que sabe protegerse lo justo para escapar y que dedica su energía a lo que de verdad salva vidas."),
            ]},
        ]}


    const observacion = {
        id: "observacion", title: "Observación y testimonio", icon: "eye.fill", colorName: "purple",
        intro: "El superpoder detective. La policía resuelve muchos casos gracias a testigos que se fijaron bien y lo contaron con claridad.",
        lessons: [
            {id: "obs-1", title: "Describir a una persona", minutes: 5, blocks: [
                B("paragraph", "Describe siempre de **arriba abajo** y de lo general a lo particular:"),
                B("steps", [
                    "Sexo aparente y edad aproximada (en rangos: «entre 25 y 30»).",
                    "Altura: compárala con algo (tu altura, una puerta, un coche).",
                    "Complexión: delgada, media, fuerte, corpulenta.",
                    "Pelo y cara: color, longitud, barba, gafas, cicatrices, tatuajes visibles.",
                    "Ropa de arriba abajo: gorra, chaqueta, pantalón. Colores y logotipos.",
                    "**Calzado**: es lo que menos se cambia al huir. Fíjate bien.",
                    "Objetos: mochila, bolsa, lo que lleve en la mano.",
                    "Forma de moverse o hablar: cojera, acento, voz.",
                    "Dirección y medio de huida.",
                ]),
                B("tip", "La ropa se cambia en minutos; los rasgos físicos, el calzado y los tatuajes no. Prioriza esos detalles."),
            ]},
            {id: "obs-2", title: "Describir un vehículo", minutes: 3, blocks: [
                B("bullets", [
                    "**Matrícula**, aunque sea parcial. Repítela en voz alta o escríbela en el móvil enseguida.",
                    "Tipo (turismo, furgoneta, moto), color, marca y modelo si lo sabes.",
                    "Detalles: golpes, pegatinas, baca, lunas tintadas, luces rotas.",
                    "Número de ocupantes y dónde iban sentados.",
                    "Dirección de huida y hora exacta.",
                ]),
                B("warning", "Nunca sigas a un vehículo. Ni a pie, ni en coche, ni en patinete."),
            ]},
            {id: "obs-3", title: "La llamada perfecta al 112", minutes: 4, blocks: [
                B("paragraph", "Los operadores están entrenados para guiarte. Contesta a lo que te pregunten, pero ten preparadas estas respuestas:"),
                B("steps", [
                    "**¿Dónde?** Calle, número, municipio, y una referencia visible («frente a la farmacia»).",
                    "**¿Qué pasa?** En una frase.",
                    "**¿Cuántas personas** implicadas y cuántos heridos?",
                    "**¿Hay armas** o peligro activo?",
                    "**¿Hacia dónde** han huido y cómo (a pie, coche, moto)?",
                    "Descripciones.",
                ]),
                B("tip", "No cuelgues hasta que el operador te lo diga. Si no puedes hablar, deja la línea abierta o usa AlertCops."),
                B("paragraph", "Números en España: **112** emergencias generales · **091** Policía Nacional · **062** Guardia Civil · **092** Policía Local · **016** violencia de género · **024** conducta suicida."),
            ]},
            {id: "obs-4", title: "Tu memoria bajo estrés", minutes: 3, blocks: [
                B("bullets", [
                    "La memoria se degrada en minutos y se contamina al hablar con otros testigos. **Escribe todo lo que recuerdes cuanto antes**, a solas.",
                    "Separa lo que **sabes** de lo que **crees**: «llevaba algo en la mano, creo que era un móvil».",
                    "Decir «no lo sé» es mucho más útil que inventar. Un detalle falso puede desviar una investigación.",
                    "La hora exacta es oro: mira el reloj en cuanto puedas.",
                ]),
            ]},
        ]}


    const ciudad = {
        id: "ciudad", title: "Ciudad y noche", icon: "moon.haze.fill", colorName: "teal",
        intro: "Moverse por la ciudad de noche con los ojos abiertos, sin paranoia y sin exponerse.",
        lessons: [
            {id: "ciu-1", title: "El código de colores de Cooper", minutes: 4, blocks: [
                B("bullets", [
                    "**Blanco**: desconectado. Mirando el móvil, auriculares a tope. Así es como sorprenden a la gente.",
                    "**Amarillo**: atento y relajado. Sabes quién hay a tu alrededor y dónde están las salidas. Es tu estado normal en la calle.",
                    "**Naranja**: algo concreto te ha llamado la atención. Piensas «si pasa X, haré Y».",
                    "**Rojo**: la amenaza es real. Ejecutas tu plan: irte, llamar, protegerte.",
                ]),
                B("tip", "Vive en amarillo. No es miedo: es como conducir mirando los retrovisores."),
            ]},
            {id: "ciu-2", title: "Hábitos de seguridad nocturna", minutes: 4, blocks: [
                B("bullets", [
                    "Planifica la ruta antes de salir. Elige calles iluminadas y con gente aunque sea más largo.",
                    "Auriculares: uno solo o volumen bajo.",
                    "Móvil cargado y con la ubicación compartida con tu persona de confianza.",
                    "Si notas que alguien te sigue: cruza la calle, cambia de ritmo, entra en un comercio abierto o en un sitio con gente, y llama.",
                    "Lleva las llaves a mano al llegar a casa. No te quedes en el portal mirando el móvil.",
                    "Confía en tu intuición. Si algo no te cuadra, no necesitas justificarlo: vete.",
                ]),
            ]},
            {id: "ciu-3", title: "Tu mapa mental de puntos seguros", minutes: 3, blocks: [
                B("paragraph", "En cada zona por la que te muevas, deberías saber sin mirar el móvil:"),
                B("bullets", [
                    "Dónde está la comisaría o cuartel más cercano.",
                    "El centro de salud u hospital más cercano.",
                    "Farmacias de guardia y comercios abiertos 24 h.",
                    "Desfibriladores públicos (en farmacias, estaciones, polideportivos, centros comerciales).",
                    "Zonas oscuras, solares o pasos subterráneos que conviene evitar.",
                ]),
            ]},
        ]}


    const mentalidad = {
        id: "mentalidad", title: "Mentalidad", icon: "brain.head.profile", colorName: "pink",
        intro: "El cuerpo hace lo que la mente le permite. Aprende a gestionar el miedo, el estrés y el ego.",
        lessons: [
            {id: "men-1", title: "Qué le pasa a tu cuerpo bajo estrés", minutes: 4, blocks: [
                B("bullets", [
                    "**Visión de túnel**: dejas de ver lo que pasa a los lados (¿el amigo del agresor?).",
                    "**Exclusión auditiva**: dejas de oír o los sonidos se apagan.",
                    "**Pérdida de motricidad fina**: te cuesta marcar el móvil o abrir una puerta.",
                    "**Distorsión del tiempo**: todo parece ir a cámara lenta o muy rápido.",
                    "**Temblores y náuseas** después, cuando baja la adrenalina.",
                ]),
                B("tip", "Por eso hay que entrenar acciones simples hasta que sean automáticas: llamar al 112, la secuencia de RCP, retirarse. Bajo estrés no se improvisa bien."),
            ]},
            {id: "men-2", title: "Respiración táctica", minutes: 3, blocks: [
                B("paragraph", "La usan militares, policías, bomberos y deportistas de élite para bajar las pulsaciones en segundos."),
                B("steps", [
                    "Inspira por la nariz contando 4.",
                    "Retén el aire contando 4.",
                    "Suelta por la boca contando 4.",
                    "Mantén los pulmones vacíos contando 4.",
                    "Repite 4 ciclos.",
                ]),
                B("tip", "Practícala a diario cuando estés tranquilo. Así funcionará cuando no lo estés."),
            ]},
            {id: "men-3", title: "Tu porqué y tus villanos internos", minutes: 4, blocks: [
                B("paragraph", "Batman es un personaje construido sobre un trauma y una sed de venganza. Es buena ficción, pero mala receta para la vida real."),
                B("bullets", [
                    "**Ego**: querer ser el héroe de la historia te empuja a intervenir cuando lo correcto es llamar.",
                    "**Rabia**: si te enfadas con facilidad o buscas que «alguien se lo merezca», el peligro eres tú.",
                    "**Aislamiento**: el justiciero solitario acaba quemado o haciendo locuras. Rodéate de gente.",
                ]),
                B("paragraph", "Si arrastras rabia, un trauma o un dolor que te empuja a esto, hablar con un profesional de salud mental no es debilidad: es el entrenamiento más importante de todos."),
                B("tip", "Si alguna vez tienes pensamientos de hacerte daño, llama al 024 (gratuito, 24 h)."),
            ]},
        ]}


    const caminos = {
        id: "caminos", title: "Caminos reales", icon: "signpost.right.and.left.fill", colorName: "yellow",
        intro: "Hay muchas maneras legales y respetadas de proteger a la gente por la noche. Algunas son voluntarias y otras son una profesión. Requisitos orientativos: compruébalos siempre en las convocatorias oficiales.",
        lessons: [
            {id: "cam-1", title: "Voluntariado", minutes: 4, blocks: [
                B("bullets", [
                    "**Protección Civil**: agrupaciones municipales de voluntarios. Servicios preventivos en eventos, emergencias, búsquedas, incendios. Formación básica gratuita y uniforme.",
                    "**Cruz Roja**: socorros y emergencias, salvamento acuático y unidades de emergencia social que atienden de noche a personas sin hogar.",
                    "**Bancos de sangre**: donar sangre o registrarte como donante de médula.",
                    "**ONG y asociaciones de barrio**: acompañamiento a mayores, jóvenes en riesgo, mediación.",
                ]),
                B("tip", "El chaleco de voluntario es el traje de superhéroe que la gente reconoce y en el que confía."),
            ]},
            {id: "cam-2", title: "Profesiones", minutes: 6, blocks: [
                B("bullets", [
                    "**Policía Nacional, Guardia Civil, Policía Local o autonómica**: oposición con pruebas físicas, de conocimientos y psicotécnicas. Requieren nacionalidad española y carecer de antecedentes, entre otros requisitos.",
                    "**Bombero**: oposiciones muy exigentes físicamente. Suelen pedir carné de conducir profesional.",
                    "**Técnico en Emergencias Sanitarias (TES)**: FP de grado medio. Trabajas en ambulancias.",
                    "**Vigilante de seguridad**: curso de formación y examen oficial ante la Policía Nacional para obtener la TIP. Mayor de edad.",
                    "**Socorrista acuático**: curso con certificación. Ideal como primer trabajo o complemento.",
                    "**Fuerzas Armadas / UME**: la Unidad Militar de Emergencias actúa en catástrofes.",
                    "**Enfermería, medicina, trabajo social, criminología, derecho**: carreras que protegen a la gente desde otro ángulo.",
                ]),
                B("tip", "Casi todas estas pruebas exigen buena forma física. Lo que has entrenado en este programa es una gran base."),
            ]},
        ]}


    const ciber = {
        id: "ciber", title: "Ciber-Batman", icon: "lock.shield.fill", colorName: "blue",
        intro: "La mayoría de los delitos que sufre hoy la gente de tu barrio no ocurren en un callejón, sino en el móvil. Con conocimientos de ciberseguridad puedes proteger a más personas que cualquier justiciero nocturno, siempre dentro de la ley.",
        lessons: [
            {id: "cib-1", title: "Las estafas más comunes", minutes: 6, blocks: [
                B("paragraph", "Casi todas siguen el mismo patrón: **urgencia + autoridad o cariño + un pago o un código**. Si aprendes a ver el patrón, las ves venir todas."),
                B("bullets", [
                    "**El hijo en apuros**: «Hola mamá, se me ha roto el móvil, este es mi número nuevo. ¿Me haces un Bizum urgente?»",
                    "**Falso banco, Correos o DGT**: un SMS con un enlace para «verificar tu cuenta», «pagar el envío» o «pagar una multa».",
                    "**Falso técnico**: te llaman «de Microsoft» o de tu compañía para arreglar un virus y te piden instalar un programa de control remoto.",
                    "**El código de verificación**: alguien te pide «el código que te acaba de llegar». Con él te roban el WhatsApp o autorizan un pago.",
                    "**Bizum inverso**: en una compraventa, en vez de enviarte dinero te mandan una *solicitud* de pago para que la aceptes tú.",
                    "**Inversiones milagro**: anuncios con famosos que prometen hacerte rico con criptomonedas. El dinero desaparece.",
                    "**Estafa del amor**: alguien que conoces por internet, nunca puede hacer videollamada y acaba pidiendo dinero por una emergencia.",
                ]),
                B("tip", "La regla de oro que enseñarás a tu familia: **ningún banco, empresa ni organismo te pide nunca contraseñas ni códigos**. Ante la duda, cuelga y llama tú al número oficial."),
            ]},
            {id: "cib-2", title: "Ayudar a una víctima de estafa", minutes: 5, blocks: [
                B("paragraph", "Los primeros minutos importan: cuanto antes se actúa, más posibilidades hay de recuperar el dinero y de que la policía pueda investigar."),
                B("steps", [
                    "**Llamar al banco ya**, al teléfono del reverso de la tarjeta: bloquear tarjetas y pedir que intenten parar o devolver la transferencia.",
                    "**Recuperar el control**: cambiar primero la contraseña del correo, después la del banco y las redes. Activar la verificación en dos pasos y cerrar las sesiones abiertas.",
                    "**Guardar pruebas, no borrar nada**: capturas con fecha y hora, números de teléfono, enlaces, nombres de perfiles, justificantes de pago.",
                    "**Denunciar** en la Policía Nacional o la Guardia Civil, llevando todas las pruebas. Sin denuncia no hay investigación ni posible devolución.",
                    "**Llamar al 017**, la línea de ayuda en ciberseguridad del INCIBE: gratuita y confidencial. Te orientan paso a paso.",
                    "**Avisar a sus contactos** si han suplantado su identidad o su WhatsApp, para que nadie más pique.",
                ]),
                B("warning", "La víctima suele sentir vergüenza. Nunca le digas «¿cómo has picado?». Estas estafas las diseñan profesionales y caen personas de todas las edades y estudios."),
            ]},
            {id: "cib-3", title: "OSINT legal: qué sí y qué no", minutes: 5, blocks: [
                B("paragraph", "OSINT es la investigación con **fuentes abiertas**: información que cualquiera puede consultar legalmente. Bien usada, ayuda a encontrar personas desaparecidas o a documentar una estafa para la policía."),
                B("heading", "Sí"),
                B("bullets", [
                    "Buscar en webs, redes y registros públicos.",
                    "Documentar con capturas fechadas y enlaces todo lo que encuentres.",
                    "Entregar lo encontrado a la policía o a la organización que coordina la búsqueda.",
                    "Participar en iniciativas organizadas, como las búsquedas de desaparecidos de Trace Labs.",
                ]),
                B("heading", "No"),
                B("bullets", [
                    "Entrar en cuentas, móviles u ordenadores ajenos, ni adivinar contraseñas.",
                    "Contactar o engañar a sospechosos haciéndote pasar por otra persona.",
                    "Publicar datos o fotos de nadie («doxing»), aunque creas que es culpable.",
                    "Investigar a personas concretas por tu cuenta, fuera de una búsqueda organizada o un encargo legal.",
                ]),
                B("warning", "Exponer en redes a un supuesto delincuente puede arruinar la investigación policial, poner en peligro a inocentes y acabar en una denuncia contra ti."),
            ]},
            {id: "cib-4", title: "Peritaje: pruebas que valen en un juicio", minutes: 6, blocks: [
                B("paragraph", "Un juez no condena por una captura de pantalla dudosa. Condena con pruebas que se pueden verificar. Eso es lo que hace un perito informático forense, y es probablemente el trabajo más «Batman» al que puedes aspirar con tu formación."),
                B("steps", [
                    "**Preservar**: no manipular el dispositivo original. Si está encendido, aislarlo de la red (modo avión) en vez de apagarlo sin criterio.",
                    "**Adquirir**: hacer una copia forense bit a bit con bloqueador de escritura, y trabajar siempre sobre la copia.",
                    "**Verificar**: calcular el hash (por ejemplo, SHA-256) del original y de la copia para demostrar que son idénticos.",
                    "**Cadena de custodia**: documentar quién, cuándo, dónde y cómo ha tenido la evidencia en cada momento.",
                    "**Informe pericial**: claro, reproducible y entendible por alguien que no sea técnico. Debes poder defenderlo ante el juez.",
                ]),
                B("tip", "Para conversaciones de WhatsApp o publicaciones en redes, una captura se puede impugnar. Existen servicios de certificación de evidencias digitales y el acta notarial que les dan validez."),
            ]},
            {id: "cib-5", title: "Líneas rojas que nunca se cruzan", minutes: 4, blocks: [
                B("paragraph", "Saber atacar sistemas no te da permiso para hacerlo, ni siquiera contra un delincuente. Un hacker justiciero es, para la ley, un delincuente más, y sus «pruebas» no valen."),
                B("bullets", [
                    "**Acceso sin autorización** a sistemas o cuentas: delito (art. 197 bis del Código Penal).",
                    "**Interceptar comunicaciones** o apoderarse de mensajes, correos o datos ajenos: delito de descubrimiento y revelación de secretos (art. 197).",
                    "**Tumbar webs o dañar sistemas** (DDoS, borrar datos): delito de daños informáticos (arts. 264 y siguientes).",
                    "**Hacerte pasar por otra persona** para engañar: puede ser usurpación de estado civil o estafa.",
                    "**Atacar al atacante** («hack back»): ilegal aunque te hayan atacado a ti primero.",
                ]),
                B("tip", "Las pruebas de seguridad solo se hacen con **autorización por escrito** del propietario o dentro de programas de recompensas (bug bounty) que lo permitan expresamente."),
            ]},
            {id: "cib-6", title: "Protege tu identidad: audítate a ti mismo", minutes: 8, blocks: [
                B("paragraph", "Hoy nadie te localiza siguiéndote por la calle: te buscan en internet. Una máscara no tapa nada de eso. Una buena higiene digital, sí. Haz contigo mismo el OSINT que harías en una investigación."),
                B("heading", "1. Qué se sabe de ti"),
                B("steps", [
                    "Busca tu nombre completo entre comillas, tus usuarios de redes, tu correo y tu teléfono en varios buscadores. Apunta todo lo que salga.",
                    "Haz una búsqueda inversa de tu cara (por ejemplo, con Google Lens) usando tus fotos de perfil.",
                    "Marca en rojo lo que revela **dónde vives, dónde trabajas, tu rutina o tu familia**: es lo que hay que borrar primero.",
                ]),
                B("heading", "2. Cierra puertas"),
                B("bullets", [
                    "Redes en privado, sin ciudad, empresa ni lista de amigos visible. Revisa también fotos en las que te etiquetan otros.",
                    "Nada de fotos de tu portal, tu calle, tu coche, tu matrícula o la vista desde tu casa. Desactiva la ubicación de la cámara.",
                    "Apps deportivas (Strava y similares): perfil privado y **zona de privacidad** alrededor de tu casa. Tus rutas de carrera dibujan dónde vives.",
                    "No publiques en tiempo real dónde estás: súbelo después, si acaso.",
                    "Que el nombre de tu Wi-Fi no lleve tu nombre ni tu piso.",
                ]),
                B("heading", "3. Pide que borren tus datos"),
                B("bullets", [
                    "Ejerce tu **derecho de supresión** (art. 17 del RGPD) ante webs, guías o buscadores de personas que publiquen tu dirección o teléfono. Si no te responden en un mes, reclama ante la **AEPD**.",
                    "Google tiene un formulario para pedir que retire resultados con datos personales como tu dirección o tu teléfono.",
                    "Pide a tu operadora que tu número no figure en las guías telefónicas.",
                ]),
                B("heading", "4. Separa identidades"),
                B("bullets", [
                    "Un correo y un número distintos para el voluntariado, la ciberseguridad y cualquier actividad pública.",
                    "Contraseñas únicas en un gestor y verificación en dos pasos en todo, empezando por el correo.",
                    "Nunca cuentes en redes ni en el barrio lo que haces.",
                ]),
                B("tip", "Repite la auditoría cada 6 meses. Y recuerda: con uniforme te identificas por un número (la TIP de vigilante o tu número de voluntario), no por tu nombre."),
            ]},
        ]}


    const intervencion = {
        id: "intervencion", title: "Intervenir: cuando no puedes esperar", icon: "hand.raised.fill", colorName: "red",
        intro: "La policía tarda minutos en llegar y hay situaciones en las que esos minutos lo deciden todo. Este módulo te prepara para intervenir cuando de verdad hace falta: cuándo sí, cómo hacerlo con el menor riesgo y cómo no acabar siendo tú el denunciado. La meta nunca es ganar una pelea: es que la agresión pare.",
        lessons: [
            {id: "int-1", title: "Cuándo sí intervenir (y cuándo no)", minutes: 6, blocks: [
                B("paragraph", "Intervenir físicamente está justificado cuando se cumplen **las tres** condiciones a la vez:"),
                B("steps", [
                    "**Una persona está sufriendo un daño grave ahora mismo** o va a sufrirlo en segundos: le están pegando en el suelo, la arrastran contra su voluntad, la están estrangulando.",
                    "**Tu intervención puede cambiar el resultado**: puedes hacer que pare, que la víctima escape o que el agresor se vaya.",
                    "**El riesgo es asumible**: no hay armas a la vista, no estás en clara inferioridad numérica y tienes por dónde salir.",
                ]),
                B("heading", "Cuándo no"),
                B("bullets", [
                    "**Para proteger cosas**: un móvil, una moto o un escaparate no valen ni un riesgo.",
                    "**Si la agresión ya ha terminado** y el agresor se va: atiende a la víctima y describe al agresor.",
                    "**Si hay un arma** y no hay una vida en peligro inmediato: distancia, barreras, 112 y testigos.",
                    "**Si estás solo frente a un grupo**: busca aliados antes de acercarte.",
                ]),
                B("tip", "Ese análisis tiene que durar dos segundos. Por eso se entrena en el Simulador hasta que sea automático."),
                B("warning", "Que la policía tarde no cambia la regla: el 112 se llama siempre, en cuanto puedas, aunque sea con el altavoz mientras actúas o pidiéndoselo a otra persona."),
            ]},
            {id: "int-2", title: "Lo que la ley te permite", minutes: 5, blocks: [
                B("paragraph", "La ley española no te obliga a mirar: te **permite** defender a otra persona igual que a ti mismo (art. 20.4 del Código Penal), con tres condiciones:"),
                B("bullets", [
                    "**Agresión real y actual** contra esa persona.",
                    "**Medio proporcionado**: lo mínimo necesario para que pare. Contra empujones, no puñetazos; contra puñetazos, no un objeto contundente.",
                    "**Sin provocación** por tu parte.",
                ]),
                B("paragraph", "Además, puedes **retener al agresor in fraganti** para entregarlo a la policía (art. 490 de la Ley de Enjuiciamiento Criminal), con la fuerza mínima y avisando inmediatamente."),
                B("danger", "En el momento en que el agresor deja de atacar, huye o queda en el suelo sin poder seguir, **todo lo que hagas a partir de ahí ya no es defensa**: es agresión. Un golpe de más convierte al héroe en acusado."),
            ]},
            {id: "int-3", title: "Intervenir en grupo", minutes: 4, blocks: [
                B("paragraph", "Un solo testigo que interviene es un objetivo. Tres personas que se acercan a la vez son una fuerza que casi siempre hace que el agresor pare o se vaya sin que nadie tenga que tocarle."),
                B("steps", [
                    "**Recluta en voz alta y señalando**: «¡Tú y tú, venid conmigo! ¡Tú, llama al 112!»",
                    "**Reparte papeles**: uno llama, otro se queda con la víctima, los demás se acercan contigo.",
                    "**Acercaos juntos**, de frente y sin rodear del todo al agresor: que vea que tiene una salida.",
                    "**Hablad alto**: «¡Para ya! ¡La policía está viniendo!» Muchas agresiones terminan aquí.",
                ]),
                B("tip", "La gente quiere ayudar, pero cada uno espera a que lo haga otro. En cuanto alguien da instrucciones concretas, los demás le siguen."),
            ]},
            {id: "int-4", title: "La escalera de intervención", minutes: 6, blocks: [
                B("paragraph", "Empieza siempre por el escalón más bajo que funcione y sube solo si el anterior no basta. Puedes bajar en cualquier momento."),
                B("steps", [
                    "**Presencia**: acércate de forma visible, en guardia natural (la valla), con aliados si es posible.",
                    "**Voz de mando**: órdenes cortas, alto y claro. «¡PARA! ¡DÉJALE! ¡ATRÁS!» Nada de insultos.",
                    "**Interponerte**: colócate entre el agresor y la víctima, manos arriba, y haz que la víctima se aleje o cúbrela si está en el suelo.",
                    "**Separar**: si siguen enganchados, apártalo desde atrás o desde un lado con la técnica del Dojo, sin golpear.",
                    "**Controlar**: si sigue atacando, sujeción o control en el suelo seguro hasta que se calme o llegue la policía.",
                    "**Defenderte**: los golpes solo si te atacan a ti o a la víctima y no hay otra forma de pararlo. Para crear un hueco, no para castigar.",
                ]),
                B("warning", "Fíjate en sus manos todo el tiempo. Si aparece un arma, el plan cambia: distancia, barreras (una silla, una mochila, un coche) y que se vaya."),
            ]},
            {id: "int-5", title: "Retener sin poner en riesgo una vida", minutes: 5, blocks: [
                B("paragraph", "Si decides retener a alguien hasta que llegue la policía, tu responsabilidad sobre su vida empieza en ese momento. Personas han muerto por retenciones mal hechas en la calle."),
                B("bullets", [
                    "**Nunca presiones el cuello ni la garganta**, ni con el brazo ni con la rodilla.",
                    "**Nunca pongas tu peso sobre su espalda o su pecho** si está boca abajo: provoca asfixia por posición en pocos minutos.",
                    "**Ponlo de lado** en cuanto deje de resistirse y vigila que respire.",
                    "**Habla con él**: «Tranquilo, no te voy a hacer daño, viene la policía». Baja la tensión de todos.",
                    "**Si se resiste mucho, suéltalo y déjale ir.** Ya tienes su descripción. Ninguna retención vale una vida, la suya o la tuya.",
                    "**Entrégalo en cuanto llegue la policía** y explica qué ha pasado.",
                ]),
                B("danger", "Si deja de hablar, se pone azul, vomita o deja de moverse: suelta de inmediato, ponlo de lado, comprueba si respira y empieza RCP si hace falta."),
            ]},
            {id: "int-6", title: "Después de intervenir", minutes: 4, blocks: [
                B("steps", [
                    "**Atiende a la víctima** y a ti mismo: primeros auxilios y, si alguien está herido, ambulancia.",
                    "**Quédate hasta que llegue la policía** y cuenta exactamente lo que ha pasado, sin adornar ni minimizar.",
                    "**Pide los datos de los testigos**: son tu mejor defensa si el agresor te denuncia.",
                    "**Si usaste la fuerza**, tienes derecho a no declarar sin un abogado. Úsalo si te detienen o te citan como investigado.",
                    "**Si te hiciste daño**, ve a urgencias y pide el parte de lesiones.",
                    "**No publiques nada** en redes, ni vídeos ni comentarios.",
                    "**Habla con alguien** en los días siguientes. Es normal temblar, no dormir bien o repasarlo mil veces.",
                ]),
                B("tip", "Escribe en la Bitácora lo que pasó esa misma noche: te servirá para declarar y para aprender."),
            ]},
        ]}

  return all();
})();

const SCENARIOS = (() => {
    const all = () => [
        {
            id: "tiron", title: "El tirón", icon: "handbag.fill",
            situation: "Son las 23:00. A 20 metros, un chico arranca el bolso a una señora mayor, que cae al suelo. Él sale corriendo hacia una calle oscura.",
            options: [
                {text: "Corro tras él para recuperar el bolso.", score: 0,
                               feedback: "La persecución te aleja de la víctima, te lleva a un terreno desconocido y puede acabar en un enfrentamiento con alguien que quizá lleva un arma o tiene compinches. Un bolso no vale ese riesgo."},
                {text: "Atiendo a la señora, llamo al 112 y doy la descripción y la dirección de huida.", score: 2,
                               feedback: "Perfecto. La señora puede tener una fractura de cadera (muy común en caídas de personas mayores). Tú eres su protector ahora, y tu descripción es lo que permitirá a la policía actuar."},
                {text: "Grabo con el móvil mientras huye.", score: 1,
                               feedback: "Puede aportar algo, pero la señora está en el suelo. Prioriza socorrerla y avisar; luego, si puedes, anota todo lo que recuerdes."},
            ],
            lesson: "Persona antes que objetos. La víctima es tu prioridad."},

        {
            id: "pelea-bar", title: "Pelea a la salida del bar", icon: "figure.2",
            situation: "Al pasar por una zona de bares ves a tres chicos pegando a otro que está en el suelo. Hay gente mirando y nadie hace nada.",
            options: [
                {text: "Me meto a separarlos usando lo que he aprendido en clase.", score: 0,
                               feedback: "Tres contra uno ya es grave; tres contra dos, con alcohol de por medio, puede acabar con dos personas en el hospital. Además, en el lío pueden confundirte con un agresor."},
                {text: "Llamo al 112 desde una distancia segura, señalo a alguien concreto para que busque a la seguridad del bar y grito «¡Policía en camino!».", score: 2,
                               feedback: "Muy bien. Llamar rompe el efecto espectador, implicar a alguien concreto multiplica la ayuda y gritar que viene la policía a menudo hace que los agresores huyan. Si no paran y has reunido aliados, acercaos juntos (Academia › Intervenir). Cuando se vayan, atiende al herido."},
                {text: "Me voy, no es mi problema.", score: 0,
                               feedback: "Hay una persona en peligro grave y puedes pedir ayuda sin riesgo. No hacerlo puede ser incluso un delito de omisión del deber de socorro."},
            ],
            lesson: "Romper el efecto espectador es un superpoder: alguien tiene que ser el primero en actuar con cabeza."},

        {
            id: "inconsciente", title: "Persona en el suelo", icon: "person.fill.questionmark",
            situation: "Volviendo a casa a la 1:00 ves a un hombre tumbado en la acera junto a un portal. No se mueve.",
            options: [
                {text: "Seguro que está borracho. Sigo mi camino.", score: 0,
                               feedback: "Puede ser una parada cardíaca, una hipoglucemia, un golpe en la cabeza o hipotermia. Incluso si está borracho, puede ahogarse con su vómito."},
                {text: "Miro alrededor para ver si es seguro, le hablo y le toco el hombro. Si no responde, llamo al 112 y compruebo si respira.", score: 2,
                               feedback: "Exacto: PAS. Proteger (¿es seguro?), Avisar, Socorrer. Si no respira con normalidad, RCP. Si respira, posición lateral de seguridad y vigilar."},
                {text: "Le levanto para sentarle en el portal.", score: 1,
                               feedback: "Tu intención es buena, pero mover a alguien inconsciente puede agravar una lesión de columna y no soluciona el problema. Primero valora y llama."},
            ],
            lesson: "Ante la duda, comprueba y llama. Puede ser la diferencia entre la vida y la muerte."},

        {
            id: "me-siguen", title: "Alguien te sigue", icon: "figure.walk.motion",
            situation: "Llevas varias calles notando que la misma persona camina detrás de ti. Has cambiado de acera y también lo ha hecho.",
            options: [
                {text: "Me giro y le encaro: «¿Qué quieres?»", score: 0,
                               feedback: "Confrontar en una calle vacía te expone. Si tiene malas intenciones, le das la iniciativa; si no las tiene, creas un conflicto que no existía."},
                {text: "Voy hacia una zona con gente o entro en un comercio abierto, llamo a alguien o al 112 y no voy directo a mi casa.", score: 2,
                               feedback: "Perfecto. Testigos, luz y ayuda. Nunca le enseñes dónde vives. Si sigue fuera, llama al 091/092."},
                {text: "Echo a correr hacia casa.", score: 1,
                               feedback: "Alejarte está bien, pero ir a tu casa le enseña dónde vives, y puedes quedar atrapado en el portal buscando las llaves. Mejor un lugar con gente."},
            ],
            lesson: "Lugares con gente y luz son tu mejor refugio. Tu casa no se revela."},

        {
            id: "coche", title: "Forzando un coche", icon: "car.fill",
            situation: "A las 3:00, desde tu ventana, ves a dos personas manipulando la puerta de un coche aparcado. Miran a los lados constantemente.",
            options: [
                {text: "Bajo a la calle para pillarles in fraganti y retenerles.", score: 0,
                               feedback: "La ley lo permitiría en teoría, pero son dos, de noche, y no sabes si llevan herramientas que pueden usarse como arma. Ningún coche vale ese riesgo."},
                {text: "Llamo al 091/092 desde casa, describo personas y dirección, y sigo observando sin exponerme.", score: 2,
                               feedback: "Lo ideal. Desde tu ventana eres un testigo seguro y valioso. Apunta la hora y cualquier detalle de su huida."},
                {text: "Grito por la ventana para que se vayan.", score: 1,
                               feedback: "Puede funcionar para que se marchen, pero revela tu posición y probablemente se vayan antes de que llegue la policía. Llama primero."},
            ],
            lesson: "La ventana de tu casa es la mejor torre de vigilancia que existe."},

        {
            id: "metro", title: "Acoso en el metro", icon: "tram.fill",
            situation: "En un vagón casi vacío, un hombre insiste en hablar con una chica que se nota incómoda. Ella se ha cambiado de asiento y él la ha seguido.",
            options: [
                {text: "Me acerco a él y le digo que la deje en paz o se las verá conmigo.", score: 0,
                               feedback: "Le retas delante de otros: le obligas a «no quedar mal» y puede escalar. Además, la conversación pasa a ser entre vosotros dos, y la chica sigue en medio."},
                {text: "Me acerco a ella como si la conociera: «¡Hola! ¿Qué tal? Hace mucho que no te veo», le doy conversación y, si hace falta, bajamos juntos o aviso al personal.", score: 2,
                               feedback: "Una técnica muy eficaz de intervención de testigos: distraer. Rompes la situación sin enfrentarte a nadie y le das a ella una salida. Si la cosa sigue, usa el interfono del vagón o avisa a seguridad."},
                {text: "No hago nada porque no ha pasado nada grave.", score: 0,
                               feedback: "Intervenir pronto, de forma suave, evita que las situaciones lleguen a ser graves."},
            ],
            lesson: "Las «5 D» de la intervención de testigos: Distraer, Delegar, Documentar, Dirigirse (después a la víctima) y, si es seguro, Directo."},

        {
            id: "navaja", title: "Atraco con navaja", icon: "exclamationmark.triangle.fill",
            situation: "Un hombre te corta el paso, te enseña una navaja y te pide el móvil y la cartera.",
            options: [
                {text: "Le desarmo con la técnica que aprendí.", score: 0,
                               feedback: "Hasta los instructores con décadas de experiencia saben que intentar desarmar a alguien con un cuchillo es extremadamente peligroso. Los cortes en un forcejeo son casi seguros."},
                {text: "Le doy lo que pide sin movimientos bruscos, me fijo en su descripción, y cuando se va llamo al 091 y bloqueo el móvil.", score: 2,
                               feedback: "Es exactamente lo que recomienda la policía. Los objetos se recuperan o se reponen. Tu vida no."},
                {text: "Salgo corriendo.", score: 1,
                               feedback: "Si hay una vía de escape clara y tienes distancia, huir puede ser válido. Pero si está cerca, un movimiento brusco puede provocar un ataque. Entregar lo que pide suele ser lo más seguro."},
            ],
            lesson: "Nada material vale tu vida. Entrega, observa, denuncia."},

        {
            id: "puente", title: "Persona en el puente", icon: "figure.stand",
            situation: "De noche ves a una persona sola al otro lado de la barandilla de un puente, mirando al agua. Parece llorar.",
            options: [
                {text: "Corro hacia ella y la agarro para tirar de ella hacia dentro.", score: 0,
                               feedback: "Un movimiento brusco puede asustarla y provocar la caída, o arrastrarte a ti también."},
                {text: "Llamo al 112 y, manteniendo distancia, le hablo con calma: me presento, le pregunto su nombre y la escucho sin juzgar.", score: 2,
                               feedback: "Muy bien. Hablar de forma tranquila y escuchar salva vidas. No hace falta tener las palabras perfectas: hace falta estar. Sigue hablando hasta que llegue la ayuda."},
                {text: "Le grito que no lo haga.", score: 1,
                               feedback: "La intención es buena, pero los gritos generan tensión. Acércate despacio, anunciando lo que haces, y habla en tono bajo."},
            ],
            lesson: "Existe el 024, línea de atención a la conducta suicida, gratuita y 24 h. Ante un peligro inminente, 112."},

        {
            id: "venganza", title: "«Darle una lección»", icon: "person.3.fill",
            situation: "Unos amigos te proponen ir a «darle una lección» a un tipo que, según dicen, trapichea con droga en el parque del barrio. Saben que entrenas.",
            options: [
                {text: "Me apunto. Alguien tiene que hacer algo.", score: 0,
                               feedback: "Eso es una agresión planificada en grupo: lesiones, quizá algo peor, y con agravantes. Y es posible que tengáis a la persona equivocada. Habéis pasado de héroes a delincuentes."},
                {text: "Me niego, intento convencerles de que no lo hagan y, si hay venta de droga, se puede comunicar a la policía local o a través de AlertCops.", score: 2,
                               feedback: "Correcto. Los cuerpos de seguridad investigan este tipo de situaciones. Tu valor está en no participar y en frenar a tus amigos."},
                {text: "No voy, pero no digo nada.", score: 1,
                               feedback: "No participar está bien, pero quizá puedas evitar que tus amigos se metan en un problema enorme."},
            ],
            lesson: "Un justiciero que castiga es solo otro agresor. Tu código te protege a ti también."},

        {
            id: "incendio", title: "Humo en el portal", icon: "flame.fill",
            situation: "Al volver a casa ves humo saliendo de la ventana de un primer piso de tu edificio. Oyes gritos.",
            options: [
                {text: "Subo a buscar a la gente.", score: 0,
                               feedback: "El humo mata antes que el fuego: un par de bocanadas pueden dejarte inconsciente. Sin equipo de respiración, entrar es convertirte en otra víctima."},
                {text: "Llamo al 112, aviso a los vecinos llamando a los telefonillos y gritando, y me quedo fuera para guiar a los bomberos.", score: 2,
                               feedback: "Perfecto. Los bomberos necesitarán saber qué piso es, si queda gente dentro y por dónde se accede. Tu información les ahorra minutos vitales."},
                {text: "Cojo un extintor y subo.", score: 1,
                               feedback: "Un extintor puede servir para un conato pequeño y si tienes una salida segura a tu espalda. Con humo saliendo por la ventana y gritos, ya no es un conato: llama y evacúa."},
            ],
            lesson: "En un incendio, tu trabajo es avisar, evacuar y orientar a los bomberos."},

        {
            id: "suelo-patadas", title: "Patadas en el suelo", icon: "figure.fall",
            situation: "Sales de un portal con un amigo. Un hombre está dando patadas en la cabeza a otro que está tirado en el suelo y ya no se defiende. No ves armas. La calle está vacía. Han llamado al 112 desde una ventana, pero la policía tardará.",
            options: [
                {text: "Grabo con el móvil para que haya pruebas y espero a la policía.", score: 0,
                               feedback: "Las patadas en la cabeza a alguien indefenso pueden matarle en segundos. Aquí esperar no es neutral: es dejar que pase."},
                {text: "Nos acercamos los dos gritando «¡PARA! ¡Policía en camino!». Si sigue, mi amigo me cubre mientras lo aparto por detrás y me pongo entre él y la víctima.", score: 2,
                               feedback: "Correcto. Daño grave ahora, algo que podéis cambiar y riesgo asumible: es el caso en el que hay que intervenir. Primero voz y presencia; si no basta, separar sin golpear y cubrir la cabeza de la víctima. Después, posición lateral y vigilar que respire."},
                {text: "Corro hacia él y le doy un puñetazo para que pare.", score: 1,
                               feedback: "Intervenir es lo correcto, pero empezar golpeando te pone en riesgo legal y físico: puede girarse contra ti o caer y golpearse la cabeza. Sube la escalera desde abajo: voz, interponerte, separar. El golpe, solo si te ataca a ti y no hay otra forma."},
            ],
            lesson: "Cuando hay daño grave ahora mismo y puedes pararlo con un riesgo asumible, se interviene. Siempre desde el escalón más bajo que funcione."},

        {
            id: "arrastran", title: "La arrastran hacia un coche", icon: "car.side.fill",
            situation: "Por la noche ves a un hombre que agarra del brazo a una chica que grita «¡Suéltame, no te conozco!» y la arrastra hacia una furgoneta con la puerta abierta.",
            options: [
                {text: "Apunto la matrícula, llamo al 112 y les sigo de lejos cuando se vayan.", score: 1,
                               feedback: "Apuntar la matrícula y llamar es imprescindible, pero si la meten en la furgoneta puede ser demasiado tarde. Y nunca persigas un vehículo."},
                {text: "Grito con toda la fuerza «¡SUÉLTALA! ¡Llamad al 112!», me acerco señalando a la gente para que vengan y me pongo entre ella y la furgoneta.", score: 2,
                               feedback: "Muy bien. Los segundos antes de que la suban al vehículo son los que importan: ruido, testigos y presencia física que corte el camino a la furgoneta. Fíjate en sus manos por si hay arma y, cuando la suelte, lleva a la chica hacia la luz y la gente. Apunta la matrícula."},
                {text: "Igual es su pareja y es una discusión. No me meto.", score: 0,
                               feedback: "«No te conozco» y alguien arrastrado hacia un vehículo es una señal de alarma clara. Aunque fuera su pareja, nadie puede llevarse a otra persona a la fuerza."},
            ],
            lesson: "Impedir que se lleven a alguien a la fuerza justifica intervenir: ruido, testigos y cortar el paso al vehículo."},

        {
            id: "cuchillo-tercero", title: "Cuchillo contra otro", icon: "exclamationmark.octagon.fill",
            situation: "En una plaza, un hombre muy alterado amenaza con un cuchillo a otro, que está acorralado contra una pared. Todavía no le ha herido. Hay varias personas mirando a distancia.",
            options: [
                {text: "Me lanzo a por la mano del cuchillo para desarmarle.", score: 0,
                               feedback: "Desarmar a alguien con un cuchillo es extremadamente peligroso incluso para expertos: en un forcejeo, los cortes son casi seguros, para ti o para la víctima."},
                {text: "Llamo al 112 diciendo «hay un cuchillo», recluto a la gente para hablarle todos a distancia, cojo una silla o una mochila como barrera y le doy al acorralado una vía para escapar.", score: 2,
                               feedback: "Es lo que de verdad funciona. Con un cuchillo, la distancia y las barreras son tu vida. Muchas voces le distraen, la barrera te protege y abrir una salida a la víctima suele ser más eficaz que enfrentarse. Si ataca de verdad y no hay otra opción, la barrera es tu escudo."},
                {text: "Me alejo y no hago nada, es demasiado peligroso.", score: 1,
                               feedback: "Protegerte es legítimo y nadie te obliga a arriesgar tu vida. Pero sí puedes llamar al 112 indicando que hay un arma, mantener la distancia y dirigir a la gente: eso también ayuda."},
            ],
            lesson: "Con un arma de por medio: distancia, barreras, muchas voces y una salida para la víctima. El cuerpo a cuerpo, solo si una vida depende de ello y no queda otra."},

        {
            id: "retencion", title: "Lo retienes y se resiste", icon: "hand.raised.slash.fill",
            situation: "Has separado a un agresor que pegaba a una mujer y lo tienes en el suelo con un control. Se revuelve con fuerza, te insulta y dice que te va a matar. La policía aún no ha llegado.",
            options: [
                {text: "Le pongo la rodilla en la espalda y aprieto hasta que se calme.", score: 0,
                               feedback: "El peso sobre la espalda o el cuello de alguien boca abajo puede matarle por asfixia en pocos minutos. Personas han muerto así en la calle. Además, eso ya no es defensa: puede ser un delito grave."},
                {text: "Mantengo el control de lado sin cargar peso, le hablo con calma y, si no puedo sujetarle sin hacerle daño, le suelto, me aparto y protejo a la mujer.", score: 2,
                               feedback: "Exacto. Tu objetivo era que dejara de pegarle, y eso ya lo has conseguido. Si retenerle exige hacerle daño, suéltale: tienes su descripción y la policía hará el resto."},
                {text: "Le doy un par de golpes para que deje de amenazarme.", score: 0,
                               feedback: "Golpear a alguien que ya está controlado en el suelo es agresión, aunque te amenace. Es lo que convierte al que ayudó en el denunciado."},
            ],
            lesson: "Retener nunca vale una vida. Sin peso en el pecho ni en el cuello, de lado en cuanto se calme, y si no puedes sin hacer daño, suelta."},

        {
            id: "huye", title: "El agresor huye", icon: "figure.run",
            situation: "Has gritado y te has interpuesto, y el hombre que estaba golpeando a un chaval sale corriendo. El chaval sangra por la nariz y está mareado.",
            options: [
                {text: "Le persigo para que no se escape.", score: 0,
                               feedback: "La agresión ya ha terminado: tu intervención ha funcionado. Perseguirle te aleja de la víctima, te lleva a un terreno que no conoces y convierte el siguiente encuentro en una pelea en la que la ley ya no te respalda igual."},
                {text: "Me quedo con el chaval, le siento, le tapo la nariz inclinándole hacia delante, vigilo si está desorientado y doy la descripción del agresor al 112.", score: 2,
                               feedback: "Perfecto. Has ganado: la agresión ha parado. Ahora toca primeros auxilios (si hay golpe en la cabeza y está mareado, que le vea un médico) y ser el mejor testigo posible."},
                {text: "Le grabo mientras huye y lo subo a redes para que lo identifiquen.", score: 1,
                               feedback: "La grabación puede servir a la policía, pero subirla a redes puede perjudicar la investigación y meterte en problemas. Entrégala a la policía y céntrate en el herido."},
            ],
            lesson: "Cuando el agresor huye, has ganado. Atiende a la víctima y sé un testigo excelente."},
    ]

  return all();
})();

const CODE_RULES = (() => {
    const all = () => [
        {number: 1, title: "Tu vida primero", text: "Un héroe herido no salva a nadie. Si la escena no es segura, no entras."},
        {number: 2, title: "El 112 siempre", text: "Antes de actuar o mientras actúas: con el altavoz o pidiéndoselo a otra persona. Aunque tarden, cada minuto que ganas cuenta."},
        {number: 3, title: "Intervén solo cuando hace falta", text: "Una persona en peligro grave ahora, algo que puedes cambiar y un riesgo asumible. Para todo lo demás, sé un testigo excelente."},
        {number: 4, title: "Nunca armas", text: "Ni porras, ni navajas, ni nudilleras. Escalan el conflicto y te convierten en delincuente."},
        {number: 5, title: "Nunca persigas", text: "Quien huye ya no es una amenaza inmediata. Tu persecución sí puede crear una."},
        {number: 6, title: "No eres la policía", text: "No identificas, no registras, no interrogas, no castigas. Respeta su trabajo y colabora."},
        {number: 7, title: "Proporcionalidad", text: "Solo la fuerza mínima, solo para protegerte o proteger a otro, y solo mientras dure la agresión."},
        {number: 8, title: "Ayudar antes que castigar", text: "El héroe real socorre, acompaña y previene. El castigo es cosa de los jueces."},
        {number: 9, title: "Nunca solo, siempre localizable", text: "Alguien de confianza sabe siempre dónde estás y cuándo vuelves."},
        {number: 10, title: "Sin ego, sin venganza, sin redes", text: "No buscas reconocimiento ni likes. No publicas caras ni incidentes."},
        {number: 11, title: "Cara descubierta", text: "La gente confía en quien puede ver. Si llevas uniforme, que sea el oficial de tu organización."},
        {number: 12, title: "Entrena siempre", text: "La preparación es un compromiso de por vida: cuerpo, técnica, ley y primeros auxilios."},
        {number: 13, title: "Dignidad para todos", text: "También para quien se ha equivocado. Tratar bien a todo el mundo es lo que te separa de los villanos."},
    ]

  return all();
})();

const GEAR = (() => {
    const all = () => [
        {name: "Móvil cargado + batería externa", icon: "iphone", status: "recomendado",
                 why: "Tu herramienta más poderosa: llamar al 112, compartir ubicación, AlertCops, linterna."},
        {name: "Linterna potente", icon: "flashlight.on.fill", status: "recomendado",
                 why: "Iluminar un portal, buscar algo caído, hacer señales. Mejor pequeña, con 300+ lúmenes."},
        {name: "Silbato", icon: "speaker.wave.3.fill", status: "recomendado",
                 why: "Se oye mucho más lejos que tu voz y no se cansa. Para pedir ayuda o alertar."},
        {name: "Botiquín de bolsillo", icon: "cross.case.fill", status: "recomendado",
                 why: "Guantes de nitrilo, gasas, venda de compresión, manta térmica, mascarilla de RCP y tiritas."},
        {name: "Chaleco o bandas reflectantes", icon: "figure.walk", status: "recomendado",
                 why: "Que los coches te vean de noche. El negro mate queda bien en el cine; en la carretera es peligroso."},
        {name: "Calzado cómodo y con agarre", icon: "shoeprints.fill", status: "recomendado",
                 why: "Caminar muchos kilómetros, correr si hace falta y no resbalar."},
        {name: "Ropa por capas", icon: "tshirt.fill", status: "recomendado",
                 why: "Por la noche la temperatura cae. Una capa extra también sirve para abrigar a alguien en shock."},
        {name: "Libreta y bolígrafo", icon: "pencil.and.list.clipboard", status: "recomendado",
                 why: "Para anotar descripciones, matrículas y horas cuando el móvil esté ocupado en una llamada."},
        {name: "Agua y algo de comer", icon: "waterbottle.fill", status: "recomendado",
                 why: "Para ti o para alguien con una bajada de azúcar."},
        {name: "DNI y tarjeta sanitaria", icon: "person.text.rectangle.fill", status: "recomendado",
                 why: "Obligatorio identificarte si un agente te lo pide, y útil si eres tú quien necesita ayuda."},
        {name: "Spray de defensa (pimienta)", icon: "aqi.medium", status: "condicionado",
                 why: "Se vende legalmente a mayores de edad en España si es un modelo autorizado, pero solo puede usarse en legítima defensa y de forma proporcional. Puede afectarte a ti con el viento y no frena a todo el mundo. No es necesario para este programa."},
        {name: "Cámara corporal", icon: "video.fill", status: "condicionado",
                 why: "Grabar para entregar a la policía puede ser útil, pero hay límites legales en cuanto a datos personales y difusión. Nunca publiques las imágenes."},
        {name: "Pasamontañas o máscara", icon: "theatermasks.fill", status: "condicionado",
                 why: "Ocultar tu cara mientras «vigilas» genera alarma, hace que la policía te pare y agrava cualquier problema. Para proteger tu identidad hay formas mejores: lee Academia › Ley y límites › Anonimato."},
        {name: "Esposas o bridas", icon: "link", status: "prohibido",
                 why: "Usarlas sobre otra persona fuera de los casos legales puede ser detención ilegal, y usarlas mal provoca lesiones. No son para ti."},
        {name: "Porra o defensa extensible", icon: "xmark.shield.fill", status: "prohibido",
                 why: "Prohibidas para particulares por el Reglamento de Armas."},
        {name: "Nudilleras / puño americano", icon: "hand.raised.slash.fill", status: "prohibido",
                 why: "Prohibidas para particulares por el Reglamento de Armas."},
        {name: "Navajas, cuchillos y armas blancas", icon: "scissors", status: "prohibido",
                 why: "Llevarlas para «defenderte» puede ser sancionado y convierte cualquier incidente en algo potencialmente mortal."},
        {name: "Táser o arma eléctrica", icon: "bolt.fill", status: "prohibido",
                 why: "Prohibidas para particulares en España."},
        {name: "Uniformes o placas que imiten a la policía", icon: "star.circle.fill", status: "prohibido",
                 why: "Puede constituir delito de usurpación de funciones o uso indebido de uniforme."},
    ]

  return all();
})();

const TIPS = [
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
        "Grábate en el Dojo: el vídeo no miente y es el mejor instructor que tienes en casa.",
        "En el Dojo, cada combinación termina igual: creando distancia para poder irte.",
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
    ];

const DOJO = (() => {
    const intro = "Tu dojo en casa: 7 cinturones, técnicas paso a paso y clases guiadas con un entrenador que te canta las combinaciones. Mezcla lo más útil del boxeo, el kickboxing, el judo y la defensa personal, con un objetivo claro: protegerte lo justo para poder escapar."

    const honesty = "Lo único que el Dojo no puede darte es un rival que se resiste. Por eso las técnicas de autodefensa tienen una variante opcional con alguien de confianza, siempre despacio y con control. Si algún día puedes apuntarte a un club, todo lo que aprendas aquí te servirá."

    const setup = [
        "Espacio despejado de al menos 2 × 2 m, lejos de esquinas de muebles y cristales.",
        "Colchoneta gruesa o un colchón viejo en el suelo para caídas y trabajo de suelo. Nunca caigas sobre suelo duro.",
        "Un espejo o el móvil para grabarte: es tu instructor para corregir la técnica.",
        "Opcional: comba, vendas de boxeo y un saco. Si no tienes saco, NO golpees paredes ni puertas: la sombra es suficiente.",
        "Agua, ropa cómoda y descalzo o con zapatillas planas.",
    ]

    const numbering = "Numeración de golpes (para diestros; si eres zurdo, intercambia izquierda y derecha): **1** jab · **2** directo · **3** crochet de izquierda · **4** crochet de derecha · **5** uppercut de izquierda · **6** uppercut de derecha."

    const safety = [
        "Calienta siempre. Las clases ya incluyen el calentamiento: no te lo saltes.",
        "Técnica lenta y limpia antes que rápida y fuerte. La velocidad llega sola.",
        "No bloquees los codos ni las rodillas al golpear al aire: extiende al 90 %.",
        "Con compañero: velocidad al 30 %, sin contacto en la cabeza y con una palabra para parar al instante.",
        "Dolor agudo en una articulación = paras. Cansancio muscular = sigues.",
    ]

  return { intro, honesty, setup, numbering, safety };
})();

const TECHNIQUES = (() => {
    const all = () => [

        {id: "guardia", name: "Guardia", kind: "postura",
                  summary: "La posición desde la que haces todo lo demás. Una buena guardia protege tu cabeza y te deja moverte en cualquier dirección.",
                  steps: [
                      "Pies separados al ancho de los hombros, el pie fuerte un paso atrás y en diagonal (como si estuvieras sobre las vías de un tren, no en la misma vía).",
                      "Rodillas ligeramente flexionadas, peso repartido 50/50, talón trasero un poco levantado.",
                      "Manos a la altura de las mejillas, codos cerrados protegiendo las costillas.",
                      "Barbilla baja, como si sujetaras una pelota de tenis contra el pecho. Mira al frente a través de las cejas.",
                  ],
                  errors: ["Bajar las manos al cansarte.", "Barbilla levantada.", "Pies en la misma línea: pierdes el equilibrio con un empujón."],
                  drill: "3 minutos frente al espejo: mantén la guardia y pide a alguien (o a ti mismo cada 30 s) que compruebe manos, barbilla y pies.",
                  partner: "Tu compañero te empuja suavemente desde distintos ángulos: no deberías perder la base."},
        {id: "desplazamientos", name: "Desplazamientos", kind: "postura",
                  summary: "Moverse sin perder la guardia ni cruzar los pies. Es lo que te permite crear distancia y escapar.",
                  steps: [
                      "Hacia delante: avanza primero el pie delantero, luego arrastra el trasero la misma distancia.",
                      "Hacia atrás: primero el pie trasero, luego el delantero.",
                      "A los lados: se mueve primero el pie del lado hacia el que vas.",
                      "Pasos cortos, sin saltar, manteniendo siempre la misma distancia entre pies.",
                  ],
                  errors: ["Cruzar los pies.", "Saltar en lugar de deslizar.", "Bajar la guardia al moverse."],
                  drill: "Dibuja una cruz en el suelo con cinta. Muévete por ella en todas direcciones durante 2 minutos sin pisar la cinta con los dos pies a la vez.",
                  partner: null},
        {id: "jab", name: "1 · Jab", kind: "golpe",
                  summary: "El golpe recto con la mano adelantada. Rápido, para medir distancia y crear espacio.",
                  steps: [
                      "Desde la guardia, extiende el brazo adelantado en línea recta.",
                      "Gira el puño al final para que la palma mire al suelo.",
                      "El hombro sube y protege la barbilla; la otra mano se queda en la cara.",
                      "Vuelve por el mismo camino a la guardia, igual de rápido que saliste.",
                  ],
                  errors: ["Abrir el codo hacia fuera (golpe en arco).", "Dejar el brazo extendido.", "Bajar la mano trasera."],
                  drill: "20 jabs lentos mirándote al espejo, luego 20 a velocidad media. Exhala por la boca en cada golpe.",
                  partner: "Tu compañero sostiene una mano abierta como diana. Golpea la palma con control."},
        {id: "directo", name: "2 · Directo", kind: "golpe",
                  summary: "El golpe recto con la mano trasera. Más potente porque usa la rotación de la cadera.",
                  steps: [
                      "Gira el pie trasero como si aplastaras una colilla.",
                      "La cadera y el hombro rotan hacia delante y el puño sale recto.",
                      "Gira el puño, palma abajo, al final del golpe.",
                      "La mano adelantada protege la cara. Vuelve a la guardia.",
                  ],
                  errors: ["Golpear solo con el brazo, sin girar cadera.", "Inclinarse demasiado hacia delante.", "Levantar la barbilla."],
                  drill: "Alterna 1-2 lento frente al espejo, 3 series de 20. Comprueba que tu pie trasero gira en cada directo.",
                  partner: null},
        {id: "caida-atras", name: "Caída hacia atrás", kind: "caida",
                  summary: "Saber caer protege tu cabeza, que es lo que más se lesiona en una caída o un empujón.",
                  steps: [
                      "Siempre sobre colchoneta o colchón. Empieza sentado.",
                      "Barbilla pegada al pecho todo el tiempo.",
                      "Rueda hacia atrás sobre la espalda redondeada.",
                      "Golpea el suelo con ambos brazos estirados a 45° del cuerpo, palmas abajo, para repartir el impacto.",
                      "Progresión: sentado → en cuclillas → de pie (solo cuando las anteriores sean perfectas).",
                  ],
                  errors: ["Soltar la barbilla (la cabeza golpea el suelo).", "Poner las manos detrás para frenar (muñecas rotas).", "Espalda recta como una tabla."],
                  drill: "3 series de 8 caídas desde sentado. Pasa a cuclillas solo cuando ninguna repetición te haga mover la cabeza hacia atrás.",
                  partner: null},
        {id: "puente", name: "Puente (upa)", kind: "suelo",
                  summary: "Movimiento básico para quitarte de encima a alguien que está sentado sobre ti.",
                  steps: [
                      "Boca arriba, rodillas dobladas y pies cerca del culo.",
                      "Empuja con los pies y eleva la cadera explosivamente hacia arriba y hacia un hombro.",
                      "Gira sobre ese hombro mirando hacia el lado.",
                      "Vuelve y repite hacia el otro lado.",
                  ],
                  errors: ["Empujar solo hacia arriba, sin dirección.", "Pies lejos del cuerpo (no hay fuerza)."],
                  drill: "3 series de 10 puentes alternando lados.",
                  partner: "Tu compañero se sienta sobre tu abdomen sin apretar. Haz el puente despacio hacia el lado donde tiene un brazo atrapado."},
        {id: "gamba", name: "Escape de cadera (gamba)", kind: "suelo",
                  summary: "El movimiento más importante en el suelo: crear espacio para levantarte.",
                  steps: [
                      "Boca arriba, de lado, rodillas dobladas.",
                      "Apoya el pie de arriba en el suelo y empuja para desplazar la cadera hacia atrás.",
                      "Las manos empujan hacia delante, como si apartaras algo.",
                      "Acabas de lado y en forma de «C». Repite hacia el otro lado avanzando por la colchoneta.",
                  ],
                  errors: ["Mover los hombros en lugar de la cadera.", "Quedarse plano boca arriba."],
                  drill: "Recorre la colchoneta de punta a punta con gambas, 4 veces.",
                  partner: null},
        {id: "sprawl", name: "Sprawl", kind: "suelo",
                  summary: "Defensa contra alguien que se lanza a tus piernas para derribarte.",
                  steps: [
                      "Desde la guardia, lanza las piernas hacia atrás y abiertas.",
                      "Deja caer la cadera hacia el suelo, pesada.",
                      "Las manos bajan a bloquear hombros o cabeza del que entra.",
                      "Vuelve a ponerte de pie en guardia lo antes posible.",
                  ],
                  errors: ["Quedarse con la cadera alta.", "Tardar en volver a la guardia."],
                  drill: "3 series de 10 sprawls, volviendo cada vez a una guardia perfecta.",
                  partner: null},
        {id: "levantada", name: "Levantada técnica", kind: "suelo",
                  summary: "Cómo levantarte del suelo sin quedar expuesto y alejándote de la amenaza.",
                  steps: [
                      "Sentado, una mano apoyada detrás y la otra delante protegiendo la cara.",
                      "Pie contrario a la mano de apoyo plantado en el suelo.",
                      "Levanta la cadera y pasa la pierna libre por debajo, hacia atrás.",
                      "Te levantas ya en guardia y un paso más lejos.",
                  ],
                  errors: ["Levantarse hacia delante (hacia el agresor).", "Bajar la mano que protege la cara."],
                  drill: "10 levantadas por lado. Termina cada una en guardia y retrocede dos pasos.",
                  partner: null},

        {id: "crochet", name: "3 y 4 · Crochet", kind: "golpe",
                  summary: "Golpe curvo a corta distancia. El 3 es con la mano adelantada y el 4 con la trasera.",
                  steps: [
                      "El codo se eleva a la altura del puño, el brazo forma un ángulo de unos 90°.",
                      "La potencia sale del giro de la cadera y del pie del mismo lado (gira el pie como en el directo).",
                      "El puño viaja en horizontal; la otra mano protege la cara.",
                      "El golpe es corto: no abras el brazo como un gancho de película.",
                  ],
                  errors: ["Brazo demasiado abierto.", "Mover solo el brazo sin girar la cadera.", "Bajar la otra mano."],
                  drill: "Frente al espejo: 1-2-3 lento, 3 series de 10. Luego 3-4 sueltos.",
                  partner: null},
        {id: "uppercut", name: "5 y 6 · Uppercut", kind: "golpe",
                  summary: "Golpe ascendente a corta distancia.",
                  steps: [
                      "Baja ligeramente el hombro y la rodilla del lado que golpea.",
                      "Empuja con las piernas y gira la cadera; el puño sube por dentro, palma hacia ti.",
                      "No bajes la mano antes de golpear: se nota y te deja la cara descubierta.",
                      "Vuelve a la guardia.",
                  ],
                  errors: ["Cargar el brazo hacia abajo antes de golpear.", "Golpear solo con el brazo."],
                  drill: "3 series de 10 alternando 5-6, a velocidad media.",
                  partner: null},
        {id: "esquiva", name: "Esquiva lateral", kind: "defensa",
                  summary: "Mover la cabeza fuera de la línea de un golpe recto.",
                  steps: [
                      "Gira ligeramente el tronco y flexiona la rodilla para desplazar la cabeza unos 15 cm a un lado.",
                      "La cabeza nunca sale de la línea de tus pies (no te inclines de más).",
                      "Las manos se mantienen en guardia.",
                      "Vuelve al centro o contraataca.",
                  ],
                  errors: ["Inclinarse en exceso perdiendo el equilibrio.", "Cerrar los ojos.", "Bajar las manos."],
                  drill: "Cuelga una pelota o un calcetín con una cuerda a la altura de tu cabeza, empújala y esquívala.",
                  partner: "Tu compañero lanza jabs muy lentos y sin fuerza a tu hombro; esquiva y vuelve."},
        {id: "parada", name: "Bloqueo y parada", kind: "defensa",
                  summary: "Desviar o absorber un golpe con las manos y los antebrazos.",
                  steps: [
                      "Parada: con la palma, desvía el golpe recto un poco hacia un lado. Movimiento corto, sin ir a buscar el golpe.",
                      "Bloqueo alto: lleva el guante o la mano a la sien y el codo cerrado. Absorbes el golpe con el antebrazo.",
                      "Nunca cierres los ojos.",
                      "Vuelve a la guardia inmediatamente.",
                  ],
                  errors: ["Movimientos amplios que te abren.", "Ir a buscar el golpe."],
                  drill: "Sombra de 2 minutos imaginando golpes rectos: parada y contraataque con 2.",
                  partner: "Tu compañero lanza 1 lento a tus manos; tú practicas la parada. 30 % de velocidad."},
        {id: "caida-lateral", name: "Caída lateral", kind: "caida",
                  summary: "Caer de lado repartiendo el impacto.",
                  steps: [
                      "Sobre colchoneta. Desde cuclillas, extiende una pierna cruzándola por delante de la otra.",
                      "Cae de lado sobre el costado de esa pierna.",
                      "Barbilla al pecho. Golpea el suelo con el brazo del mismo lado, a 45°, palma abajo.",
                      "Alterna lados.",
                  ],
                  errors: ["Apoyar el codo o la mano para frenar.", "Soltar la cabeza."],
                  drill: "3 series de 6 por lado.",
                  partner: null},

        {id: "teep", name: "Patada frontal (teep)", kind: "patada",
                  summary: "Una patada para empujar y crear distancia. Muy útil para alejar a alguien.",
                  steps: [
                      "Levanta la rodilla al frente, a la altura de la cadera.",
                      "Empuja con la planta del pie hacia delante, como si cerraras una puerta de una patada.",
                      "Echa la cadera hacia delante al final; las manos siguen en guardia.",
                      "Recoge la rodilla y vuelve a apoyar el pie en guardia.",
                  ],
                  errors: ["Golpear con la punta del pie.", "Echarse hacia atrás y perder el equilibrio.", "Dejar caer la pierna sin recogerla."],
                  drill: "10 patadas lentas por pierna manteniendo 2 s la rodilla arriba. Después 10 a velocidad media.",
                  partner: "Tu compañero sostiene un cojín grande contra el abdomen: empuja con control, no golpees."},
        {id: "baja", name: "Patada circular baja", kind: "patada",
                  summary: "Patada al muslo con la tibia, rápida y difícil de ver.",
                  steps: [
                      "Da un pequeño paso en diagonal con el pie adelantado.",
                      "Gira sobre la punta de ese pie y rota la cadera.",
                      "La pierna trasera viaja en arco y golpea con la tibia (no con el pie), a la altura del muslo.",
                      "La mano del mismo lado baja por detrás para equilibrar; la otra protege la cara. Vuelve a guardia.",
                  ],
                  errors: ["No girar el pie de apoyo (rodilla en riesgo).", "Golpear con el empeine.", "Bajar ambas manos."],
                  drill: "3 series de 10 por pierna al aire, lentas. Si tienes saco, golpea suave.",
                  partner: null},
        {id: "rodilla", name: "Rodillazo", kind: "patada",
                  summary: "Golpe a muy corta distancia, cuando alguien está encima de ti.",
                  steps: [
                      "Desde la guardia, eleva la rodilla trasera hacia delante y hacia arriba.",
                      "Echa la cadera hacia delante y apóyate en la punta del pie de apoyo.",
                      "Las manos protegen la cara o imaginan sujetar al otro por los hombros.",
                      "Recoge y vuelve a la guardia.",
                  ],
                  errors: ["Inclinarse hacia atrás.", "Subir la rodilla sin mover la cadera."],
                  drill: "3 series de 10 por pierna.",
                  partner: null},
        {id: "chequeo", name: "Chequeo de patada", kind: "defensa",
                  summary: "Defensa contra la patada baja: levantar la pierna para recibirla con la tibia.",
                  steps: [
                      "Eleva la rodilla del lado que recibe, girándola ligeramente hacia fuera.",
                      "La tibia queda vertical, frente a la patada.",
                      "Mantén el equilibrio sobre la otra pierna con las manos en guardia.",
                      "Vuelve a apoyar en guardia.",
                  ],
                  errors: ["Bajar la guardia al levantar la pierna.", "Dejar la pierna rígida y recta."],
                  drill: "Sombra: imagina patadas bajas y chequea 10 por lado.",
                  partner: null},

        {id: "rodar", name: "Rodar el golpe", kind: "defensa",
                  summary: "Pasar por debajo de un golpe curvo moviendo la cabeza en forma de «U».",
                  steps: [
                      "Flexiona las rodillas (no la cintura) para bajar la cabeza.",
                      "Dibuja una «U» con la cabeza, de un lado a otro, por debajo del golpe.",
                      "Las manos siguen en guardia y la mirada al frente.",
                      "Sube del otro lado listo para contraatacar.",
                  ],
                  errors: ["Doblarse por la cintura mirando al suelo.", "Bajar las manos."],
                  drill: "Tensa una cuerda a la altura de tu barbilla y rueda por debajo avanzando de un extremo a otro.",
                  partner: null},
        {id: "cubrirse", name: "Cubrirse", kind: "defensa",
                  summary: "Cuando llueven golpes y no puedes salir: proteger cabeza y cuerpo mientras buscas la salida.",
                  steps: [
                      "Antebrazos pegados a los lados de la cabeza, codos juntos delante de la cara.",
                      "Barbilla al pecho, ligeramente encorvado.",
                      "Pequeños pasos hacia atrás o en diagonal, buscando espacio.",
                      "En cuanto haya hueco: sal y crea distancia.",
                  ],
                  errors: ["Quedarse quieto.", "Darse la vuelta (expones la nuca)."],
                  drill: "Asaltos de sombra en los que el entrenador grita «¡Cúbrete!»: cúbrete 3 s y sal en diagonal.",
                  partner: null},
        {id: "pivote", name: "Pivote", kind: "postura",
                  summary: "Girar sobre el pie adelantado para salir de la línea de ataque.",
                  steps: [
                      "Apoya el peso en la punta del pie adelantado.",
                      "Gira el pie trasero en arco, unos 90°.",
                      "Terminas en guardia, mirando al mismo punto pero desde un ángulo distinto.",
                  ],
                  errors: ["Perder la guardia al girar.", "Girar sobre el talón."],
                  drill: "En la cruz del suelo: 1-2, pivote, 1-2, pivote. 2 minutos.",
                  partner: null},
        {id: "rodada", name: "Rodada hacia delante", kind: "caida",
                  summary: "Convertir una caída hacia delante en un rodamiento para levantarte.",
                  steps: [
                      "Sobre colchoneta. Empieza de rodillas.",
                      "Apoya la mano adelantada y mira hacia la axila contraria; la cabeza NO toca el suelo.",
                      "Rueda en diagonal por el hombro, la espalda y la cadera contraria.",
                      "Termina sentado o de pie en guardia.",
                  ],
                  errors: ["Rodar sobre la cabeza o la columna.", "Rodar recto como una voltereta de gimnasia."],
                  drill: "3 series de 4 por lado desde rodillas. Pasa a de pie solo cuando sean suaves y silenciosas.",
                  partner: null},

        {id: "valla", name: "La valla", kind: "autodefensa",
                  summary: "Postura para mantener la distancia mientras hablas. Parece pasiva, pero te protege.",
                  steps: [
                      "Manos abiertas a la altura del pecho, palmas hacia delante, como diciendo «tranquilo».",
                      "Pie fuerte ligeramente atrás, rodillas flexionadas: es tu guardia disimulada.",
                      "Si la otra persona se acerca, tus manos marcan la distancia sin empujar.",
                      "Habla con calma y busca la salida con la vista.",
                  ],
                  errors: ["Cruzar los brazos o meter las manos en los bolsillos.", "Señalar con el dedo (es provocador)."],
                  drill: "Frente al espejo: adopta la valla mientras dices frases de desescalada en voz alta.",
                  partner: "Tu compañero se acerca despacio hablando: mantén la distancia con la valla y retrocede en diagonal."},
        {id: "muneca", name: "Liberarse de un agarre de muñeca", kind: "autodefensa",
                  summary: "Salir de un agarre usando el punto débil: el hueco entre el pulgar y los dedos.",
                  steps: [
                      "Abre la mano y extiende los dedos (el antebrazo se hace más ancho).",
                      "Gira la muñeca hacia el pulgar de quien te agarra.",
                      "Tira con fuerza en esa dirección, ayudándote con el cuerpo.",
                      "En cuanto te sueltes: guardia y distancia.",
                  ],
                  errors: ["Tirar hacia atrás en línea recta (contra la fuerza de su mano).", "Quedarse cerca después de soltarse."],
                  drill: "Sujeta tu propia muñeca con la otra mano y practica el giro hacia el pulgar, 10 por lado.",
                  partner: "Tu compañero te agarra la muñeca sin apretar fuerte; libérate despacio, 10 por lado y en distintos ángulos."},
        {id: "ropa", name: "Liberarse de un agarre de ropa", kind: "autodefensa",
                  summary: "Alguien te agarra de la camiseta o la chaqueta a la altura del pecho.",
                  steps: [
                      "Protege la cara con la mano libre.",
                      "Atrapa su mano contra tu pecho con tu otra mano.",
                      "Gira el cuerpo y retrocede en diagonal hacia el lado de su pulgar, rompiendo el agarre.",
                      "Crea distancia, guardia o valla, y sal.",
                  ],
                  errors: ["Intentar abrirle los dedos uno a uno.", "Quedarse quieto tirando hacia atrás."],
                  drill: "Visualiza el agarre y repite el movimiento completo 10 veces por lado frente al espejo.",
                  partner: "Tu compañero te agarra la camiseta sin tirar; ejecuta el movimiento despacio, 10 por lado."},
        {id: "abrazo", name: "Escapar de un abrazo por detrás", kind: "autodefensa",
                  summary: "Alguien te rodea desde atrás. Lo primero es que no te levante ni te tire.",
                  steps: [
                      "Baja tu centro de gravedad: rodillas flexionadas y piernas abiertas.",
                      "Si tus brazos están libres, protégete la cabeza; si están atrapados, sujeta sus antebrazos para que no suba.",
                      "Desplaza la cadera a un lado para crear espacio.",
                      "Gira hacia fuera rompiendo el agarre, encara en guardia y aléjate.",
                  ],
                  errors: ["Quedarse erguido (es fácil levantarte).", "Hacer fuerza con los brazos en lugar de con la base."],
                  drill: "Practica solo la parte de bajar el centro de gravedad y girar: 10 veces por lado.",
                  partner: "Tu compañero te abraza por detrás sin apretar ni levantar. Practica despacio, 5 por lado. Nunca levantes a tu compañero."},
        {id: "suelo-defensa", name: "Defenderse en el suelo y levantarse", kind: "autodefensa",
                  summary: "Si caes y la otra persona sigue de pie, tu prioridad es protegerte y levantarte.",
                  steps: [
                      "Ponte de lado, apoyado en un codo, con una pierna flexionada en el suelo.",
                      "La pierna de arriba queda entre tú y la otra persona, lista para empujar con el talón.",
                      "Gira sobre la cadera para mantener siempre los pies hacia ella.",
                      "Cuando haya distancia: levantada técnica, guardia y sal.",
                  ],
                  errors: ["Ponerse boca abajo o de espaldas.", "Intentar levantarse de frente cuando está cerca."],
                  drill: "Desde el suelo, gira sobre la cadera siguiendo un objeto que mueves a tu alrededor. Termina con levantada técnica. 2 minutos.",
                  partner: "Tu compañero camina despacio a tu alrededor; gira para mantener los pies hacia él y levántate cuando se aleje."},

        {id: "separar", name: "Separar a un agresor", kind: "autodefensa",
                  summary: "Cuando alguien sigue golpeando a otra persona y la voz no basta: apartarlo sin golpearlo.",
                  steps: [
                      "Acércate por detrás o en diagonal, nunca de frente a sus puños.",
                      "Pasa los brazos por debajo de sus axilas o rodea su cintura, pegando tu pecho a su espalda.",
                      "Baja tu centro de gravedad y tira de él hacia atrás y hacia un lado, alejándolo de la víctima varios pasos.",
                      "Háblale al oído con calma: «Ya está, se acabó, tranquilo».",
                      "En cuanto haya distancia, suelta, ponte en guardia natural entre los dos y dirige a la víctima a un lugar seguro.",
                  ],
                  errors: ["Meterse de frente entre dos que se pegan (recibes de los dos).", "Agarrar del cuello.", "Seguir sujetando cuando ya ha parado."],
                  drill: "Practica el movimiento con una mochila llena o un saco de ropa: agarrar, bajar el centro de gravedad y arrastrar 3 pasos atrás. 10 repeticiones.",
                  partner: "Tu compañero simula golpear un cojín en el suelo; acércate por detrás, sepáralo y llévatelo 3 pasos atrás. Despacio, sin tirones bruscos."},
        {id: "escudo", name: "Cubrir a una víctima en el suelo", kind: "autodefensa",
                  summary: "Si alguien está recibiendo patadas en el suelo, cada segundo cuenta: proteger su cabeza es lo primero.",
                  steps: [
                      "Entra por el lado de la víctima contrario al agresor.",
                      "Interpón tu cuerpo, en guardia y en cuclillas o de rodillas, entre el agresor y la cabeza de la víctima.",
                      "Protege tu cabeza con los antebrazos (cubrirse) y grita órdenes: «¡PARA! ¡YA ESTÁ!»",
                      "Cuando el agresor se aleje, ayuda a la víctima a ponerse de lado o a levantarse y sácala de ahí.",
                  ],
                  errors: ["Darle la espalda al agresor.", "Quedarse de pie delante, donde llegan las patadas a tu cabeza."],
                  drill: "Desde de pie, baja a la posición de escudo en menos de 2 segundos y vuelve a subir en guardia. 10 repeticiones.",
                  partner: "Tu compañero, tumbado en la colchoneta, hace de víctima; entra, cubre su cabeza y simula ayudarle a levantarse."},
        {id: "control-suelo", name: "Control en el suelo seguro", kind: "autodefensa",
                  summary: "Mantener en el suelo a alguien que sigue intentando agredir, hasta que se calme o llegue la policía, sin poner en riesgo su vida.",
                  steps: [
                      "Colócate de lado respecto a él, nunca sentado sobre su espalda ni sobre su pecho.",
                      "Controla su brazo más cercano contra tu cuerpo y apoya tu cadera junto a la suya, con tus piernas abiertas para tener base.",
                      "Tu peso va hacia el suelo a su lado, no encima de su tórax.",
                      "Habla con él y vigila su respiración todo el tiempo.",
                      "En cuanto deje de resistirse, ponlo de lado. Si sigue forcejeando con fuerza, suéltalo y crea distancia.",
                  ],
                  errors: ["Rodilla en el cuello o en la espalda.", "Sentarse sobre su espalda.", "Prolongar el control cuando ya no ataca."],
                  drill: "Sin compañero, practica la posición con un saco o una almohada grande: base amplia, peso hacia el suelo y no hacia el objeto.",
                  partner: "Tu compañero, boca arriba en la colchoneta, se resiste al 20 %. Mantén el control 30 segundos sin cargar peso en su pecho. Cambiad de papel."},
    ]

  return all();
})();

const BELTS = (() => {
    const all = () => [blanco, amarillo, naranja, verde, azul, marron, negro]

    const warmup = {title: "Calentamiento", kind: "calentamiento", seconds: 180, repeats: 1, rest: 0,
                                          cue: "Comba o saltos suaves, círculos de cuello, hombros, cadera, rodillas y tobillos. Termina con 10 sentadillas.",
                                          calls: [], pace: 0}
    const cooldown = {title: "Respiración", kind: "calma", seconds: 120, repeats: 1, rest: 0,
                                            cue: "Respiración cuadrada: 4 s inspirar, 4 retener, 4 soltar, 4 retener. Estira lo que notes cargado.",
                                            calls: [], pace: 0}

    const blanco = {
        id: 0, name: "Blanco", colorHex: "F2F2F2", theme: "Fundamentos",
        goal: "Guardia, desplazamientos, los dos golpes rectos, caer hacia atrás y moverte en el suelo.",
        minClasses: 8,
        techniques: ["guardia", "desplazamientos", "jab", "directo", "caida-atras", "puente", "gamba", "sprawl", "levantada"],
        exam: [
            "Mantengo la guardia 3 minutos seguidos sin bajar las manos ni levantar la barbilla.",
            "Me desplazo en las 4 direcciones sin cruzar los pies.",
            "Mi jab y mi directo salen rectos y vuelven a la guardia (comprobado en vídeo).",
            "Giro el pie trasero en cada directo.",
            "Hago 10 caídas hacia atrás desde cuclillas sin que la cabeza toque el suelo.",
            "Recorro la colchoneta con gambas y termino con una levantada técnica en guardia.",
        ],
        rounds: [
            warmup,
            {title: "Guardia y pies", kind: "tecnica", seconds: 120, repeats: 2, rest: 30,
                      cue: "Guardia frente al espejo. Muévete adelante, atrás y a los lados sin cruzar los pies.",
                      calls: ["Adelante", "Atrás", "Izquierda", "Derecha", "Guardia"], pace: 4},
            {title: "Jab y directo lentos", kind: "tecnica", seconds: 120, repeats: 2, rest: 30,
                      cue: "Golpes lentos, perfectos. Vuelve siempre a la guardia. Exhala en cada golpe.",
                      calls: ["1", "2", "1-2"], pace: 4},
            {title: "Sombra", kind: "sombra", seconds: 120, repeats: 3, rest: 60,
                      cue: "Escucha y lanza la combinación. Entre combinaciones, muévete en guardia.",
                      calls: ["1", "1-2", "1-1", "1-1-2", "2", "1-2, paso atrás", "Paso atrás", "1, paso al lado"], pace: 4},
            {title: "Suelo: puente y gamba", kind: "suelo", seconds: 120, repeats: 1, rest: 30,
                      cue: "Alterna 5 puentes y 2 gambas por lado. Acaba con levantada técnica.",
                      calls: [], pace: 0},
            {title: "Sprawls", kind: "acondicionamiento", seconds: 60, repeats: 2, rest: 30,
                      cue: "Sprawl y vuelve a una guardia perfecta. Calidad antes que cantidad.",
                      calls: [], pace: 0},
            {title: "Caídas hacia atrás", kind: "tecnica", seconds: 120, repeats: 1, rest: 0,
                      cue: "Sobre colchoneta. Desde sentado o cuclillas. Barbilla al pecho, golpe de brazos.",
                      calls: [], pace: 0},
            cooldown,
        ]}

    const amarillo = {
        id: 1, name: "Amarillo", colorHex: "FFD60A", theme: "Golpeo y defensa básica",
        goal: "Completar los 6 golpes de puño, esquivar y parar golpes rectos, y caer de lado.",
        minClasses: 10,
        techniques: ["crochet", "uppercut", "esquiva", "parada", "caida-lateral"],
        exam: [
            "Lanzo 1-2-3 y 1-2-3-2 sin perder la guardia (comprobado en vídeo).",
            "Mis crochets son cortos y giro la cadera.",
            "Esquivo 10 veces la pelota colgada sin perder el equilibrio.",
            "Hago la parada y contraataco con 2 de forma fluida.",
            "Hago 6 caídas laterales por lado sin apoyar la mano ni el codo.",
            "Aguanto 3 asaltos de 2 minutos de sombra a ritmo constante.",
        ],
        rounds: [
            warmup,
            {title: "Técnica: crochet y uppercut", kind: "tecnica", seconds: 120, repeats: 2, rest: 30,
                      cue: "Lento frente al espejo. Codo a la altura del puño en el crochet; uppercut sin cargar el brazo.",
                      calls: ["3", "4", "5", "6", "1-2-3"], pace: 4},
            {title: "Esquiva y parada", kind: "tecnica", seconds: 120, repeats: 2, rest: 30,
                      cue: "Imagina golpes rectos. Esquiva o para, y contraataca.",
                      calls: ["Esquiva izquierda", "Esquiva derecha", "Parada", "Esquiva y 2", "Parada y 1-2"], pace: 3},
            {title: "Sombra", kind: "sombra", seconds: 150, repeats: 3, rest: 60,
                      cue: "Escucha y lanza. Defiende y contraataca. Pies vivos.",
                      calls: ["1-2", "1-2-3", "1-2-3-2", "3-2", "1-6-3-2", "5-6", "Esquiva, 2-3", "Parada, 1-2", "1-2, paso atrás", "2-3-2"], pace: 3},
            {title: "Caídas laterales", kind: "tecnica", seconds: 120, repeats: 1, rest: 30,
                      cue: "Sobre colchoneta, alternando lados. Barbilla al pecho.",
                      calls: [], pace: 0},
            {title: "Suelo y levantada", kind: "suelo", seconds: 90, repeats: 2, rest: 30,
                      cue: "Gambas, puente y levantada técnica. Termina siempre en guardia.",
                      calls: [], pace: 0},
            cooldown,
        ]}

    const naranja = {
        id: 2, name: "Naranja", colorHex: "FF8A00", theme: "Piernas",
        goal: "Patada frontal para crear distancia, patada baja, rodillazo y defensa contra patadas.",
        minClasses: 10,
        techniques: ["teep", "baja", "rodilla", "chequeo"],
        exam: [
            "Mantengo la rodilla arriba 2 s antes de cada patada frontal sin perder el equilibrio.",
            "Giro el pie de apoyo en la patada baja.",
            "Encadeno 1-2 + patada baja sin bajar las manos.",
            "Chequeo patadas con ambas piernas manteniendo la guardia.",
            "Aguanto 4 asaltos de 2 minutos mezclando puños y piernas.",
        ],
        rounds: [
            warmup,
            {title: "Técnica de piernas", kind: "tecnica", seconds: 120, repeats: 3, rest: 30,
                      cue: "Patada frontal, patada baja y rodilla, lentas y con equilibrio. Recoge siempre la pierna.",
                      calls: ["Frontal", "Baja", "Rodilla", "Chequeo"], pace: 4},
            {title: "Sombra con piernas", kind: "sombra", seconds: 150, repeats: 4, rest: 60,
                      cue: "Combina puños y piernas. Después de cada combinación, vuelve a guardia.",
                      calls: ["1-2, baja", "Frontal", "1, frontal", "Chequeo, 2", "1-2-3, baja", "Rodilla", "Frontal, paso atrás", "2-3, baja", "Chequeo, 1-2"], pace: 3},
            {title: "Acondicionamiento", kind: "acondicionamiento", seconds: 45, repeats: 4, rest: 15,
                      cue: "Rodillas alternas rápidas con las manos en guardia.",
                      calls: [], pace: 0},
            {title: "Caídas", kind: "tecnica", seconds: 120, repeats: 1, rest: 0,
                      cue: "Atrás y laterales alternas. Sobre colchoneta.",
                      calls: [], pace: 0},
            cooldown,
        ]}

    const verde = {
        id: 3, name: "Verde", colorHex: "34C759", theme: "Defensa y movilidad",
        goal: "Moverte para no estar donde llega el golpe, cubrirte cuando no puedes salir y rodar en una caída.",
        minClasses: 12,
        techniques: ["rodar", "cubrirse", "pivote", "rodada"],
        exam: [
            "Paso por debajo de la cuerda rodando sin mirar al suelo.",
            "Cuando escucho «¡Cúbrete!», me cubro y salgo en diagonal, nunca hacia atrás en línea recta.",
            "Pivoto después de una combinación sin perder la guardia.",
            "Hago rodadas hacia delante suaves y silenciosas por ambos lados.",
            "Aguanto 5 asaltos de 2 minutos.",
        ],
        rounds: [
            warmup,
            {title: "Defensa en movimiento", kind: "tecnica", seconds: 120, repeats: 2, rest: 30,
                      cue: "Rueda, pivota y sal. Las manos nunca bajan.",
                      calls: ["Rueda", "Pivote", "Cúbrete y sal", "Esquiva", "Paso atrás"], pace: 3},
            {title: "Sombra defensiva", kind: "sombra", seconds: 150, repeats: 5, rest: 60,
                      cue: "Cada ataque termina saliendo del sitio. Imagina que te devuelven los golpes.",
                      calls: ["1-2, pivote", "Rueda, 3-2", "Cúbrete y sal", "1-2-3, rueda", "Esquiva, 2, pivote", "Frontal, paso atrás", "1-2, baja, sal", "Parada, 1-2, pivote"], pace: 3},
            {title: "Rodadas", kind: "tecnica", seconds: 120, repeats: 1, rest: 30,
                      cue: "Sobre colchoneta, alternando hombros. Termina en guardia.",
                      calls: [], pace: 0},
            {title: "Sprawl y levantada", kind: "acondicionamiento", seconds: 60, repeats: 3, rest: 30,
                      cue: "Sprawl, al suelo, levantada técnica, guardia. Repite.",
                      calls: [], pace: 0},
            cooldown,
        ]}

    const azul = {
        id: 4, name: "Azul", colorHex: "0A84FF", theme: "Autodefensa",
        goal: "Aplicar todo a situaciones reales: mantener la distancia, liberarte de agarres, defenderte en el suelo y escapar.",
        minClasses: 12,
        techniques: ["valla", "muneca", "ropa", "abrazo", "suelo-defensa"],
        exam: [
            "Adopto la valla de forma natural mientras hablo con calma.",
            "Me libero de un agarre de muñeca girando hacia el pulgar, por ambos lados.",
            "Me libero de un agarre de ropa y salgo en diagonal.",
            "Ante un abrazo por detrás, mi primera reacción es bajar el centro de gravedad.",
            "Desde el suelo, mantengo los pies hacia la amenaza y me levanto con levantada técnica.",
            "He practicado al menos 4 clases las variantes con compañero, despacio y con control.",
        ],
        rounds: [
            warmup,
            {title: "Valla y desescalada", kind: "tecnica", seconds: 120, repeats: 1, rest: 30,
                      cue: "Valla frente al espejo hablando en voz alta: «Tranquilo, no quiero problemas, me voy».",
                      calls: [], pace: 0},
            {title: "Liberaciones", kind: "tecnica", seconds: 120, repeats: 3, rest: 30,
                      cue: "Muñeca, ropa y abrazo por detrás. Solo o con compañero al 30 %.",
                      calls: ["Muñeca", "Ropa", "Abrazo", "Valla", "Sal"], pace: 6},
            {title: "Suelo y levantarse", kind: "suelo", seconds: 120, repeats: 2, rest: 30,
                      cue: "De lado, pies hacia la amenaza, gira sobre la cadera y levántate cuando haya distancia.",
                      calls: ["Gira", "Empuja", "Levántate", "Guardia"], pace: 5},
            {title: "Sombra con salida", kind: "sombra", seconds: 150, repeats: 3, rest: 60,
                      cue: "El objetivo de cada combinación es crear espacio para irte.",
                      calls: ["Valla, 1-2, sal", "Frontal y sal", "Cúbrete y sal", "1-2, frontal, sal", "Esquiva, 2, sal"], pace: 4},
            cooldown,
        ]}

    const marron = {
        id: 5, name: "Marrón", colorHex: "A2662E", theme: "Bajo presión",
        goal: "Que la técnica aguante el cansancio y el estrés, y saber intervenir para que una agresión pare: separar, cubrir y controlar sin poner vidas en riesgo.",
        minClasses: 15,
        techniques: ["separar", "escudo", "control-suelo"],
        exam: [
            "Separo a un agresor desde atrás sin agarrar el cuello (practicado con compañero al 30 %).",
            "Bajo a cubrir a una víctima en el suelo en menos de 2 segundos, protegiéndome la cabeza.",
            "Mantengo un control en el suelo de 30 segundos sin poner peso en el pecho ni en la espalda de mi compañero.",
            "He completado el módulo «Intervenir: cuando no puedes esperar» de la Academia.",
            "Mantengo la técnica limpia en el último asalto de la clase (comprobado en vídeo).",
            "Encadeno combinaciones de 4–6 golpes sin perder la guardia.",
            "Después de los burpees, mi primera reacción a «¡Sal!» es crear distancia.",
            "Aguanto 6 asaltos de 3 minutos.",
        ],
        rounds: [
            warmup,
            {title: "Sombra larga", kind: "sombra", seconds: 180, repeats: 3, rest: 60,
                      cue: "Combinaciones largas a ritmo alto. Respira.",
                      calls: ["1-2-3-2", "1-2-3, baja", "1-6-3-2", "Esquiva, 2-3-2", "1-2, rueda, 3-2", "Frontal, 1-2-3", "Parada, 2-3-2, pivote", "5-6-3-2"], pace: 3},
            {title: "Fatiga + decisión", kind: "acondicionamiento", seconds: 60, repeats: 4, rest: 30,
                      cue: "10 burpees y al terminar escucha: reacciona lo más rápido posible con técnica limpia.",
                      calls: ["¡Sal!", "¡Cúbrete!", "¡Valla!", "1-2 y sal", "¡Al suelo, levántate!"], pace: 6},
            {title: "Intervención", kind: "tecnica", seconds: 120, repeats: 3, rest: 30,
                      cue: "Escucha la orden y ejecútala: voz de mando, interponerte, separar o cubrir. Solo o con compañero al 30 %.",
                      calls: ["¡Voz: PARA!", "Interponte", "Separa", "Cubre a la víctima", "Control y de lado", "Suelta y distancia"], pace: 6},
            {title: "Sombra final", kind: "sombra", seconds: 180, repeats: 3, rest: 60,
                      cue: "Cansado, pero limpio. Así es como de verdad importa.",
                      calls: ["1-2", "1-2-3-2", "Cúbrete y sal", "Frontal, paso atrás", "Chequeo, 2-3", "Rueda, 3-2", "Valla, 1-2, sal"], pace: 3},
            cooldown,
        ]}

    const negro = {
        id: 6, name: "Negro", colorHex: "1C1C1E", theme: "Maestría",
        goal: "No es el final: es el principio. Mantener, pulir y enseñar.",
        minClasses: 20,
        techniques: [],
        exam: [
            "Domino todas las técnicas de los cinturones anteriores (repasado en vídeo).",
            "He enseñado los fundamentos del cinturón blanco a otra persona.",
            "Mantengo un mínimo de 3 clases por semana desde hace 2 meses.",
            "Puedo explicar por qué escapar es casi siempre la mejor opción.",
        ],
        rounds: [
            warmup,
            {title: "Repaso técnico", kind: "tecnica", seconds: 120, repeats: 3, rest: 30,
                      cue: "Elige las técnicas que peor te salgan y trabájalas lentas.",
                      calls: [], pace: 0},
            {title: "Sombra libre", kind: "sombra", seconds: 180, repeats: 5, rest: 60,
                      cue: "Todo tu repertorio. El entrenador te propone; tú decides cómo terminar.",
                      calls: ["1-2-3-2", "Frontal", "Cúbrete y sal", "1-2, baja", "Rueda, 3-2", "Valla, 1-2, sal", "Esquiva, 2-3, pivote", "Chequeo, 1-2", "5-6-3-2", "Parada, 2, frontal"], pace: 3},
            {title: "Suelo y caídas", kind: "suelo", seconds: 120, repeats: 2, rest: 30,
                      cue: "Caídas, rodadas, gambas, puente, defensa en el suelo y levantada.",
                      calls: [], pace: 0},
            cooldown,
        ]}

  return all();
})();

const HABITS = (() => {
    const daily = [
        {id: "despertar", block: "manana", kind: "habito", title: "Levántate a tu hora",
                  detail: "La misma hora todos los días, también el fin de semana. Nada más levantarte, un vaso grande de agua y abre la persiana.",
                  minutes: 2, workout: null},
        {id: "respiracion", block: "manana", kind: "habito", title: "Respiración táctica",
                  detail: "5 minutos sentado: 4 s inspirar, 4 s retener, 4 s soltar, 4 s retener. Es lo que te mantendrá con la cabeza fría.",
                  minutes: 5, workout: null},
        {id: "leccion", block: "manana", kind: "leccion", title: "Lección del día",
                  detail: "Lee la siguiente lección de la Academia y márcala como aprendida.",
                  minutes: 5, workout: null},
        {id: "bitacora", block: "noche", kind: "bitacora", title: "Bitácora",
                  detail: "2 minutos: qué has entrenado, qué has observado hoy y cómo te has sentido.",
                  minutes: 2, workout: null},
        {id: "dormir", block: "noche", kind: "habito", title: "A dormir a tu hora",
                  detail: "Pantallas fuera 30 minutos antes. Prepara la ropa de entrenar de mañana. 7–9 horas de sueño.",
                  minutes: 0, workout: null},
    ]

    const weeks = () => [cueva, forja, ciudad, guardian]

    const rest = {id: "descanso", block: "tarde", kind: "descanso", title: "Descanso activo",
                                        detail: "Hoy no entrenas fuerte. Camina 30 minutos tranquilo y estira lo que notes cargado. El músculo crece descansando.",
                                        minutes: 30, workout: null}
    const review = {id: "revision", block: "noche", kind: "habito", title: "Revisión semanal",
                                          detail: "Mira la semana en «Ver la semana»: ¿qué días cumpliste? Escribe en la bitácora una cosa que mejorar la semana que viene.",
                                          minutes: 10, workout: null}
    const mission = {id: "mision", block: "tarde", kind: "mision", title: "Misión del programa",
                                           detail: "Avanza en la siguiente misión pendiente de tu fase.",
                                           minutes: 15, workout: null}
    const kim = {id: "kim", block: "tarde", kind: "kim", title: "Juego de Kim",
                                       detail: "Una partida para entrenar la memoria visual. Si superas el 80 %, pasa a modo difícil.",
                                       minutes: 3, workout: null}
    const scenario = {id: "escenario", block: "tarde", kind: "escenario", title: "Simulador",
                                            detail: "Resuelve un escenario. Si ya los tienes todos en óptimo, repite uno sin mirar y explica en voz alta por qué es la mejor opción.",
                                            minutes: 5, workout: null}
    const dojo = {id: "dojo", block: "tarde", kind: "dojo", title: "Clase del Dojo",
                                        detail: "La clase de tu cinturón con el entrenador por voz. Antes, repasa la técnica que peor te salga.",
                                        minutes: 30, workout: null}
    const jog = {id: "trote", block: "tarde", kind: "habito", title: "Trote: de 0 a 5 km",
                                       detail: "25 minutos alternando trote y caminar. Semana 1: 1 min trote / 2 min caminar. Cada semana, 1 minuto más de trote. Por zonas iluminadas.",
                                       minutes: 25, workout: null}

    const route = {id: "ruta", block: "tarde", kind: "ruta", title: "Paso de tu ruta a la autoridad",
                                         detail: "Avanza en el siguiente paso de tu ruta: Protección Civil, vigilante de seguridad o Ciber-Batman.",
                                         minutes: 20, workout: null}

    const workout = (id, title, detail, minutes) => ({ id: "entreno-" + id, block: "tarde", kind: "entreno", title, detail, minutes, workout: id });


    const cueva = {minPhase: 0, days: [
        [workout("cueva-a", "Cueva A · Fuerza base", "Sesión guiada en casa. Si es tu primera semana, usa la versión fácil de cada ejercicio.", 25), mission],
        [workout("movilidad", "Movilidad y calma", "15 minutos de movilidad y respiración. Recupera para mañana.", 15), kim],
        [workout("cueva-b", "Cueva B · Resistencia", "Sesión guiada en casa. Descansa lo que marque cada serie, no menos.", 25), route],
        [workout("movilidad", "Movilidad y calma", "15 minutos de movilidad y respiración.", 15), scenario],
        [workout("cueva-a", "Cueva A · Fuerza base", "Intenta hacer una repetición más que el lunes en flexiones.", 25), mission],
        [scenario, kim,
         {id: "equipo", block: "tarde", kind: "habito", title: "Revisa tu equipo",
                   detail: "Botiquín (caducidades), linterna, batería externa cargada. Si te falta algo, apúntalo.", minutes: 10, workout: null}],
        [rest, review],
    ]}


    const forja = {minPhase: 1, days: [
        [workout("forja-fuerza", "Forja · Fuerza", "Fuerza con tu peso. Después, si te quedan ganas, 10 minutos de técnica lenta del Dojo.", 35)],
        [dojo, mission],
        [jog, workout("caidas", "Aprender a caer", "Sobre colchoneta. Barbilla al pecho siempre.", 20), route],
        [dojo, mission],
        [workout("forja-fuerza", "Forja · Fuerza", "Intenta mejorar una repetición en cada ejercicio respecto al lunes.", 35), jog],
        [dojo, scenario, kim],
        [rest, review],
    ]}


    const ciudad = {minPhase: 2, days: [
        [workout("forja-fuerza", "Forja · Fuerza", "Fuerza con tu peso.", 35), dojo],
        [dojo, mission],
        [workout("carrera", "Reconocimiento", "Carrera por tu barrio, de día o por zonas iluminadas. Fíjate en calles, portales y puntos seguros.", 40), route],
        [dojo, mission],
        [workout("agilidad", "Agilidad urbana", "En un parque, a ras de suelo. Nada de alturas.", 30), scenario],
        [dojo, mission,
         {id: "ruta", block: "tarde", kind: "salida", title: "Ruta de observación",
                   detail: "Recorre una de tus rutas a pie, de día o al anochecer acompañado, con «Salida segura» activada. Observa, no intervengas. Anota algo en la bitácora.",
                   minutes: 45, workout: null}],
        [rest, review],
    ]}


    const guardian = {minPhase: 4, days: [
        [workout("guardian", "Circuito del Guardián", "Preparación física para pruebas de acceso.", 45)],
        [dojo, mission],
        [workout("carrera", "Reconocimiento", "Carrera por tu barrio. Intenta bajar tu tiempo en 5 km.", 40), route],
        [dojo, mission],
        [workout("forja-fuerza", "Forja · Fuerza", "Fuerza con tu peso.", 35), scenario],
        [{id: "voluntariado", block: "tarde", kind: "voluntariado", title: "Servicio o formación",
                   detail: "Servicio con tu agrupación de Protección Civil o Cruz Roja, o una formación. Si no hay ninguno esta semana, haz una clase del Dojo.",
                   minutes: 120, workout: null}],
        [rest, review],
    ]}

    const test = {id: "test", block: "manana", kind: "test", title: "Test físico",
                                detail: "Han pasado 4 semanas: registra tu test (flexiones, sentadillas, plancha, burpees y, si puedes, 5 km). Calienta antes.",
                                minutes: 20, workout: null}

  return { daily, weeks: weeks(), test };
})();

const AUTHORITY = (() => {
    const intro = "Batman tenía al comisario Gordon. En la vida real, la confianza de la policía no se pide: se gana entrando en los equipos que ya trabajan con ella. Estos son tres caminos sin oposición. Elige uno como principal y el plan diario te irá marcando sus pasos."

    const warning = "Ningún cuerpo de policía puede autorizar a un particular a intervenir por su cuenta. Cualquier pelea, «detención» mal hecha o denuncia te cierra estos caminos: sin antecedentes no hay uniforme."

    const routes = () => [proteccion, vigilante, ciber]

    const proteccion = {
        id: "proteccion", title: "Protección Civil", icon: "cross.case.fill",
        summary: "Voluntario con uniforme en la agrupación de tu municipio. Patrullas preventivas en fiestas, conciertos y emergencias, codo con codo con la Policía Local y los servicios de emergencia. Es la forma más rápida de que la policía de tu ciudad te conozca y confíe en ti.",
        time: "2–4 meses",
        study: "Nada de oposición: un curso básico práctico y gratuito, sin examen difícil.",
        powers: "Actúas dentro de un equipo coordinado con la policía y los servicios de emergencia, con uniforme oficial y seguro.",
        requirements: [
            "Mayor de edad (algunas agrupaciones aceptan desde 16 con permiso).",
            "Sin antecedentes penales ni por delitos sexuales.",
            "Compromiso de un mínimo de horas de servicio al año (lo fija cada agrupación).",
        ],
        steps: [
            T("r-pc-0", 1, "habilidad", "Audita tu huella en internet",
                        "Antes de ponerte el uniforme, haz la lección Academia › Ciber-Batman › Protege tu identidad: que nadie pueda encontrar dónde vives buscando tu nombre."),
            T("r-pc-1", 1, "comunidad", "Localiza tu agrupación",
                        "Busca «Protección Civil» + tu municipio, o pregunta en el ayuntamiento o en la Policía Local. Apunta teléfono, correo y cuándo hacen las reuniones o la formación."),
            T("r-pc-2", 2, "ley", "Pide tus certificados",
                        "Certificado de antecedentes penales y de delitos de naturaleza sexual. Se piden gratis en la sede electrónica del Ministerio de Justicia (enlace abajo) con Cl@ve o certificado digital."),
            T("r-pc-3", 3, "comunidad", "Solicitud y entrevista",
                        "Presenta la solicitud de ingreso. En la entrevista cuenta tu formación en primeros auxilios del programa y tu perfil técnico: las agrupaciones siempre necesitan gente de comunicaciones e informática."),
            T("r-pc-4", 6, "habilidad", "Completa el curso básico",
                        "Primeros auxilios, transmisiones por radio, organización de emergencias. Ve a todas las sesiones: es tu primera impresión."),
            T("r-pc-5", 8, "comunidad", "Primer servicio preventivo",
                        "Fiestas, una carrera popular, un concierto... Empieza acompañando a voluntarios veteranos y escucha más de lo que hablas."),
            T("r-pc-6", 10, "comunidad", "Primer servicio nocturno",
                        "Tu primera noche protegiendo tu ciudad con uniforme y respaldo. Usa «Salida segura» para volver a casa."),
            T("r-pc-7", 12, "habilidad", "Ofrece tu perfil técnico",
                        "Propón ayudar con comunicaciones, la web o la ciberseguridad de la agrupación. Así pasas de voluntario a persona clave."),
            T("r-pc-8", 14, "comunidad", "Preséntate a la policía de proximidad",
                        "Acude a tu comisaría y pregunta por el Delegado de Participación Ciudadana, o ve a las reuniones de seguridad de tu asociación vecinal. Preséntate como voluntario: así es como se gana la confianza de la autoridad."),
        ],
        links: [
            {title: "Certificado de antecedentes penales (Ministerio de Justicia)", url: "https://sede.mjusticia.gob.es/es/tramites/certificado-antecedentes"},
        ]}

    const vigilante = {
        id: "vigilante", title: "Vigilante de seguridad", icon: "shield.lefthalf.filled",
        summary: "Profesión con Tarjeta de Identidad Profesional (TIP). Proteges un lugar (centro comercial, transporte, eventos), puedes detener a quien comete un delito allí y entregarlo de inmediato a la policía, y trabajas en contacto directo con ella.",
        time: "3–6 meses",
        study: "Poco: un curso en un centro homologado y un examen oficial tipo test con pruebas físicas. El centro te prepara.",
        powers: "Cuando cooperas con la policía y bajo su mando, la ley te protege frente a agresiones como si fueras agente de la autoridad (Ley 5/2014 de Seguridad Privada, art. 31).",
        requirements: [
            "Mayor de edad y nacionalidad de un país de la Unión Europea o del Espacio Económico Europeo.",
            "ESO o equivalente: tu FP superior lo cumple de sobra.",
            "Sin antecedentes penales.",
            "Informe de aptitud psicofísica de un centro de reconocimiento autorizado.",
        ],
        steps: [
            T("r-vs-0", 1, "habilidad", "Audita tu huella en internet",
                        "Antes de trabajar de cara al público, haz la lección Academia › Ciber-Batman › Protege tu identidad: que nadie pueda encontrar dónde vives buscando tu nombre."),
            T("r-vs-1", 1, "habilidad", "Elige un centro de formación homologado",
                        "Compara precio, horario (presencial u online), porcentaje de aprobados y si te preparan las pruebas físicas. Pide referencias."),
            T("r-vs-2", 2, "fisico", "Haz un test de las pruebas físicas",
                        "Pregunta en el centro qué pruebas físicas piden y haz un simulacro. Apunta tus marcas en tu test físico de la app y entrena lo que te falte."),
            T("r-vs-3", 4, "habilidad", "Completa el curso",
                        "Derecho básico, seguridad, primeros auxilios, defensa personal. Mucho ya lo has visto en la Academia."),
            T("r-vs-4", 5, "ley", "Informe médico y certificados",
                        "Informe de aptitud psicofísica en un centro de reconocimiento autorizado y certificado de antecedentes penales."),
            T("r-vs-5", 6, "habilidad", "Preséntate al examen oficial",
                        "Convocatoria de la Policía Nacional (se publica en el BOE). Test teórico y pruebas físicas."),
            T("r-vs-6", 8, "ley", "Solicita tu TIP",
                        "Con el examen aprobado, solicita la Tarjeta de Identidad Profesional. Ya eres vigilante de seguridad."),
            T("r-vs-7", 10, "comunidad", "Tu primer puesto",
                        "Empresas de seguridad privada. Con tu perfil informático, pregunta por puestos en centros de control y vigilancia tecnológica."),
        ],
        links: [
            {title: "Policía Nacional (seguridad privada y convocatorias)", url: "https://www.policia.es/"},
        ]}

    const ciber = {
        id: "ciber", title: "Ciber-Batman", icon: "lock.shield.fill",
        summary: "Tu máster de ciberseguridad es tu batcueva. Hoy la mayoría de los delitos que sufre la gente de tu barrio son digitales: estafas a mayores, suplantaciones, acoso. Puedes frenarlos ayudando a las víctimas, enseñando a protegerse, buscando desaparecidos con información pública y, como profesión, aportando pruebas que acaban en condenas.",
        time: "Desde ya",
        study: "Ninguno obligatorio: ya tienes la base. Si quieres ser perito, conviene una formación específica en análisis forense.",
        powers: "Tus informes y tu ayuda llegan a la policía y a los juzgados. Siempre con información pública o con permiso del afectado.",
        requirements: [
            "Respetar siempre la ley: nada de entrar en cuentas o dispositivos ajenos, aunque sean de un delincuente.",
            "Para listas de peritos judiciales, a veces piden grado universitario: consúltalo en el colegio profesional de tu comunidad.",
        ],
        steps: [
            T("r-cb-1", 1, "ley", "Completa el módulo Ciber-Batman",
                        "Academia › Ciber-Batman: estafas, ayuda a víctimas, OSINT legal, peritaje y las líneas rojas que nunca se cruzan."),
            T("r-cb-0", 2, "habilidad", "Audita tu propia huella",
                        "Haz contigo mismo el OSINT de la lección «Protege tu identidad» y borra lo que revele dónde vives. Primero protégete tú; luego, a los demás."),
            T("r-cb-2", 2, "comunidad", "Sé el informático de confianza de tu familia",
                        "Revisa con tus padres, abuelos o vecinos mayores: doble factor en el correo y el banco, cómo reconocer un SMS falso y qué hacer si les estafan."),
            T("r-cb-3", 3, "comunidad", "Da tu primera charla anti-estafas",
                        "30 minutos en tu asociación vecinal, un centro de mayores o una biblioteca. Usa los casos del módulo Ciber-Batman."),
            T("r-cb-4", 5, "comunidad", "Hazte cibercooperante del INCIBE",
                        "Programa de voluntarios que dan charlas de seguridad en internet en colegios y asociaciones con materiales del INCIBE. Busca «Cibercooperantes» en incibe.es."),
            T("r-cb-5", 7, "habilidad", "Participa en una búsqueda de desaparecidos",
                        "Las competiciones de Trace Labs reúnen voluntarios que buscan información pública sobre personas desaparecidas reales y la entregan a la policía. Antes, repasa la lección de OSINT legal."),
            T("r-cb-6", 10, "habilidad", "Fórmate en análisis forense",
                        "Adquisición de evidencias, cadena de custodia, informes periciales. Es lo que convierte tu conocimiento en pruebas válidas en un juicio."),
            T("r-cb-7", 12, "comunidad", "Da el salto profesional",
                        "Envía tu currículum a empresas de respuesta a incidentes, análisis forense e inteligencia de amenazas, o a despachos de peritaje informático. Infórmate en tu colegio profesional sobre las listas de peritos."),
        ],
        links: [
            {title: "INCIBE (línea de ayuda 017 y Cibercooperantes)", url: "https://www.incibe.es/"},
            {title: "Trace Labs (búsqueda de desaparecidos con OSINT)", url: "https://www.tracelabs.org/"},
        ]}

  return { intro, warning, routes: routes() };
})();
