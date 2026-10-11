import Foundation

extension SkillModule {
    static let all: [SkillModule] = [ley, auxilios, desescalada, defensa, intervencion, observacion, ciudad, mentalidad, caminos, ciber]

    // MARK: Ley

    static let ley = SkillModule(
        id: "ley", title: "Ley y límites", icon: "building.columns.fill", colorName: "blue",
        intro: "Batman, en el mundo real, acabaría en prisión. Aquí aprendes qué puede hacer legalmente un ciudadano (bastante) y qué no (mucho). Basado en la legislación española; si vives en otro país, consulta la tuya.",
        lessons: [
            Lesson(id: "ley-1", title: "Por qué Batman sería ilegal", minutes: 4, blocks: [
                .paragraph("Ningún país permite que un particular se tome la justicia por su mano. Patrullar buscando delincuentes, interrogar, retener a alguien «por si acaso», ocultar tu identidad para intimidar o castigar a alguien son, en sí mismos, delitos."),
                .bullets([
                    "Pegar a un delincuente que ya no es una amenaza: **delito de lesiones**.",
                    "Retener a alguien fuera de los casos permitidos: **detención ilegal**.",
                    "Hacerte pasar por policía o llevar insignias que lo parezcan: **usurpación de funciones públicas** (art. 402 CP) y uso indebido de uniforme (art. 402 bis).",
                    "Amenazar a alguien para que «deje el barrio»: **amenazas o coacciones**.",
                ]),
                .paragraph("La buena noticia: la ley sí te permite (y en algunos casos te obliga a) ayudar. Socorrer, avisar, ser testigo, defenderte y defender a otros de forma proporcional, y en casos concretos detener a alguien in fraganti."),
                .tip("La pregunta correcta no es «¿qué puedo hacerle al malo?», sino «¿cómo consigo que la víctima esté a salvo y que la policía tenga lo necesario?»."),
            ]),
            Lesson(id: "ley-2", title: "Legítima defensa", minutes: 5, blocks: [
                .paragraph("El **artículo 20.4 del Código Penal** exime de responsabilidad a quien actúa en defensa de la persona o derechos **propios o ajenos**, siempre que se cumplan tres requisitos:"),
                .steps([
                    "**Agresión ilegítima**: un ataque real, actual o inminente. No vale un insulto, ni una amenaza vaga, ni algo que ya terminó.",
                    "**Necesidad racional del medio empleado**: tu respuesta debe ser proporcionada. Contra un empujón no cabe un golpe con un objeto.",
                    "**Falta de provocación suficiente** por tu parte: si tú iniciaste o buscaste la pelea, no hay legítima defensa.",
                ]),
                .warning("La legítima defensa termina cuando termina la agresión. Si el agresor huye, cae o deja de atacar y tú sigues, ya eres tú el agresor."),
                .paragraph("Los jueces valoran cada caso. Por eso la regla práctica es: **haz lo mínimo necesario para estar a salvo y vete**."),
            ]),
            Lesson(id: "ley-3", title: "Omisión del deber de socorro", minutes: 3, blocks: [
                .paragraph("El **artículo 195 del Código Penal** castiga a quien no socorre a una persona desamparada y en peligro manifiesto y grave, **cuando pueda hacerlo sin riesgo propio ni de terceros**."),
                .paragraph("Y si no puedes socorrer tú, estás obligado a **pedir auxilio urgente** (llamar al 112)."),
                .tip("La ley no te pide ser un héroe que se juega la vida. Te pide no mirar hacia otro lado. Llamar al 112 ya es cumplir con tu deber, y muchas veces es lo más útil que puedes hacer."),
            ]),
            Lesson(id: "ley-4", title: "Detener a alguien: cuándo sí y cuándo no", minutes: 5, blocks: [
                .paragraph("La **Ley de Enjuiciamiento Criminal (art. 490)** permite a cualquier persona detener, entre otros casos, al que intenta cometer un delito en el momento de ir a cometerlo y al **delincuente in fraganti**."),
                .bullets([
                    "Tiene que ser en el momento: no puedes «detener» a alguien horas después porque crees que fue él.",
                    "Debes usar la fuerza mínima imprescindible.",
                    "Debes entregar a la persona a la policía **inmediatamente**: llamas al 091/062/112 desde el primer segundo.",
                    "Según el art. 491, si el detenido lo exige, tendrás que justificar que actuaste por motivos racionalmente suficientes.",
                ]),
                .danger("Que la ley lo permita NO significa que sea buena idea. Una persona acorralada puede llevar un arma, puede tener amigos cerca y puede reaccionar con violencia extrema. La gran mayoría de las veces, la opción correcta es **no detener a nadie**: observa, memoriza y avisa."),
                .paragraph("Retener a alguien fuera de estos supuestos puede ser un delito de **detención ilegal** (art. 163 CP)."),
            ]),
            Lesson(id: "ley-5", title: "Armas, máscaras y grabaciones", minutes: 5, blocks: [
                .heading("Armas"),
                .paragraph("El **Reglamento de Armas** prohíbe a los particulares, entre otras, las porras y defensas extensibles, las nudilleras, las armas eléctricas tipo táser, los bastones-estoque y las navajas automáticas. Portar armas o instrumentos peligrosos en la vía pública puede sancionarse según la **Ley de Seguridad Ciudadana** (LO 4/2015)."),
                .tip("Llevar un arma no te hace más seguro: te hace más propenso a escalar el conflicto, y puede ser usada contra ti."),
                .heading("Ocultar tu identidad"),
                .paragraph("Ir por la calle con la cara tapada para «patrullar» genera alarma, dificulta que la gente confíe en ti y puede traerte problemas con la policía. Los héroes de verdad llevan la cara descubierta y un chaleco que dice quiénes son."),
                .heading("Grabar"),
                .paragraph("Grabar un delito para entregarlo a la policía puede ser útil. **Difundirlo** en redes con caras identificables puede vulnerar el derecho a la propia imagen y la protección de datos, perjudicar la investigación y ponerte en peligro."),
                .warning("Nunca grabes si eso te expone. Tu prioridad es tu seguridad y la de la víctima, no el vídeo."),
            ]),
            Lesson(id: "ley-6", title: "Anonimato: protegerte sin máscara", minutes: 5, blocks: [
                .paragraph("El miedo a que te reconozcan y haya represalias es lógico. Pero la máscara no te protege de eso y te crea problemas nuevos."),
                .heading("Por qué la máscara juega en tu contra"),
                .bullets([
                    "**La policía te parará**: una persona con la cara tapada rondando de noche es exactamente lo que alguien denuncia. Tendrás que identificarte igualmente, y negarte es sancionable (Ley de Seguridad Ciudadana).",
                    "**Agrava cualquier problema**: si pasa algo, actuar con disfraz es una circunstancia agravante (art. 22.2 del Código Penal), y a un juez le costará más creer que actuabas de buena fe.",
                    "**Asusta a la víctima**: para alguien en peligro, un enmascarado que se acerca es otra amenaza.",
                    "**No te hace irreconocible**: tu altura, tu forma de andar, tu ropa, tu voz y las cámaras siguen ahí.",
                ]),
                .heading("Lo que sí te protege"),
                .steps([
                    "**No te enfrentes a nadie.** Si no peleas, no persigues y no te pones delante, nadie tiene motivo para buscarte. Un testigo que llama desde lejos es casi invisible.",
                    "**Avisa sin dar tu nombre.** En el 091 y el 062 no estás obligado a identificarte para dar un aviso, y las webs de la Policía Nacional y la Guardia Civil tienen apartados de colaboración ciudadana. Lo tienes en Emergencias › Avisar de forma anónima.",
                    "**Cero rastro en redes.** Nada de vídeos, fotos ni comentarios sobre lo que veas o hagas. Tampoco lo cuentes por el barrio.",
                    "**Si tienes que declarar como testigo y temes represalias**, pide que te apliquen la Ley de Protección de Testigos (LO 19/1994): pueden ocultar tu nombre, tu domicilio y tu imagen.",
                    "**Cuando hagas servicio, que sea con uniforme de voluntario.** Con el chaleco de Protección Civil o Cruz Roja eres parte de un equipo con respaldo, no alguien que se metió en un asunto ajeno.",
                ]),
                .tip("La mejor forma de que no sepan quién eres es que nunca hayas sido parte de la historia: observa, avisa y deja que actúen quienes tienen la autoridad para hacerlo."),
            ]),
        ])

