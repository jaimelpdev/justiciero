import Foundation

extension Scenario {
    static let all: [Scenario] = [
        Scenario(
            id: "tiron", title: "El tirón", icon: "handbag.fill",
            situation: "Son las 23:00. A 20 metros, un chico arranca el bolso a una señora mayor, que cae al suelo. Él sale corriendo hacia una calle oscura.",
            options: [
                ScenarioOption(text: "Corro tras él para recuperar el bolso.", score: 0,
                               feedback: "La persecución te aleja de la víctima, te lleva a un terreno desconocido y puede acabar en un enfrentamiento con alguien que quizá lleva un arma o tiene compinches. Un bolso no vale ese riesgo."),
                ScenarioOption(text: "Atiendo a la señora, llamo al 112 y doy la descripción y la dirección de huida.", score: 2,
                               feedback: "Perfecto. La señora puede tener una fractura de cadera (muy común en caídas de personas mayores). Tú eres su protector ahora, y tu descripción es lo que permitirá a la policía actuar."),
                ScenarioOption(text: "Grabo con el móvil mientras huye.", score: 1,
                               feedback: "Puede aportar algo, pero la señora está en el suelo. Prioriza socorrerla y avisar; luego, si puedes, anota todo lo que recuerdes."),
            ],
            lesson: "Persona antes que objetos. La víctima es tu prioridad."),

        Scenario(
            id: "pelea-bar", title: "Pelea a la salida del bar", icon: "figure.2",
            situation: "Al pasar por una zona de bares ves a tres chicos pegando a otro que está en el suelo. Hay gente mirando y nadie hace nada.",
            options: [
                ScenarioOption(text: "Me meto a separarlos usando lo que he aprendido en clase.", score: 0,
                               feedback: "Tres contra uno ya es grave; tres contra dos, con alcohol de por medio, puede acabar con dos personas en el hospital. Además, en el lío pueden confundirte con un agresor."),
                ScenarioOption(text: "Llamo al 112 desde una distancia segura, señalo a alguien concreto para que busque a la seguridad del bar y grito «¡Policía en camino!».", score: 2,
                               feedback: "Muy bien. Llamar rompe el efecto espectador, implicar a alguien concreto multiplica la ayuda y gritar que viene la policía a menudo hace que los agresores huyan. Si no paran y has reunido aliados, acercaos juntos (Academia › Intervenir). Cuando se vayan, atiende al herido."),
                ScenarioOption(text: "Me voy, no es mi problema.", score: 0,
                               feedback: "Hay una persona en peligro grave y puedes pedir ayuda sin riesgo. No hacerlo puede ser incluso un delito de omisión del deber de socorro."),
            ],
            lesson: "Romper el efecto espectador es un superpoder: alguien tiene que ser el primero en actuar con cabeza."),

        Scenario(
            id: "inconsciente", title: "Persona en el suelo", icon: "person.fill.questionmark",
            situation: "Volviendo a casa a la 1:00 ves a un hombre tumbado en la acera junto a un portal. No se mueve.",
            options: [
                ScenarioOption(text: "Seguro que está borracho. Sigo mi camino.", score: 0,
                               feedback: "Puede ser una parada cardíaca, una hipoglucemia, un golpe en la cabeza o hipotermia. Incluso si está borracho, puede ahogarse con su vómito."),
                ScenarioOption(text: "Miro alrededor para ver si es seguro, le hablo y le toco el hombro. Si no responde, llamo al 112 y compruebo si respira.", score: 2,
                               feedback: "Exacto: PAS. Proteger (¿es seguro?), Avisar, Socorrer. Si no respira con normalidad, RCP. Si respira, posición lateral de seguridad y vigilar."),
                ScenarioOption(text: "Le levanto para sentarle en el portal.", score: 1,
                               feedback: "Tu intención es buena, pero mover a alguien inconsciente puede agravar una lesión de columna y no soluciona el problema. Primero valora y llama."),
            ],
            lesson: "Ante la duda, comprueba y llama. Puede ser la diferencia entre la vida y la muerte."),

        Scenario(
            id: "me-siguen", title: "Alguien te sigue", icon: "figure.walk.motion",
            situation: "Llevas varias calles notando que la misma persona camina detrás de ti. Has cambiado de acera y también lo ha hecho.",
            options: [
                ScenarioOption(text: "Me giro y le encaro: «¿Qué quieres?»", score: 0,
                               feedback: "Confrontar en una calle vacía te expone. Si tiene malas intenciones, le das la iniciativa; si no las tiene, creas un conflicto que no existía."),
                ScenarioOption(text: "Voy hacia una zona con gente o entro en un comercio abierto, llamo a alguien o al 112 y no voy directo a mi casa.", score: 2,
                               feedback: "Perfecto. Testigos, luz y ayuda. Nunca le enseñes dónde vives. Si sigue fuera, llama al 091/092."),
                ScenarioOption(text: "Echo a correr hacia casa.", score: 1,
                               feedback: "Alejarte está bien, pero ir a tu casa le enseña dónde vives, y puedes quedar atrapado en el portal buscando las llaves. Mejor un lugar con gente."),
            ],
            lesson: "Lugares con gente y luz son tu mejor refugio. Tu casa no se revela."),

        Scenario(
            id: "coche", title: "Forzando un coche", icon: "car.fill",
            situation: "A las 3:00, desde tu ventana, ves a dos personas manipulando la puerta de un coche aparcado. Miran a los lados constantemente.",
            options: [
                ScenarioOption(text: "Bajo a la calle para pillarles in fraganti y retenerles.", score: 0,
                               feedback: "La ley lo permitiría en teoría, pero son dos, de noche, y no sabes si llevan herramientas que pueden usarse como arma. Ningún coche vale ese riesgo."),
                ScenarioOption(text: "Llamo al 091/092 desde casa, describo personas y dirección, y sigo observando sin exponerme.", score: 2,
                               feedback: "Lo ideal. Desde tu ventana eres un testigo seguro y valioso. Apunta la hora y cualquier detalle de su huida."),
                ScenarioOption(text: "Grito por la ventana para que se vayan.", score: 1,
                               feedback: "Puede funcionar para que se marchen, pero revela tu posición y probablemente se vayan antes de que llegue la policía. Llama primero."),
            ],
            lesson: "La ventana de tu casa es la mejor torre de vigilancia que existe."),

        Scenario(
            id: "metro", title: "Acoso en el metro", icon: "tram.fill",
            situation: "En un vagón casi vacío, un hombre insiste en hablar con una chica que se nota incómoda. Ella se ha cambiado de asiento y él la ha seguido.",
            options: [
                ScenarioOption(text: "Me acerco a él y le digo que la deje en paz o se las verá conmigo.", score: 0,
                               feedback: "Le retas delante de otros: le obligas a «no quedar mal» y puede escalar. Además, la conversación pasa a ser entre vosotros dos, y la chica sigue en medio."),
                ScenarioOption(text: "Me acerco a ella como si la conociera: «¡Hola! ¿Qué tal? Hace mucho que no te veo», le doy conversación y, si hace falta, bajamos juntos o aviso al personal.", score: 2,
                               feedback: "Una técnica muy eficaz de intervención de testigos: distraer. Rompes la situación sin enfrentarte a nadie y le das a ella una salida. Si la cosa sigue, usa el interfono del vagón o avisa a seguridad."),
                ScenarioOption(text: "No hago nada porque no ha pasado nada grave.", score: 0,
                               feedback: "Intervenir pronto, de forma suave, evita que las situaciones lleguen a ser graves."),
            ],
            lesson: "Las «5 D» de la intervención de testigos: Distraer, Delegar, Documentar, Dirigirse (después a la víctima) y, si es seguro, Directo."),

        Scenario(
            id: "navaja", title: "Atraco con navaja", icon: "exclamationmark.triangle.fill",
            situation: "Un hombre te corta el paso, te enseña una navaja y te pide el móvil y la cartera.",
            options: [
                ScenarioOption(text: "Le desarmo con la técnica que aprendí.", score: 0,
                               feedback: "Hasta los instructores con décadas de experiencia saben que intentar desarmar a alguien con un cuchillo es extremadamente peligroso. Los cortes en un forcejeo son casi seguros."),
                ScenarioOption(text: "Le doy lo que pide sin movimientos bruscos, me fijo en su descripción, y cuando se va llamo al 091 y bloqueo el móvil.", score: 2,
                               feedback: "Es exactamente lo que recomienda la policía. Los objetos se recuperan o se reponen. Tu vida no."),
                ScenarioOption(text: "Salgo corriendo.", score: 1,
                               feedback: "Si hay una vía de escape clara y tienes distancia, huir puede ser válido. Pero si está cerca, un movimiento brusco puede provocar un ataque. Entregar lo que pide suele ser lo más seguro."),
            ],
            lesson: "Nada material vale tu vida. Entrega, observa, denuncia."),

        Scenario(
            id: "puente", title: "Persona en el puente", icon: "figure.stand",
            situation: "De noche ves a una persona sola al otro lado de la barandilla de un puente, mirando al agua. Parece llorar.",
            options: [
                ScenarioOption(text: "Corro hacia ella y la agarro para tirar de ella hacia dentro.", score: 0,
                               feedback: "Un movimiento brusco puede asustarla y provocar la caída, o arrastrarte a ti también."),
                ScenarioOption(text: "Llamo al 112 y, manteniendo distancia, le hablo con calma: me presento, le pregunto su nombre y la escucho sin juzgar.", score: 2,
                               feedback: "Muy bien. Hablar de forma tranquila y escuchar salva vidas. No hace falta tener las palabras perfectas: hace falta estar. Sigue hablando hasta que llegue la ayuda."),
                ScenarioOption(text: "Le grito que no lo haga.", score: 1,
                               feedback: "La intención es buena, pero los gritos generan tensión. Acércate despacio, anunciando lo que haces, y habla en tono bajo."),
            ],
            lesson: "Existe el 024, línea de atención a la conducta suicida, gratuita y 24 h. Ante un peligro inminente, 112."),

        Scenario(
            id: "venganza", title: "«Darle una lección»", icon: "person.3.fill",
            situation: "Unos amigos te proponen ir a «darle una lección» a un tipo que, según dicen, trapichea con droga en el parque del barrio. Saben que entrenas.",
            options: [
                ScenarioOption(text: "Me apunto. Alguien tiene que hacer algo.", score: 0,
                               feedback: "Eso es una agresión planificada en grupo: lesiones, quizá algo peor, y con agravantes. Y es posible que tengáis a la persona equivocada. Habéis pasado de héroes a delincuentes."),
                ScenarioOption(text: "Me niego, intento convencerles de que no lo hagan y, si hay venta de droga, se puede comunicar a la policía local o a través de AlertCops.", score: 2,
                               feedback: "Correcto. Los cuerpos de seguridad investigan este tipo de situaciones. Tu valor está en no participar y en frenar a tus amigos."),
                ScenarioOption(text: "No voy, pero no digo nada.", score: 1,
                               feedback: "No participar está bien, pero quizá puedas evitar que tus amigos se metan en un problema enorme."),
            ],
            lesson: "Un justiciero que castiga es solo otro agresor. Tu código te protege a ti también."),

        Scenario(
            id: "incendio", title: "Humo en el portal", icon: "flame.fill",
            situation: "Al volver a casa ves humo saliendo de la ventana de un primer piso de tu edificio. Oyes gritos.",
            options: [
                ScenarioOption(text: "Subo a buscar a la gente.", score: 0,
                               feedback: "El humo mata antes que el fuego: un par de bocanadas pueden dejarte inconsciente. Sin equipo de respiración, entrar es convertirte en otra víctima."),
                ScenarioOption(text: "Llamo al 112, aviso a los vecinos llamando a los telefonillos y gritando, y me quedo fuera para guiar a los bomberos.", score: 2,
                               feedback: "Perfecto. Los bomberos necesitarán saber qué piso es, si queda gente dentro y por dónde se accede. Tu información les ahorra minutos vitales."),
                ScenarioOption(text: "Cojo un extintor y subo.", score: 1,
                               feedback: "Un extintor puede servir para un conato pequeño y si tienes una salida segura a tu espalda. Con humo saliendo por la ventana y gritos, ya no es un conato: llama y evacúa."),
            ],
            lesson: "En un incendio, tu trabajo es avisar, evacuar y orientar a los bomberos."),

        Scenario(
            id: "suelo-patadas", title: "Patadas en el suelo", icon: "figure.fall",
            situation: "Sales de un portal con un amigo. Un hombre está dando patadas en la cabeza a otro que está tirado en el suelo y ya no se defiende. No ves armas. La calle está vacía. Han llamado al 112 desde una ventana, pero la policía tardará.",
            options: [
                ScenarioOption(text: "Grabo con el móvil para que haya pruebas y espero a la policía.", score: 0,
                               feedback: "Las patadas en la cabeza a alguien indefenso pueden matarle en segundos. Aquí esperar no es neutral: es dejar que pase."),
                ScenarioOption(text: "Nos acercamos los dos gritando «¡PARA! ¡Policía en camino!». Si sigue, mi amigo me cubre mientras lo aparto por detrás y me pongo entre él y la víctima.", score: 2,
                               feedback: "Correcto. Daño grave ahora, algo que podéis cambiar y riesgo asumible: es el caso en el que hay que intervenir. Primero voz y presencia; si no basta, separar sin golpear y cubrir la cabeza de la víctima. Después, posición lateral y vigilar que respire."),
                ScenarioOption(text: "Corro hacia él y le doy un puñetazo para que pare.", score: 1,
                               feedback: "Intervenir es lo correcto, pero empezar golpeando te pone en riesgo legal y físico: puede girarse contra ti o caer y golpearse la cabeza. Sube la escalera desde abajo: voz, interponerte, separar. El golpe, solo si te ataca a ti y no hay otra forma."),
            ],
            lesson: "Cuando hay daño grave ahora mismo y puedes pararlo con un riesgo asumible, se interviene. Siempre desde el escalón más bajo que funcione."),

        Scenario(
            id: "arrastran", title: "La arrastran hacia un coche", icon: "car.side.fill",
            situation: "Por la noche ves a un hombre que agarra del brazo a una chica que grita «¡Suéltame, no te conozco!» y la arrastra hacia una furgoneta con la puerta abierta.",
            options: [
                ScenarioOption(text: "Apunto la matrícula, llamo al 112 y les sigo de lejos cuando se vayan.", score: 1,
                               feedback: "Apuntar la matrícula y llamar es imprescindible, pero si la meten en la furgoneta puede ser demasiado tarde. Y nunca persigas un vehículo."),
                ScenarioOption(text: "Grito con toda la fuerza «¡SUÉLTALA! ¡Llamad al 112!», me acerco señalando a la gente para que vengan y me pongo entre ella y la furgoneta.", score: 2,
                               feedback: "Muy bien. Los segundos antes de que la suban al vehículo son los que importan: ruido, testigos y presencia física que corte el camino a la furgoneta. Fíjate en sus manos por si hay arma y, cuando la suelte, lleva a la chica hacia la luz y la gente. Apunta la matrícula."),
                ScenarioOption(text: "Igual es su pareja y es una discusión. No me meto.", score: 0,
                               feedback: "«No te conozco» y alguien arrastrado hacia un vehículo es una señal de alarma clara. Aunque fuera su pareja, nadie puede llevarse a otra persona a la fuerza."),
            ],
            lesson: "Impedir que se lleven a alguien a la fuerza justifica intervenir: ruido, testigos y cortar el paso al vehículo."),

        Scenario(
            id: "cuchillo-tercero", title: "Cuchillo contra otro", icon: "exclamationmark.octagon.fill",
            situation: "En una plaza, un hombre muy alterado amenaza con un cuchillo a otro, que está acorralado contra una pared. Todavía no le ha herido. Hay varias personas mirando a distancia.",
            options: [
                ScenarioOption(text: "Me lanzo a por la mano del cuchillo para desarmarle.", score: 0,
                               feedback: "Desarmar a alguien con un cuchillo es extremadamente peligroso incluso para expertos: en un forcejeo, los cortes son casi seguros, para ti o para la víctima."),
                ScenarioOption(text: "Llamo al 112 diciendo «hay un cuchillo», recluto a la gente para hablarle todos a distancia, cojo una silla o una mochila como barrera y le doy al acorralado una vía para escapar.", score: 2,
                               feedback: "Es lo que de verdad funciona. Con un cuchillo, la distancia y las barreras son tu vida. Muchas voces le distraen, la barrera te protege y abrir una salida a la víctima suele ser más eficaz que enfrentarse. Si ataca de verdad y no hay otra opción, la barrera es tu escudo."),
                ScenarioOption(text: "Me alejo y no hago nada, es demasiado peligroso.", score: 1,
                               feedback: "Protegerte es legítimo y nadie te obliga a arriesgar tu vida. Pero sí puedes llamar al 112 indicando que hay un arma, mantener la distancia y dirigir a la gente: eso también ayuda."),
            ],
            lesson: "Con un arma de por medio: distancia, barreras, muchas voces y una salida para la víctima. El cuerpo a cuerpo, solo si una vida depende de ello y no queda otra."),

        Scenario(
            id: "retencion", title: "Lo retienes y se resiste", icon: "hand.raised.slash.fill",
            situation: "Has separado a un agresor que pegaba a una mujer y lo tienes en el suelo con un control. Se revuelve con fuerza, te insulta y dice que te va a matar. La policía aún no ha llegado.",
            options: [
                ScenarioOption(text: "Le pongo la rodilla en la espalda y aprieto hasta que se calme.", score: 0,
                               feedback: "El peso sobre la espalda o el cuello de alguien boca abajo puede matarle por asfixia en pocos minutos. Personas han muerto así en la calle. Además, eso ya no es defensa: puede ser un delito grave."),
                ScenarioOption(text: "Mantengo el control de lado sin cargar peso, le hablo con calma y, si no puedo sujetarle sin hacerle daño, le suelto, me aparto y protejo a la mujer.", score: 2,
                               feedback: "Exacto. Tu objetivo era que dejara de pegarle, y eso ya lo has conseguido. Si retenerle exige hacerle daño, suéltale: tienes su descripción y la policía hará el resto."),
                ScenarioOption(text: "Le doy un par de golpes para que deje de amenazarme.", score: 0,
                               feedback: "Golpear a alguien que ya está controlado en el suelo es agresión, aunque te amenace. Es lo que convierte al que ayudó en el denunciado."),
            ],
            lesson: "Retener nunca vale una vida. Sin peso en el pecho ni en el cuello, de lado en cuanto se calme, y si no puedes sin hacer daño, suelta."),

        Scenario(
            id: "huye", title: "El agresor huye", icon: "figure.run",
            situation: "Has gritado y te has interpuesto, y el hombre que estaba golpeando a un chaval sale corriendo. El chaval sangra por la nariz y está mareado.",
            options: [
                ScenarioOption(text: "Le persigo para que no se escape.", score: 0,
                               feedback: "La agresión ya ha terminado: tu intervención ha funcionado. Perseguirle te aleja de la víctima, te lleva a un terreno que no conoces y convierte el siguiente encuentro en una pelea en la que la ley ya no te respalda igual."),
                ScenarioOption(text: "Me quedo con el chaval, le siento, le tapo la nariz inclinándole hacia delante, vigilo si está desorientado y doy la descripción del agresor al 112.", score: 2,
                               feedback: "Perfecto. Has ganado: la agresión ha parado. Ahora toca primeros auxilios (si hay golpe en la cabeza y está mareado, que le vea un médico) y ser el mejor testigo posible."),
                ScenarioOption(text: "Le grabo mientras huye y lo subo a redes para que lo identifiquen.", score: 1,
                               feedback: "La grabación puede servir a la policía, pero subirla a redes puede perjudicar la investigación y meterte en problemas. Entrégala a la policía y céntrate en el herido."),
            ],
            lesson: "Cuando el agresor huye, has ganado. Atiende a la víctima y sé un testigo excelente."),
    ]
}