    // MARK: Primeros auxilios

    static let auxilios = SkillModule(
        id: "auxilios", title: "Primeros auxilios", icon: "cross.case.fill", colorName: "red",
        intro: "La habilidad con la que más vidas salvarás. Un justiciero que sabe RCP vale más que cien que saben pelear. Esto es una introducción: haz un curso presencial con maniquí.",
        lessons: [
            Lesson(id: "aux-1", title: "PAS: Proteger, Avisar, Socorrer", minutes: 3, blocks: [
                .steps([
                    "**Proteger**: asegúrate de que la escena es segura para ti, para la víctima y para otros (tráfico, fuego, cables, agresores). Si no lo es, no entres.",
                    "**Avisar**: llama al 112. Di dónde estás, qué ha pasado, cuántas víctimas y su estado. Pon el altavoz y no cuelgues.",
                    "**Socorrer**: aplica lo que sepas hasta que lleguen los servicios de emergencia.",
                ]),
                .warning("Si te conviertes en la segunda víctima, no ayudas a nadie y los equipos tendrán que atender a dos personas."),
                .tip("Si hay más gente, señala a alguien concreto: «Tú, el de la chaqueta roja, llama al 112». En grupo, todos piensan que otro ya ha llamado."),
            ]),
            Lesson(id: "aux-2", title: "RCP: reanimación cardiopulmonar", minutes: 6, blocks: [
                .steps([
                    "Comprueba si responde: háblale fuerte y sacúdele suavemente los hombros.",
                    "Si no responde, pide ayuda y abre la vía aérea: una mano en la frente, dos dedos en la barbilla, inclina la cabeza hacia atrás.",
                    "Comprueba si respira normalmente: mira, escucha y siente durante no más de 10 segundos. Las bocanadas aisladas NO son respiración normal.",
                    "Si no respira con normalidad: llama al 112 (altavoz) y pide que alguien traiga un desfibrilador (DEA).",
                    "Compresiones: talón de la mano en el centro del pecho, la otra encima, brazos rectos. Hunde 5–6 cm a un ritmo de 100–120 por minuto.",
                    "Si estás formado, alterna 30 compresiones y 2 insuflaciones. Si no, haz solo compresiones sin parar.",
                    "En cuanto llegue el DEA, enciéndelo y sigue sus instrucciones de voz. Están diseñados para que cualquiera los use.",
                    "No pares hasta que llegue la ayuda, la persona respire con normalidad o estés agotado (turnaos cada 2 minutos si hay alguien más).",
                ]),
                .tip("Ritmo: «Stayin' Alive» de los Bee Gees o «La Macarena» van a unos 100–120 pulsaciones por minuto."),
                .warning("Puede que oigas o notes costillas romperse. Es normal y no debes parar: una costilla rota se cura; sin RCP, la persona muere."),
            ]),
            Lesson(id: "aux-3", title: "Posición lateral de seguridad", minutes: 3, blocks: [
                .paragraph("Si la persona está **inconsciente pero respira con normalidad** y no sospechas lesión de columna (caída, golpe fuerte, accidente), colócala de lado para que no se ahogue con vómito o con su lengua."),
                .steps([
                    "Arrodíllate a su lado. Brazo más cercano a ti en ángulo recto, palma hacia arriba.",
                    "El otro brazo, cruzado sobre el pecho, con el dorso de la mano contra su mejilla.",
                    "Dobla la rodilla más lejana y tira de ella hacia ti para girar el cuerpo de lado.",
                    "Inclina la cabeza ligeramente hacia atrás para mantener abierta la vía aérea.",
                    "Abrígala y vigila su respiración hasta que llegue la ayuda.",
                ]),
            ]),
            Lesson(id: "aux-4", title: "Atragantamiento", minutes: 3, blocks: [
                .bullets([
                    "Si puede **toser**: anímale a seguir tosiendo con fuerza. No le des golpes.",
                    "Si **no puede toser, hablar ni respirar**: colócate a su lado, inclínale hacia delante y dale hasta **5 golpes** firmes entre los omóplatos con el talón de la mano.",
                    "Si no funciona: hasta **5 compresiones abdominales** (maniobra de Heimlich). Detrás de la persona, puño encima del ombligo, la otra mano encima, tira hacia dentro y hacia arriba.",
                    "Alterna 5 y 5. Si pierde la consciencia: llama al 112 y empieza RCP.",
                ]),
                .warning("En embarazadas y personas con obesidad, las compresiones se hacen en el pecho. En bebés la técnica es diferente: apréndela en un curso."),
            ]),
            Lesson(id: "aux-5", title: "Hemorragias, quemaduras y convulsiones", minutes: 5, blocks: [
                .heading("Hemorragias"),
                .bullets([
                    "Ponte guantes si los tienes.",
                    "Presión directa y firme sobre la herida con gasas o tela limpia. Mantén la presión sin levantar para mirar.",
                    "Si se empapa, pon más gasas encima; no retires las primeras.",
                    "El torniquete es solo para hemorragias masivas en extremidades, y conviene haber sido formado para usarlo.",
                    "Si hay un objeto clavado, NO lo saques: inmovilízalo y presiona alrededor.",
                ]),
                .heading("Quemaduras"),
                .bullets([
                    "Agua corriente a temperatura ambiente durante al menos 20 minutos.",
                    "Quita anillos y pulseras antes de que se hinche. No despegues ropa adherida.",
                    "Nada de pasta de dientes, aceite ni hielo directo.",
                ]),
                .heading("Convulsiones"),
                .bullets([
                    "Aparta objetos peligrosos y protege la cabeza con algo blando.",
                    "NO le sujetes ni le metas nada en la boca.",
                    "Cronometra la crisis. Si dura más de 5 minutos, se repite o es la primera vez, llama al 112.",
                    "Al terminar, posición lateral de seguridad.",
                ]),
            ]),
        ])