extension CodeRule {
    static let all: [CodeRule] = [
        CodeRule(number: 1, title: "Tu vida primero", text: "Un héroe herido no salva a nadie. Si la escena no es segura, no entras."),
        CodeRule(number: 2, title: "El 112 siempre", text: "Antes de actuar o mientras actúas: con el altavoz o pidiéndoselo a otra persona. Aunque tarden, cada minuto que ganas cuenta."),
        CodeRule(number: 3, title: "Intervén solo cuando hace falta", text: "Una persona en peligro grave ahora, algo que puedes cambiar y un riesgo asumible. Para todo lo demás, sé un testigo excelente."),
        CodeRule(number: 4, title: "Nunca armas", text: "Ni porras, ni navajas, ni nudilleras. Escalan el conflicto y te convierten en delincuente."),
        CodeRule(number: 5, title: "Nunca persigas", text: "Quien huye ya no es una amenaza inmediata. Tu persecución sí puede crear una."),
        CodeRule(number: 6, title: "No eres la policía", text: "No identificas, no registras, no interrogas, no castigas. Respeta su trabajo y colabora."),
        CodeRule(number: 7, title: "Proporcionalidad", text: "Solo la fuerza mínima, solo para protegerte o proteger a otro, y solo mientras dure la agresión."),
        CodeRule(number: 8, title: "Ayudar antes que castigar", text: "El héroe real socorre, acompaña y previene. El castigo es cosa de los jueces."),
        CodeRule(number: 9, title: "Nunca solo, siempre localizable", text: "Alguien de confianza sabe siempre dónde estás y cuándo vuelves."),
        CodeRule(number: 10, title: "Sin ego, sin venganza, sin redes", text: "No buscas reconocimiento ni likes. No publicas caras ni incidentes."),
        CodeRule(number: 11, title: "Cara descubierta", text: "La gente confía en quien puede ver. Si llevas uniforme, que sea el oficial de tu organización."),
        CodeRule(number: 12, title: "Entrena siempre", text: "La preparación es un compromiso de por vida: cuerpo, técnica, ley y primeros auxilios."),
        CodeRule(number: 13, title: "Dignidad para todos", text: "También para quien se ha equivocado. Tratar bien a todo el mundo es lo que te separa de los villanos."),
    ]
}