    // MARK: Desescalada

    static let desescalada = SkillModule(
        id: "desescalada", title: "Desescalada", icon: "bubble.left.and.bubble.right.fill", colorName: "green",
        intro: "El arte de bajar la temperatura de un conflicto sin que nadie salga herido. Es la técnica de combate más avanzada que existe.",
        lessons: [
            Lesson(id: "des-1", title: "Distancia, postura y voz", minutes: 4, blocks: [
                .bullets([
                    "**Distancia**: al menos dos brazos. Te da tiempo de reaccionar y no invade a la otra persona.",
                    "**Ángulo**: colócate ligeramente de lado, no de frente. Es menos desafiante y más estable.",
                    "**Manos visibles y abiertas** a la altura del pecho, como si dijeras «tranquilo». Comunican paz y, a la vez, están listas para protegerte.",
                    "**Voz**: baja, lenta y calmada. Si la otra persona grita, no subas el volumen: bájalo.",
                    "**Salida**: nunca acorrales a nadie y no te dejes acorralar. Ambos necesitáis una salida.",
                ]),
                .tip("Tu calma se contagia. Tu nerviosismo, también."),
            ]),
            Lesson(id: "des-2", title: "Qué decir (y qué no)", minutes: 5, blocks: [
                .heading("Funciona"),
                .bullets([
                    "«Veo que estás muy enfadado. ¿Qué ha pasado?»",
                    "«Tienes razón en que eso es injusto.» (Validar la emoción no es dar la razón en todo.)",
                    "«Quiero que esto acabe bien para todos.»",
                    "Preguntar el nombre y usarlo.",
                    "Ofrecer opciones: «¿Prefieres que hablemos aquí o vamos fuera a tomar el aire?»",
                ]),
                .heading("Empeora"),
                .bullets([
                    "«Cálmate.» (Casi nunca calma a nadie.)",
                    "Amenazar, retar, burlarse o hacer bromas.",
                    "Tocar a la persona sin permiso.",
                    "Discutir quién tiene razón en ese momento.",
                    "Hablar con desprecio delante de otros: nadie quiere quedar mal ante su grupo.",
                ]),
            ]),
            Lesson(id: "des-3", title: "Saber retirarse", minutes: 3, blocks: [
                .paragraph("Desescalar no siempre funciona. Las drogas, el alcohol, una crisis de salud mental o un grupo que se jalea pueden hacer imposible razonar."),
                .bullets([
                    "Señales de que va a haber agresión: puños apretados, mandíbula tensa, mirada fija o que se desvía buscando objetivo, se quita la chaqueta o las gafas, acorta la distancia, deja de hablar de repente.",
                    "Si ves estas señales: aumenta la distancia, retírate hacia tu salida y llama al 112.",
                ]),
                .tip("Retirarse no es perder. Quien vuelve sano a casa, gana."),
            ]),
        ])

    // MARK: Defensa personal

    static let defensa = SkillModule(
        id: "defensa", title: "Defensa personal realista", icon: "figure.martial.arts", colorName: "orange",
        intro: "La verdad que no venden en los vídeos: en la calle no hay reglas, no hay árbitro, puede haber armas, varios agresores y suelo de cemento. La mejor defensa casi siempre es no estar allí.",
        lessons: [
            Lesson(id: "def-1", title: "La pirámide de prioridades", minutes: 4, blocks: [
                .steps([
                    "**Evitar**: no ir, cambiar de acera, salir antes, no responder a provocaciones.",
                    "**Escapar**: si puedes irte, vete. Correr es una técnica de autodefensa excelente.",
                    "**Desescalar**: hablar para enfriar la situación.",
                    "**Defenderse**: solo si no queda otra opción, con lo mínimo imprescindible para poder escapar.",
                ]),
                .danger("Si alguien te amenaza con un arma para robarte, DALE LO QUE PIDE. Ningún móvil, cartera ni zapatillas vale tu vida. Memoriza su descripción y llama después."),
            ]),
            Lesson(id: "def-2", title: "Qué aprendes en el Dojo y por qué", minutes: 5, blocks: [
                .paragraph("El Dojo de la app (Entreno › Dojo en casa) mezcla lo más útil de varias disciplinas para un objetivo concreto: **protegerte lo justo para poder escapar**."),
                .bullets([
                    "**Del boxeo**: la guardia, los desplazamientos, los 6 golpes de puño y las esquivas. Es la base más práctica para protegerte la cabeza.",
                    "**Del kickboxing y el muay thai**: la patada frontal para crear distancia, la patada baja, la rodilla y cómo defender patadas.",
                    "**Del judo**: las caídas. Es lo que más te puede salvar en una situación real (un empujón, un resbalón).",
                    "**Del jiu-jitsu y la lucha**: el puente, el escape de cadera, el sprawl y levantarte del suelo sin quedar expuesto.",
                    "**De la defensa personal**: la valla, liberarte de agarres y, sobre todo, la idea de que cada técnica termina escapando.",
                ]),
                .tip("En casa, tu instructor eres tú con el móvil: grábate, compara con los pasos de cada técnica y sé honesto en los exámenes. La constancia durante años importa más que cualquier disciplina."),
                .warning("Lo que el Dojo no puede darte es un rival que se resiste. Por eso las técnicas de autodefensa tienen variantes con compañero, siempre lentas. Y desconfía de cualquiera que te venda «técnicas letales» o ataques «que funcionan siempre»."),
            ]),
            Lesson(id: "def-3", title: "Lo que la calle tiene de distinto", minutes: 4, blocks: [
                .bullets([
                    "**Armas ocultas**: asume que cualquiera puede llevar una navaja. Muchas víctimas de apuñalamiento ni la vieron.",
                    "**Varios agresores**: el suelo es mortal si hay más de uno. Prioriza mantenerte de pie y salir.",
                    "**Superficies**: un golpe de cabeza contra el bordillo puede matar. A ti o al otro (y eso también te arruina la vida).",
                    "**Adrenalina**: perderás coordinación fina, visión periférica y noción del tiempo. Solo funciona lo que has entrenado cientos de veces.",
                ]),
                .paragraph("Por eso este programa no te convierte en un luchador callejero, sino en alguien en forma, que sabe protegerse lo justo para escapar y que dedica su energía a lo que de verdad salva vidas."),
            ]),
        ])

    // MARK: Observación