extension GearItem {
    static let all: [GearItem] = [
        GearItem(name: "Móvil cargado + batería externa", icon: "iphone", status: .recomendado,
                 why: "Tu herramienta más poderosa: llamar al 112, compartir ubicación, AlertCops, linterna."),
        GearItem(name: "Linterna potente", icon: "flashlight.on.fill", status: .recomendado,
                 why: "Iluminar un portal, buscar algo caído, hacer señales. Mejor pequeña, con 300+ lúmenes."),
        GearItem(name: "Silbato", icon: "speaker.wave.3.fill", status: .recomendado,
                 why: "Se oye mucho más lejos que tu voz y no se cansa. Para pedir ayuda o alertar."),
        GearItem(name: "Botiquín de bolsillo", icon: "cross.case.fill", status: .recomendado,
                 why: "Guantes de nitrilo, gasas, venda de compresión, manta térmica, mascarilla de RCP y tiritas."),
        GearItem(name: "Chaleco o bandas reflectantes", icon: "figure.walk", status: .recomendado,
                 why: "Que los coches te vean de noche. El negro mate queda bien en el cine; en la carretera es peligroso."),
        GearItem(name: "Calzado cómodo y con agarre", icon: "shoeprints.fill", status: .recomendado,
                 why: "Caminar muchos kilómetros, correr si hace falta y no resbalar."),
        GearItem(name: "Ropa por capas", icon: "tshirt.fill", status: .recomendado,
                 why: "Por la noche la temperatura cae. Una capa extra también sirve para abrigar a alguien en shock."),
        GearItem(name: "Libreta y bolígrafo", icon: "pencil.and.list.clipboard", status: .recomendado,
                 why: "Para anotar descripciones, matrículas y horas cuando el móvil esté ocupado en una llamada."),
        GearItem(name: "Agua y algo de comer", icon: "waterbottle.fill", status: .recomendado,
                 why: "Para ti o para alguien con una bajada de azúcar."),
        GearItem(name: "DNI y tarjeta sanitaria", icon: "person.text.rectangle.fill", status: .recomendado,
                 why: "Obligatorio identificarte si un agente te lo pide, y útil si eres tú quien necesita ayuda."),
        GearItem(name: "Spray de defensa (pimienta)", icon: "aqi.medium", status: .condicionado,
                 why: "Se vende legalmente a mayores de edad en España si es un modelo autorizado, pero solo puede usarse en legítima defensa y de forma proporcional. Puede afectarte a ti con el viento y no frena a todo el mundo. No es necesario para este programa."),
        GearItem(name: "Cámara corporal", icon: "video.fill", status: .condicionado,
                 why: "Grabar para entregar a la policía puede ser útil, pero hay límites legales en cuanto a datos personales y difusión. Nunca publiques las imágenes."),
        GearItem(name: "Pasamontañas o máscara", icon: "theatermasks.fill", status: .condicionado,
                 why: "Ocultar tu cara mientras «vigilas» genera alarma, hace que la policía te pare y agrava cualquier problema. Para proteger tu identidad hay formas mejores: lee Academia › Ley y límites › Anonimato."),
        GearItem(name: "Esposas o bridas", icon: "link", status: .prohibido,
                 why: "Usarlas sobre otra persona fuera de los casos legales puede ser detención ilegal, y usarlas mal provoca lesiones. No son para ti."),
        GearItem(name: "Porra o defensa extensible", icon: "xmark.shield.fill", status: .prohibido,
                 why: "Prohibidas para particulares por el Reglamento de Armas."),
        GearItem(name: "Nudilleras / puño americano", icon: "hand.raised.slash.fill", status: .prohibido,
                 why: "Prohibidas para particulares por el Reglamento de Armas."),
        GearItem(name: "Navajas, cuchillos y armas blancas", icon: "scissors", status: .prohibido,
                 why: "Llevarlas para «defenderte» puede ser sancionado y convierte cualquier incidente en algo potencialmente mortal."),
        GearItem(name: "Táser o arma eléctrica", icon: "bolt.fill", status: .prohibido,
                 why: "Prohibidas para particulares en España."),
        GearItem(name: "Uniformes o placas que imiten a la policía", icon: "star.circle.fill", status: .prohibido,
                 why: "Puede constituir delito de usurpación de funciones o uso indebido de uniforme."),
    ]
}