    static let observacion = SkillModule(
        id: "observacion", title: "Observación y testimonio", icon: "eye.fill", colorName: "purple",
        intro: "El superpoder detective. La policía resuelve muchos casos gracias a testigos que se fijaron bien y lo contaron con claridad.",
        lessons: [
            Lesson(id: "obs-1", title: "Describir a una persona", minutes: 5, blocks: [
                .paragraph("Describe siempre de **arriba abajo** y de lo general a lo particular:"),
                .steps([
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
                .tip("La ropa se cambia en minutos; los rasgos físicos, el calzado y los tatuajes no. Prioriza esos detalles."),
            ]),
            Lesson(id: "obs-2", title: "Describir un vehículo", minutes: 3, blocks: [
                .bullets([
                    "**Matrícula**, aunque sea parcial. Repítela en voz alta o escríbela en el móvil enseguida.",
                    "Tipo (turismo, furgoneta, moto), color, marca y modelo si lo sabes.",
                    "Detalles: golpes, pegatinas, baca, lunas tintadas, luces rotas.",
                    "Número de ocupantes y dónde iban sentados.",
                    "Dirección de huida y hora exacta.",
                ]),
                .warning("Nunca sigas a un vehículo. Ni a pie, ni en coche, ni en patinete."),
            ]),
            Lesson(id: "obs-3", title: "La llamada perfecta al 112", minutes: 4, blocks: [
                .paragraph("Los operadores están entrenados para guiarte. Contesta a lo que te pregunten, pero ten preparadas estas respuestas:"),
                .steps([
                    "**¿Dónde?** Calle, número, municipio, y una referencia visible («frente a la farmacia»).",
                    "**¿Qué pasa?** En una frase.",
                    "**¿Cuántas personas** implicadas y cuántos heridos?",
                    "**¿Hay armas** o peligro activo?",
                    "**¿Hacia dónde** han huido y cómo (a pie, coche, moto)?",
                    "Descripciones.",
                ]),
                .tip("No cuelgues hasta que el operador te lo diga. Si no puedes hablar, deja la línea abierta o usa AlertCops."),
                .paragraph("Números en España: **112** emergencias generales · **091** Policía Nacional · **062** Guardia Civil · **092** Policía Local · **016** violencia de género · **024** conducta suicida."),
            ]),
            Lesson(id: "obs-4", title: "Tu memoria bajo estrés", minutes: 3, blocks: [
                .bullets([
                    "La memoria se degrada en minutos y se contamina al hablar con otros testigos. **Escribe todo lo que recuerdes cuanto antes**, a solas.",
                    "Separa lo que **sabes** de lo que **crees**: «llevaba algo en la mano, creo que era un móvil».",
                    "Decir «no lo sé» es mucho más útil que inventar. Un detalle falso puede desviar una investigación.",
                    "La hora exacta es oro: mira el reloj en cuanto puedas.",
                ]),
            ]),
        ])

    // MARK: Ciudad y noche

    static let ciudad = SkillModule(
        id: "ciudad", title: "Ciudad y noche", icon: "moon.haze.fill", colorName: "teal",
        intro: "Moverse por la ciudad de noche con los ojos abiertos, sin paranoia y sin exponerse.",
        lessons: [
            Lesson(id: "ciu-1", title: "El código de colores de Cooper", minutes: 4, blocks: [
                .bullets([
                    "**Blanco**: desconectado. Mirando el móvil, auriculares a tope. Así es como sorprenden a la gente.",
                    "**Amarillo**: atento y relajado. Sabes quién hay a tu alrededor y dónde están las salidas. Es tu estado normal en la calle.",
                    "**Naranja**: algo concreto te ha llamado la atención. Piensas «si pasa X, haré Y».",
                    "**Rojo**: la amenaza es real. Ejecutas tu plan: irte, llamar, protegerte.",
                ]),
                .tip("Vive en amarillo. No es miedo: es como conducir mirando los retrovisores."),
            ]),
            Lesson(id: "ciu-2", title: "Hábitos de seguridad nocturna", minutes: 4, blocks: [
                .bullets([
                    "Planifica la ruta antes de salir. Elige calles iluminadas y con gente aunque sea más largo.",
                    "Auriculares: uno solo o volumen bajo.",
                    "Móvil cargado y con la ubicación compartida con tu persona de confianza.",
                    "Si notas que alguien te sigue: cruza la calle, cambia de ritmo, entra en un comercio abierto o en un sitio con gente, y llama.",
                    "Lleva las llaves a mano al llegar a casa. No te quedes en el portal mirando el móvil.",
                    "Confía en tu intuición. Si algo no te cuadra, no necesitas justificarlo: vete.",
                ]),
            ]),
            Lesson(id: "ciu-3", title: "Tu mapa mental de puntos seguros", minutes: 3, blocks: [
                .paragraph("En cada zona por la que te muevas, deberías saber sin mirar el móvil:"),
                .bullets([
                    "Dónde está la comisaría o cuartel más cercano.",
                    "El centro de salud u hospital más cercano.",
                    "Farmacias de guardia y comercios abiertos 24 h.",
                    "Desfibriladores públicos (en farmacias, estaciones, polideportivos, centros comerciales).",
                    "Zonas oscuras, solares o pasos subterráneos que conviene evitar.",
                ]),
            ]),
        ])

    // MARK: Mentalidad

    static let mentalidad = SkillModule(
        id: "mentalidad", title: "Mentalidad", icon: "brain.head.profile", colorName: "pink",
        intro: "El cuerpo hace lo que la mente le permite. Aprende a gestionar el miedo, el estrés y el ego.",
        lessons: [
            Lesson(id: "men-1", title: "Qué le pasa a tu cuerpo bajo estrés", minutes: 4, blocks: [
                .bullets([
                    "**Visión de túnel**: dejas de ver lo que pasa a los lados (¿el amigo del agresor?).",
                    "**Exclusión auditiva**: dejas de oír o los sonidos se apagan.",
                    "**Pérdida de motricidad fina**: te cuesta marcar el móvil o abrir una puerta.",
                    "**Distorsión del tiempo**: todo parece ir a cámara lenta o muy rápido.",
                    "**Temblores y náuseas** después, cuando baja la adrenalina.",
                ]),
                .tip("Por eso hay que entrenar acciones simples hasta que sean automáticas: llamar al 112, la secuencia de RCP, retirarse. Bajo estrés no se improvisa bien."),
            ]),
            Lesson(id: "men-2", title: "Respiración táctica", minutes: 3, blocks: [
                .paragraph("La usan militares, policías, bomberos y deportistas de élite para bajar las pulsaciones en segundos."),
                .steps([
                    "Inspira por la nariz contando 4.",
                    "Retén el aire contando 4.",
                    "Suelta por la boca contando 4.",
                    "Mantén los pulmones vacíos contando 4.",
                    "Repite 4 ciclos.",
                ]),
                .tip("Practícala a diario cuando estés tranquilo. Así funcionará cuando no lo estés."),
            ]),
            Lesson(id: "men-3", title: "Tu porqué y tus villanos internos", minutes: 4, blocks: [
                .paragraph("Batman es un personaje construido sobre un trauma y una sed de venganza. Es buena ficción, pero mala receta para la vida real."),
                .bullets([
                    "**Ego**: querer ser el héroe de la historia te empuja a intervenir cuando lo correcto es llamar.",
                    "**Rabia**: si te enfadas con facilidad o buscas que «alguien se lo merezca», el peligro eres tú.",
                    "**Aislamiento**: el justiciero solitario acaba quemado o haciendo locuras. Rodéate de gente.",
                ]),
                .paragraph("Si arrastras rabia, un trauma o un dolor que te empuja a esto, hablar con un profesional de salud mental no es debilidad: es el entrenamiento más importante de todos."),
                .tip("Si alguna vez tienes pensamientos de hacerte daño, llama al 024 (gratuito, 24 h)."),
            ]),
        ])

    // MARK: Caminos

    static let caminos = SkillModule(
        id: "caminos", title: "Caminos reales", icon: "signpost.right.and.left.fill", colorName: "yellow",
        intro: "Hay muchas maneras legales y respetadas de proteger a la gente por la noche. Algunas son voluntarias y otras son una profesión. Requisitos orientativos: compruébalos siempre en las convocatorias oficiales.",
        lessons: [
            Lesson(id: "cam-1", title: "Voluntariado", minutes: 4, blocks: [
                .bullets([
                    "**Protección Civil**: agrupaciones municipales de voluntarios. Servicios preventivos en eventos, emergencias, búsquedas, incendios. Formación básica gratuita y uniforme.",
                    "**Cruz Roja**: socorros y emergencias, salvamento acuático y unidades de emergencia social que atienden de noche a personas sin hogar.",
                    "**Bancos de sangre**: donar sangre o registrarte como donante de médula.",
                    "**ONG y asociaciones de barrio**: acompañamiento a mayores, jóvenes en riesgo, mediación.",
                ]),
                .tip("El chaleco de voluntario es el traje de superhéroe que la gente reconoce y en el que confía."),
            ]),
            Lesson(id: "cam-2", title: "Profesiones", minutes: 6, blocks: [
                .bullets([
                    "**Policía Nacional, Guardia Civil, Policía Local o autonómica**: oposición con pruebas físicas, de conocimientos y psicotécnicas. Requieren nacionalidad española y carecer de antecedentes, entre otros requisitos.",
                    "**Bombero**: oposiciones muy exigentes físicamente. Suelen pedir carné de conducir profesional.",
                    "**Técnico en Emergencias Sanitarias (TES)**: FP de grado medio. Trabajas en ambulancias.",
                    "**Vigilante de seguridad**: curso de formación y examen oficial ante la Policía Nacional para obtener la TIP. Mayor de edad.",
                    "**Socorrista acuático**: curso con certificación. Ideal como primer trabajo o complemento.",
                    "**Fuerzas Armadas / UME**: la Unidad Militar de Emergencias actúa en catástrofes.",
                    "**Enfermería, medicina, trabajo social, criminología, derecho**: carreras que protegen a la gente desde otro ángulo.",
                ]),
                .tip("Casi todas estas pruebas exigen buena forma física. Lo que has entrenado en este programa es una gran base."),
            ]),
        ])

    // MARK: Ciber-Batman

    static let ciber = SkillModule(
        id: "ciber", title: "Ciber-Batman", icon: "lock.shield.fill", colorName: "blue",
        intro: "La mayoría de los delitos que sufre hoy la gente de tu barrio no ocurren en un callejón, sino en el móvil. Con conocimientos de ciberseguridad puedes proteger a más personas que cualquier justiciero nocturno, siempre dentro de la ley.",
        lessons: [
            Lesson(id: "cib-1", title: "Las estafas más comunes", minutes: 6, blocks: [
                .paragraph("Casi todas siguen el mismo patrón: **urgencia + autoridad o cariño + un pago o un código**. Si aprendes a ver el patrón, las ves venir todas."),
                .bullets([
                    "**El hijo en apuros**: «Hola mamá, se me ha roto el móvil, este es mi número nuevo. ¿Me haces un Bizum urgente?»",
                    "**Falso banco, Correos o DGT**: un SMS con un enlace para «verificar tu cuenta», «pagar el envío» o «pagar una multa».",
                    "**Falso técnico**: te llaman «de Microsoft» o de tu compañía para arreglar un virus y te piden instalar un programa de control remoto.",
                    "**El código de verificación**: alguien te pide «el código que te acaba de llegar». Con él te roban el WhatsApp o autorizan un pago.",
                    "**Bizum inverso**: en una compraventa, en vez de enviarte dinero te mandan una *solicitud* de pago para que la aceptes tú.",
                    "**Inversiones milagro**: anuncios con famosos que prometen hacerte rico con criptomonedas. El dinero desaparece.",
                    "**Estafa del amor**: alguien que conoces por internet, nunca puede hacer videollamada y acaba pidiendo dinero por una emergencia.",
                ]),
                .tip("La regla de oro que enseñarás a tu familia: **ningún banco, empresa ni organismo te pide nunca contraseñas ni códigos**. Ante la duda, cuelga y llama tú al número oficial."),
            ]),
            Lesson(id: "cib-2", title: "Ayudar a una víctima de estafa", minutes: 5, blocks: [
                .paragraph("Los primeros minutos importan: cuanto antes se actúa, más posibilidades hay de recuperar el dinero y de que la policía pueda investigar."),
                .steps([
                    "**Llamar al banco ya**, al teléfono del reverso de la tarjeta: bloquear tarjetas y pedir que intenten parar o devolver la transferencia.",
                    "**Recuperar el control**: cambiar primero la contraseña del correo, después la del banco y las redes. Activar la verificación en dos pasos y cerrar las sesiones abiertas.",
                    "**Guardar pruebas, no borrar nada**: capturas con fecha y hora, números de teléfono, enlaces, nombres de perfiles, justificantes de pago.",
                    "**Denunciar** en la Policía Nacional o la Guardia Civil, llevando todas las pruebas. Sin denuncia no hay investigación ni posible devolución.",
                    "**Llamar al 017**, la línea de ayuda en ciberseguridad del INCIBE: gratuita y confidencial. Te orientan paso a paso.",
                    "**Avisar a sus contactos** si han suplantado su identidad o su WhatsApp, para que nadie más pique.",
                ]),
                .warning("La víctima suele sentir vergüenza. Nunca le digas «¿cómo has picado?». Estas estafas las diseñan profesionales y caen personas de todas las edades y estudios."),
            ]),
            Lesson(id: "cib-3", title: "OSINT legal: qué sí y qué no", minutes: 5, blocks: [
                .paragraph("OSINT es la investigación con **fuentes abiertas**: información que cualquiera puede consultar legalmente. Bien usada, ayuda a encontrar personas desaparecidas o a documentar una estafa para la policía."),
                .heading("Sí"),
                .bullets([
                    "Buscar en webs, redes y registros públicos.",
                    "Documentar con capturas fechadas y enlaces todo lo que encuentres.",
                    "Entregar lo encontrado a la policía o a la organización que coordina la búsqueda.",
                    "Participar en iniciativas organizadas, como las búsquedas de desaparecidos de Trace Labs.",
                ]),
                .heading("No"),
                .bullets([
                    "Entrar en cuentas, móviles u ordenadores ajenos, ni adivinar contraseñas.",
                    "Contactar o engañar a sospechosos haciéndote pasar por otra persona.",
                    "Publicar datos o fotos de nadie («doxing»), aunque creas que es culpable.",
                    "Investigar a personas concretas por tu cuenta, fuera de una búsqueda organizada o un encargo legal.",
                ]),
                .warning("Exponer en redes a un supuesto delincuente puede arruinar la investigación policial, poner en peligro a inocentes y acabar en una denuncia contra ti."),
            ]),
            Lesson(id: "cib-4", title: "Peritaje: pruebas que valen en un juicio", minutes: 6, blocks: [
                .paragraph("Un juez no condena por una captura de pantalla dudosa. Condena con pruebas que se pueden verificar. Eso es lo que hace un perito informático forense, y es probablemente el trabajo más «Batman» al que puedes aspirar con tu formación."),
                .steps([
                    "**Preservar**: no manipular el dispositivo original. Si está encendido, aislarlo de la red (modo avión) en vez de apagarlo sin criterio.",
                    "**Adquirir**: hacer una copia forense bit a bit con bloqueador de escritura, y trabajar siempre sobre la copia.",
                    "**Verificar**: calcular el hash (por ejemplo, SHA-256) del original y de la copia para demostrar que son idénticos.",
                    "**Cadena de custodia**: documentar quién, cuándo, dónde y cómo ha tenido la evidencia en cada momento.",
                    "**Informe pericial**: claro, reproducible y entendible por alguien que no sea técnico. Debes poder defenderlo ante el juez.",
                ]),
                .tip("Para conversaciones de WhatsApp o publicaciones en redes, una captura se puede impugnar. Existen servicios de certificación de evidencias digitales y el acta notarial que les dan validez."),
            ]),
            Lesson(id: "cib-5", title: "Líneas rojas que nunca se cruzan", minutes: 4, blocks: [
                .paragraph("Saber atacar sistemas no te da permiso para hacerlo, ni siquiera contra un delincuente. Un hacker justiciero es, para la ley, un delincuente más, y sus «pruebas» no valen."),
                .bullets([
                    "**Acceso sin autorización** a sistemas o cuentas: delito (art. 197 bis del Código Penal).",
                    "**Interceptar comunicaciones** o apoderarse de mensajes, correos o datos ajenos: delito de descubrimiento y revelación de secretos (art. 197).",
                    "**Tumbar webs o dañar sistemas** (DDoS, borrar datos): delito de daños informáticos (arts. 264 y siguientes).",
                    "**Hacerte pasar por otra persona** para engañar: puede ser usurpación de estado civil o estafa.",
                    "**Atacar al atacante** («hack back»): ilegal aunque te hayan atacado a ti primero.",
                ]),
                .tip("Las pruebas de seguridad solo se hacen con **autorización por escrito** del propietario o dentro de programas de recompensas (bug bounty) que lo permitan expresamente."),
            ]),
            Lesson(id: "cib-6", title: "Protege tu identidad: audítate a ti mismo", minutes: 8, blocks: [
                .paragraph("Hoy nadie te localiza siguiéndote por la calle: te buscan en internet. Una máscara no tapa nada de eso. Una buena higiene digital, sí. Haz contigo mismo el OSINT que harías en una investigación."),
                .heading("1. Qué se sabe de ti"),
                .steps([
                    "Busca tu nombre completo entre comillas, tus usuarios de redes, tu correo y tu teléfono en varios buscadores. Apunta todo lo que salga.",
                    "Haz una búsqueda inversa de tu cara (por ejemplo, con Google Lens) usando tus fotos de perfil.",
                    "Marca en rojo lo que revela **dónde vives, dónde trabajas, tu rutina o tu familia**: es lo que hay que borrar primero.",
                ]),
                .heading("2. Cierra puertas"),
                .bullets([
                    "Redes en privado, sin ciudad, empresa ni lista de amigos visible. Revisa también fotos en las que te etiquetan otros.",
                    "Nada de fotos de tu portal, tu calle, tu coche, tu matrícula o la vista desde tu casa. Desactiva la ubicación de la cámara.",
                    "Apps deportivas (Strava y similares): perfil privado y **zona de privacidad** alrededor de tu casa. Tus rutas de carrera dibujan dónde vives.",
                    "No publiques en tiempo real dónde estás: súbelo después, si acaso.",
                    "Que el nombre de tu Wi-Fi no lleve tu nombre ni tu piso.",
                ]),
                .heading("3. Pide que borren tus datos"),
                .bullets([
                    "Ejerce tu **derecho de supresión** (art. 17 del RGPD) ante webs, guías o buscadores de personas que publiquen tu dirección o teléfono. Si no te responden en un mes, reclama ante la **AEPD**.",
                    "Google tiene un formulario para pedir que retire resultados con datos personales como tu dirección o tu teléfono.",
                    "Pide a tu operadora que tu número no figure en las guías telefónicas.",
                ]),
                .heading("4. Separa identidades"),
                .bullets([
                    "Un correo y un número distintos para el voluntariado, la ciberseguridad y cualquier actividad pública.",
                    "Contraseñas únicas en un gestor y verificación en dos pasos en todo, empezando por el correo.",
                    "Nunca cuentes en redes ni en el barrio lo que haces.",
                ]),
                .tip("Repite la auditoría cada 6 meses. Y recuerda: con uniforme te identificas por un número (la TIP de vigilante o tu número de voluntario), no por tu nombre."),
            ]),
        ])

    // MARK: Intervenir

    static let intervencion = SkillModule(
        id: "intervencion", title: "Intervenir: cuando no puedes esperar", icon: "hand.raised.fill", colorName: "red",
        intro: "La policía tarda minutos en llegar y hay situaciones en las que esos minutos lo deciden todo. Este módulo te prepara para intervenir cuando de verdad hace falta: cuándo sí, cómo hacerlo con el menor riesgo y cómo no acabar siendo tú el denunciado. La meta nunca es ganar una pelea: es que la agresión pare.",
        lessons: [
            Lesson(id: "int-1", title: "Cuándo sí intervenir (y cuándo no)", minutes: 6, blocks: [
                .paragraph("Intervenir físicamente está justificado cuando se cumplen **las tres** condiciones a la vez:"),
                .steps([
                    "**Una persona está sufriendo un daño grave ahora mismo** o va a sufrirlo en segundos: le están pegando en el suelo, la arrastran contra su voluntad, la están estrangulando.",
                    "**Tu intervención puede cambiar el resultado**: puedes hacer que pare, que la víctima escape o que el agresor se vaya.",
                    "**El riesgo es asumible**: no hay armas a la vista, no estás en clara inferioridad numérica y tienes por dónde salir.",
                ]),
                .heading("Cuándo no"),
                .bullets([
                    "**Para proteger cosas**: un móvil, una moto o un escaparate no valen ni un riesgo.",
                    "**Si la agresión ya ha terminado** y el agresor se va: atiende a la víctima y describe al agresor.",
                    "**Si hay un arma** y no hay una vida en peligro inmediato: distancia, barreras, 112 y testigos.",
                    "**Si estás solo frente a un grupo**: busca aliados antes de acercarte.",
                ]),
                .tip("Ese análisis tiene que durar dos segundos. Por eso se entrena en el Simulador hasta que sea automático."),
                .warning("Que la policía tarde no cambia la regla: el 112 se llama siempre, en cuanto puedas, aunque sea con el altavoz mientras actúas o pidiéndoselo a otra persona."),
            ]),
            Lesson(id: "int-2", title: "Lo que la ley te permite", minutes: 5, blocks: [
                .paragraph("La ley española no te obliga a mirar: te **permite** defender a otra persona igual que a ti mismo (art. 20.4 del Código Penal), con tres condiciones:"),
                .bullets([
                    "**Agresión real y actual** contra esa persona.",
                    "**Medio proporcionado**: lo mínimo necesario para que pare. Contra empujones, no puñetazos; contra puñetazos, no un objeto contundente.",
                    "**Sin provocación** por tu parte.",
                ]),
                .paragraph("Además, puedes **retener al agresor in fraganti** para entregarlo a la policía (art. 490 de la Ley de Enjuiciamiento Criminal), con la fuerza mínima y avisando inmediatamente."),
                .danger("En el momento en que el agresor deja de atacar, huye o queda en el suelo sin poder seguir, **todo lo que hagas a partir de ahí ya no es defensa**: es agresión. Un golpe de más convierte al héroe en acusado."),
            ]),
            Lesson(id: "int-3", title: "Intervenir en grupo", minutes: 4, blocks: [
                .paragraph("Un solo testigo que interviene es un objetivo. Tres personas que se acercan a la vez son una fuerza que casi siempre hace que el agresor pare o se vaya sin que nadie tenga que tocarle."),
                .steps([
                    "**Recluta en voz alta y señalando**: «¡Tú y tú, venid conmigo! ¡Tú, llama al 112!»",
                    "**Reparte papeles**: uno llama, otro se queda con la víctima, los demás se acercan contigo.",
                    "**Acercaos juntos**, de frente y sin rodear del todo al agresor: que vea que tiene una salida.",
                    "**Hablad alto**: «¡Para ya! ¡La policía está viniendo!» Muchas agresiones terminan aquí.",
                ]),
                .tip("La gente quiere ayudar, pero cada uno espera a que lo haga otro. En cuanto alguien da instrucciones concretas, los demás le siguen."),
            ]),
            Lesson(id: "int-4", title: "La escalera de intervención", minutes: 6, blocks: [
                .paragraph("Empieza siempre por el escalón más bajo que funcione y sube solo si el anterior no basta. Puedes bajar en cualquier momento."),
                .steps([
                    "**Presencia**: acércate de forma visible, en guardia natural (la valla), con aliados si es posible.",
                    "**Voz de mando**: órdenes cortas, alto y claro. «¡PARA! ¡DÉJALE! ¡ATRÁS!» Nada de insultos.",
                    "**Interponerte**: colócate entre el agresor y la víctima, manos arriba, y haz que la víctima se aleje o cúbrela si está en el suelo.",
                    "**Separar**: si siguen enganchados, apártalo desde atrás o desde un lado con la técnica del Dojo, sin golpear.",
                    "**Controlar**: si sigue atacando, sujeción o control en el suelo seguro hasta que se calme o llegue la policía.",
                    "**Defenderte**: los golpes solo si te atacan a ti o a la víctima y no hay otra forma de pararlo. Para crear un hueco, no para castigar.",
                ]),
                .warning("Fíjate en sus manos todo el tiempo. Si aparece un arma, el plan cambia: distancia, barreras (una silla, una mochila, un coche) y que se vaya."),
            ]),
            Lesson(id: "int-5", title: "Retener sin poner en riesgo una vida", minutes: 5, blocks: [
                .paragraph("Si decides retener a alguien hasta que llegue la policía, tu responsabilidad sobre su vida empieza en ese momento. Personas han muerto por retenciones mal hechas en la calle."),
                .bullets([
                    "**Nunca presiones el cuello ni la garganta**, ni con el brazo ni con la rodilla.",
                    "**Nunca pongas tu peso sobre su espalda o su pecho** si está boca abajo: provoca asfixia por posición en pocos minutos.",
                    "**Ponlo de lado** en cuanto deje de resistirse y vigila que respire.",
                    "**Habla con él**: «Tranquilo, no te voy a hacer daño, viene la policía». Baja la tensión de todos.",
                    "**Si se resiste mucho, suéltalo y déjale ir.** Ya tienes su descripción. Ninguna retención vale una vida, la suya o la tuya.",
                    "**Entrégalo en cuanto llegue la policía** y explica qué ha pasado.",
                ]),
                .danger("Si deja de hablar, se pone azul, vomita o deja de moverse: suelta de inmediato, ponlo de lado, comprueba si respira y empieza RCP si hace falta."),
            ]),
            Lesson(id: "int-6", title: "Después de intervenir", minutes: 4, blocks: [
                .steps([
                    "**Atiende a la víctima** y a ti mismo: primeros auxilios y, si alguien está herido, ambulancia.",
                    "**Quédate hasta que llegue la policía** y cuenta exactamente lo que ha pasado, sin adornar ni minimizar.",
                    "**Pide los datos de los testigos**: son tu mejor defensa si el agresor te denuncia.",
                    "**Si usaste la fuerza**, tienes derecho a no declarar sin un abogado. Úsalo si te detienen o te citan como investigado.",
                    "**Si te hiciste daño**, ve a urgencias y pide el parte de lesiones.",
                    "**No publiques nada** en redes, ni vídeos ni comentarios.",
                    "**Habla con alguien** en los días siguientes. Es normal temblar, no dormir bien o repasarlo mil veces.",
                ]),
                .tip("Escribe en la Bitácora lo que pasó esa misma noche: te servirá para declarar y para aprender."),
            ]),
        ])
}
