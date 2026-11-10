import Foundation

enum Exercises {
    static let jumpingJacks = Exercise(id: "jacks", name: "Jumping jacks", icon: "figure.mixed.cardio",
        howTo: "Salta abriendo piernas y brazos a la vez, y vuelve a cerrar. Ritmo constante.",
        easier: "Sin saltar: abre una pierna cada vez mientras subes los brazos.")
    static let squats = Exercise(id: "squat", name: "Sentadillas", icon: "figure.strengthtraining.functional",
        howTo: "Pies al ancho de hombros. Baja como si te sentaras en una silla, espalda recta, rodillas en la dirección de los pies. Sube empujando con los talones.",
        easier: "Siéntate y levántate de una silla de verdad.")
    static let pushups = Exercise(id: "pushup", name: "Flexiones", icon: "figure.strengthtraining.traditional",
        howTo: "Manos algo más anchas que los hombros, cuerpo en línea recta de cabeza a talones. Baja el pecho casi al suelo y empuja. Codos a unos 45°, no abiertos en cruz.",
        easier: "Apoya las rodillas, o hazlas con las manos en una mesa o pared.")
    static let glutebridge = Exercise(id: "bridge", name: "Puente de glúteo", icon: "figure.cooldown",
        howTo: "Tumbado boca arriba, rodillas dobladas. Eleva la cadera apretando glúteos hasta formar una línea recta hombros-rodillas. Aguanta 1 s arriba.",
        easier: "Reduce el recorrido.")
    static let plank = Exercise(id: "plank", name: "Plancha", icon: "figure.core.training",
        howTo: "Apoyado en antebrazos y puntas de los pies. Cuerpo recto, abdomen y glúteos apretados. No dejes caer la cadera.",
        easier: "Apoya las rodillas.")
    static let sidePlank = Exercise(id: "sideplank", name: "Plancha lateral", icon: "figure.core.training",
        howTo: "De lado, apoyado en un antebrazo, cadera arriba y cuerpo recto. El tiempo indicado es por cada lado.",
        easier: "Apoya la rodilla de abajo.")
    static let superman = Exercise(id: "superman", name: "Superman", icon: "figure.pilates",
        howTo: "Boca abajo, eleva a la vez brazos estirados y piernas, aguanta 2 s y baja despacio. Fortalece la espalda.",
        easier: "Eleva solo brazo y pierna contrarios alternando.")
    static let climbers = Exercise(id: "climbers", name: "Mountain climbers", icon: "figure.run",
        howTo: "En posición de flexión, lleva las rodillas al pecho alternando, rápido pero sin perder la línea del cuerpo.",
        easier: "Hazlo despacio, paso a paso.")
    static let lunges = Exercise(id: "lunge", name: "Zancadas", icon: "figure.walk",
        howTo: "Da un paso largo y baja hasta que ambas rodillas formen 90°. La rodilla trasera casi roza el suelo. Alterna piernas.",
        easier: "Paso más corto y bajada parcial, apoyándote en una pared.")
    static let chairDips = Exercise(id: "dips", name: "Fondos en silla", icon: "figure.strengthtraining.traditional",
        howTo: "Manos en el borde de una silla estable (contra la pared), piernas delante. Baja doblando codos hasta 90° y sube.",
        easier: "Piernas dobladas y recorrido corto.")
    static let burpees = Exercise(id: "burpee", name: "Burpees", icon: "figure.cross.training",
        howTo: "De pie, agáchate, manos al suelo, salta atrás a plancha, vuelve a recoger y salta arriba. Ritmo controlado.",
        easier: "Sin flexión y sin salto: da los pasos atrás y adelante.")
    static let invertedRow = Exercise(id: "row", name: "Remo invertido", icon: "figure.strengthtraining.traditional",
        howTo: "Bajo una mesa MUY robusta (o con barra baja en un parque), agarra el borde y tira del pecho hacia él con el cuerpo recto. Comprueba antes que la mesa no vuelque.",
        easier: "Con toalla en una puerta cerrada: tira de ti hacia la puerta inclinado hacia atrás.")
    static let bulgarian = Exercise(id: "bulgarian", name: "Sentadilla búlgara", icon: "figure.strengthtraining.functional",
        howTo: "Pie trasero apoyado en una silla o sofá, baja con la pierna delantera. Repeticiones por pierna.",
        easier: "Zancada estática con ambos pies en el suelo.")
    static let hollow = Exercise(id: "hollow", name: "Hollow hold", icon: "figure.core.training",
        howTo: "Boca arriba, zona lumbar pegada al suelo, eleva hombros y piernas estiradas formando una «banana». Aguanta.",
        easier: "Rodillas dobladas o brazos a los lados.")
    static let shadowBoxing = Exercise(id: "shadow", name: "Sombra (boxeo)", icon: "figure.boxing",
        howTo: "Guardia alta, barbilla abajo. Golpes rectos y desplazamientos ligeros. Respira al golpear. Usa la técnica que hayas aprendido en el Dojo.",
        easier: "Ritmo suave, solo desplazamientos y guardia.")
    static let sprawl = Exercise(id: "sprawl", name: "Sprawls", icon: "figure.cross.training",
        howTo: "Como un burpee rápido sin salto: echa las piernas atrás y la cadera al suelo para «defender un derribo», y vuelve a guardia.",
        easier: "Pasos atrás en vez de salto.")
    static let breakfallBack = Exercise(id: "ukemi-back", name: "Caída hacia atrás", icon: "figure.fall",
        howTo: "SOBRE COLCHONETA O COLCHÓN. Desde sentado: barbilla al pecho, ruedas hacia atrás y golpeas el suelo con ambos brazos estirados a 45° para repartir el impacto. Cuando lo domines, desde cuclillas.",
        easier: "Solo el gesto de barbilla al pecho y rodar suave sobre la espalda.")
    static let breakfallSide = Exercise(id: "ukemi-side", name: "Caída lateral", icon: "figure.fall",
        howTo: "SOBRE COLCHONETA. Desde cuclillas, extiende una pierna cruzando por delante, cae de lado y golpea el suelo con el brazo de ese lado. Barbilla siempre al pecho. Alterna lados.",
        easier: "Desde sentado, solo el balanceo y el golpe de brazo.")
    static let roll = Exercise(id: "roll", name: "Rodada hacia delante", icon: "figure.gymnastics",
        howTo: "SOBRE COLCHONETA. Rodada diagonal por el hombro (no por la cabeza) hasta la cadera contraria y te levantas. Sigue la progresión de la técnica «Rodada hacia delante» del Dojo.",
        easier: "Rodada desde rodillas, muy despacio.")
    static let mobility = Exercise(id: "mobility", name: "Movilidad articular", icon: "figure.flexibility",
        howTo: "Círculos de cuello, hombros, cadera, rodillas y tobillos. 10 en cada sentido, sin forzar.",
        easier: "Sentado en una silla.")
    static let hipStretch = Exercise(id: "hip", name: "Estiramiento de cadera", icon: "figure.flexibility",
        howTo: "Postura de zancada con rodilla trasera en el suelo, empuja la cadera adelante. Tiempo por lado.",
        easier: "Apoya las manos en una silla.")
    static let hamstring = Exercise(id: "hamstring", name: "Estiramiento isquios", icon: "figure.flexibility",
        howTo: "Sentado con piernas estiradas, inclínate hacia delante con la espalda recta. Sin rebotes.",
        easier: "Una pierna cada vez, la otra doblada.")
    static let boxBreathing = Exercise(id: "breath", name: "Respiración cuadrada", icon: "wind",
        howTo: "4 s inspirar por la nariz, 4 s retener, 4 s soltar por la boca, 4 s retener. Repetir.",
        easier: "Usa 3 s en cada fase.")
    static let warmJog = Exercise(id: "jog-warm", name: "Calentamiento caminando/trote", icon: "figure.walk",
        howTo: "Camina rápido o trota muy suave. Deberías poder hablar sin problema.",
        easier: "Solo caminar.")
    static let easyRun = Exercise(id: "jog", name: "Carrera suave", icon: "figure.run",
        howTo: "Ritmo en el que puedas mantener una conversación. Si te ahogas, camina 1 min y vuelve a trotar.",
        easier: "Alterna 1 min trote y 1 min caminando.")
    static let strides = Exercise(id: "strides", name: "Progresivos", icon: "figure.run",
        howTo: "Acelera poco a poco durante 20 s hasta casi tu máxima velocidad y vuelve caminando.",
        easier: "Llega solo al 70 % de tu velocidad.")
    static let balance = Exercise(id: "balance", name: "Equilibrio en línea", icon: "figure.stand",
        howTo: "Camina sobre una línea del suelo o un bordillo BAJO (menos de 20 cm), mirando al frente. Ida y vuelta.",
        easier: "Sobre una línea pintada en el suelo.")
    static let precision = Exercise(id: "precision", name: "Saltos de precisión", icon: "figure.jumprope",
        howTo: "A nivel del suelo: salta con los pies juntos de una marca a otra (1–1,5 m) y aterriza suave y en silencio, sobre la parte delantera del pie, flexionando rodillas.",
        easier: "Distancia más corta.")
    static let stepUps = Exercise(id: "stepup", name: "Subidas a banco", icon: "figure.step.training",
        howTo: "Sube a un banco o escalón estable con una pierna, baja controlado. Repeticiones por pierna.",
        easier: "Escalón más bajo.")
    static let quadruped = Exercise(id: "quad", name: "Cuadrupedia", icon: "figure.play",
        howTo: "A cuatro patas con rodillas a 2 cm del suelo, avanza moviendo mano y pie contrarios a la vez.",
        easier: "Rodillas apoyadas.")

    // MARK: Progresiones del plan personalizado

    static let inclinePushup = Exercise(id: "pushup-incline", name: "Flexiones inclinadas", icon: "figure.strengthtraining.traditional",
        howTo: "Manos en el borde de una mesa estable o en la encimera, cuerpo recto. Baja el pecho hasta el borde y empuja. Cuanto más baja la superficie, más difícil.",
        easier: "Hazlas contra la pared.")
    static let kneePushup = Exercise(id: "pushup-knee", name: "Flexiones de rodillas", icon: "figure.strengthtraining.traditional",
        howTo: "Rodillas en el suelo y línea recta de rodillas a cabeza. Baja el pecho casi al suelo con los codos a 45° y empuja.",
        easier: "Flexiones inclinadas en una mesa.")
    static let declinePushup = Exercise(id: "pushup-decline", name: "Flexiones declinadas", icon: "figure.strengthtraining.traditional",
        howTo: "Pies sobre una silla o el sofá y manos en el suelo. Cuerpo recto, baja controlado y empuja. Trabaja más hombro y pecho alto.",
        easier: "Flexiones normales.")
    static let diamondPushup = Exercise(id: "pushup-diamond", name: "Flexiones diamante", icon: "figure.strengthtraining.traditional",
        howTo: "Manos juntas bajo el pecho formando un rombo con pulgares e índices. Codos pegados al cuerpo. Mucho tríceps.",
        easier: "Manos al ancho de hombros con codos pegados.")
    static let archerPushup = Exercise(id: "pushup-archer", name: "Flexiones arquero", icon: "figure.strengthtraining.traditional",
        howTo: "Manos muy abiertas. Baja hacia un lado doblando ese brazo mientras el otro se queda casi estirado. Alterna lados. Paso previo a la flexión a una mano.",
        easier: "Flexiones diamante.")
    static let pike = Exercise(id: "pike", name: "Flexiones en pica", icon: "figure.strengthtraining.functional",
        howTo: "Cadera alta formando una V invertida. Dobla los codos y lleva la cabeza hacia el suelo, por delante de las manos. Fortalece los hombros.",
        easier: "Pies más lejos de las manos y recorrido corto.")
    static let pikeElevated = Exercise(id: "pike-elevated", name: "Pica con pies elevados", icon: "figure.strengthtraining.functional",
        howTo: "Como la flexión en pica pero con los pies en una silla, para cargar más peso en los hombros. Baja la cabeza despacio.",
        easier: "Flexiones en pica en el suelo.")
    static let towelRow = Exercise(id: "row-towel", name: "Remo con toalla en puerta", icon: "figure.strengthtraining.traditional",
        howTo: "Pasa una toalla por el pomo de ambos lados de una puerta CERRADA y con pestillo. Agarra los extremos, inclínate hacia atrás con el cuerpo recto y tira de ti hacia la puerta juntando las escápulas.",
        easier: "Inclínate menos.")
    static let rowFeetUp = Exercise(id: "row-feet", name: "Remo invertido con pies elevados", icon: "figure.strengthtraining.traditional",
        howTo: "Como el remo invertido bajo una mesa MUY robusta, pero con los pies en una silla para que el cuerpo quede horizontal. Pecho a la mesa.",
        easier: "Remo invertido con los pies en el suelo.")
    static let towelRowOneArm = Exercise(id: "row-towel-one", name: "Remo a una mano con toalla", icon: "figure.strengthtraining.traditional",
        howTo: "Como el remo con toalla en la puerta pero agarrando con una sola mano. Sin girar el tronco. Repeticiones por brazo.",
        easier: "Remo con toalla a dos manos.")
    static let deadHang = Exercise(id: "hang", name: "Colgarse de la barra", icon: "figure.climbing",
        howTo: "Cuélgate de la barra con los brazos estirados y los hombros activos (aléjalos de las orejas). Fortalece el agarre y prepara las dominadas. Comprueba antes que la barra está bien sujeta.",
        easier: "Con los pies apoyados en una silla para quitar peso.")
    static let negativePullup = Exercise(id: "pullup-negative", name: "Dominadas negativas", icon: "figure.climbing",
        howTo: "Sube con ayuda de una silla hasta tener la barbilla sobre la barra y baja lo más despacio posible (3–5 s) hasta estirar los brazos.",
        easier: "Colgarse de la barra.")
    static let assistedPullup = Exercise(id: "pullup-assisted", name: "Dominadas asistidas", icon: "figure.climbing",
        howTo: "Un pie apoyado en una silla detrás de ti: tira con los brazos y usa la pierna solo lo justo para completar la subida.",
        easier: "Dominadas negativas.")
    static let pullup = Exercise(id: "pullup", name: "Dominadas", icon: "figure.climbing",
        howTo: "Agarre algo más ancho que los hombros. Tira hasta pasar la barbilla por encima de la barra, sin balancearte, y baja controlado hasta estirar los brazos.",
        easier: "Dominadas asistidas con una silla.")
    static let sitToStand = Exercise(id: "sit-stand", name: "Sentarse y levantarse", icon: "figure.strengthtraining.functional",
        howTo: "De pie delante de una silla, siéntate despacio y levántate sin ayudarte con las manos. Pies firmes y rodillas hacia fuera.",
        easier: "Ayúdate con las manos en los muslos.")
    static let reverseLunge = Exercise(id: "lunge-back", name: "Zancada hacia atrás", icon: "figure.walk",
        howTo: "Da un paso largo hacia atrás y baja hasta que las dos rodillas formen 90°. Vuelve empujando con el talón delantero. Es más suave para las rodillas que la zancada hacia delante.",
        easier: "Apóyate en una pared y baja menos.")
    static let jumpSquat = Exercise(id: "squat-jump", name: "Sentadilla con salto", icon: "figure.jumprope",
        howTo: "Sentadilla normal y salta hacia arriba con fuerza. Aterriza suave sobre la parte delantera del pie y baja directamente a la siguiente.",
        easier: "Sentadilla rápida subiendo de puntillas, sin saltar.")
    static let pauseSquat = Exercise(id: "squat-pause", name: "Sentadilla con pausa", icon: "figure.strengthtraining.functional",
        howTo: "Baja en 3 segundos, aguanta 2 segundos abajo sin rebotar y sube con fuerza. Sin impacto y muy exigente.",
        easier: "Pausa de 1 segundo.")
    static let pistolBox = Exercise(id: "pistol-box", name: "Sentadilla a una pierna a banco", icon: "figure.strengthtraining.functional",
        howTo: "De pie sobre una pierna delante de una silla, la otra estirada al frente. Siéntate despacio con una pierna y levántate con ella. Repeticiones por pierna.",
        easier: "Sentadilla búlgara.")
    static let singleLegBridge = Exercise(id: "bridge-single", name: "Puente a una pierna", icon: "figure.cooldown",
        howTo: "Como el puente de glúteo pero con una pierna estirada en el aire. Sube la cadera sin que se incline. Repeticiones por pierna.",
        easier: "Puente con las dos piernas.")
    static let singleLegRDL = Exercise(id: "rdl-single", name: "Peso muerto a una pierna", icon: "figure.strengthtraining.functional",
        howTo: "De pie sobre una pierna, inclina el tronco hacia delante con la espalda recta mientras la otra pierna sube atrás. Baja hasta notar estiramiento detrás del muslo y sube apretando glúteo.",
        easier: "Con la punta del pie de atrás tocando el suelo.")
    static let deadBug = Exercise(id: "deadbug", name: "Dead bug", icon: "figure.core.training",
        howTo: "Boca arriba, brazos al techo y rodillas a 90°. Estira a la vez un brazo y la pierna contraria sin despegar la zona lumbar del suelo. Alterna. Repeticiones por lado.",
        easier: "Mueve solo las piernas.")
    static let birdDog = Exercise(id: "birddog", name: "Bird dog", icon: "figure.pilates",
        howTo: "A cuatro patas, estira a la vez un brazo y la pierna contraria hasta formar una línea. Aguanta 2 s sin girar la cadera. Repeticiones por lado.",
        easier: "Estira solo la pierna.")
    static let legRaises = Exercise(id: "legraise", name: "Elevaciones de piernas", icon: "figure.core.training",
        howTo: "Boca arriba con las manos bajo los glúteos. Sube las piernas estiradas hasta la vertical y bájalas despacio sin tocar el suelo ni arquear la espalda.",
        easier: "Con las rodillas dobladas.")
    static let plankTaps = Exercise(id: "plank-taps", name: "Plancha con toques de hombro", icon: "figure.core.training",
        howTo: "En plancha alta (brazos estirados), toca el hombro contrario con una mano y alterna sin mover la cadera. Pies algo separados.",
        easier: "Con las rodillas apoyadas.")
    static let march = Exercise(id: "march", name: "Marcha con rodillas altas", icon: "figure.walk",
        howTo: "Sin saltar: marcha en el sitio subiendo las rodillas a la altura de la cadera y moviendo los brazos rápido. Cero impacto, mucho pulso.",
        easier: "Ritmo más lento.")
    static let skaters = Exercise(id: "skaters", name: "Saltos de patinador", icon: "figure.skating",
        howTo: "Salta lateralmente de un pie al otro, aterrizando suave y llevando la pierna libre por detrás. Como un patinador de velocidad.",
        easier: "Paso lateral sin salto.")
    static let kneeStrikes = Exercise(id: "knees", name: "Rodillazos alternos", icon: "figure.kickboxing",
        howTo: "Guardia alta. Sube la rodilla con fuerza hacia delante mientras bajas las manos como si agarraras una cabeza imaginaria. Alterna piernas, al aire o a un cojín sujeto contra la pared.",
        easier: "Ritmo lento, sin bajar las manos.")
    static let slips = Exercise(id: "slips", name: "Esquivas y desplazamientos", icon: "figure.boxing",
        howTo: "Guardia alta y rodillas flexionadas. Esquiva doblando un poco las rodillas y moviendo la cabeza a un lado y a otro, y desplázate en ángulo con pasos cortos. Nunca cruces los pies.",
        easier: "Solo desplazamientos.")
    static let briskWalk = Exercise(id: "walk", name: "Caminata rápida", icon: "figure.walk",
        howTo: "Camina rápido moviendo los brazos, a un ritmo en el que te cueste un poco hablar. Por zonas iluminadas si es tarde.",
        easier: "Ritmo cómodo.")

    /// Todos los ejercicios de la biblioteca (el entrenador con IA solo puede elegir entre estos).
    static let library: [Exercise] = [
        jumpingJacks,
        squats,
        pushups,
        glutebridge,
        plank,
        sidePlank,
        superman,
        climbers,
        lunges,
        chairDips,
        burpees,
        invertedRow,
        bulgarian,
        hollow,
        shadowBoxing,
        sprawl,
        breakfallBack,
        breakfallSide,
        roll,
        mobility,
        hipStretch,
        hamstring,
        boxBreathing,
        warmJog,
        easyRun,
        strides,
        balance,
        precision,
        stepUps,
        quadruped,
        inclinePushup,
        kneePushup,
        declinePushup,
        diamondPushup,
        archerPushup,
        pike,
        pikeElevated,
        towelRow,
        rowFeetUp,
        towelRowOneArm,
        deadHang,
        negativePullup,
        assistedPullup,
        pullup,
        sitToStand,
        reverseLunge,
        jumpSquat,
        pauseSquat,
        pistolBox,
        singleLegBridge,
        singleLegRDL,
        deadBug,
        birdDog,
        legRaises,
        plankTaps,
        march,
        skaters,
        kneeStrikes,
        slips,
        briskWalk,
    ]
}

extension Workout {
    static let all: [Workout] = [cuevaA, cuevaB, movilidad, caidas, forjaFuerza, forjaCombate, carrera, agilidad, guardian]

    static let cuevaA = Workout(
        id: "cueva-a", name: "Cueva A · Fuerza base", focus: "Fuerza general con tu peso",
        place: "Casa", minPhase: 0, minutes: 25, notes: "Si es tu primera vez, haz la versión fácil de cada ejercicio. Termina la sesión con sensación de que podías más.",
        blocks: [
            WorkoutBlock(exercise: Exercises.jumpingJacks, sets: 2, reps: nil, seconds: 40, rest: 20),
            WorkoutBlock(exercise: Exercises.squats, sets: 3, reps: "12", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.pushups, sets: 3, reps: "máx. con buena técnica", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.glutebridge, sets: 3, reps: "15", seconds: nil, rest: 45),
            WorkoutBlock(exercise: Exercises.plank, sets: 3, reps: nil, seconds: 30, rest: 45),
            WorkoutBlock(exercise: Exercises.superman, sets: 2, reps: "12", seconds: nil, rest: 45),
        ])

    static let cuevaB = Workout(
        id: "cueva-b", name: "Cueva B · Resistencia", focus: "Cardio y resistencia muscular",
        place: "Casa", minPhase: 0, minutes: 25, notes: nil,
        blocks: [
            WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 120, rest: 10),
            WorkoutBlock(exercise: Exercises.climbers, sets: 3, reps: nil, seconds: 30, rest: 30),
            WorkoutBlock(exercise: Exercises.lunges, sets: 3, reps: "10/pierna", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.chairDips, sets: 3, reps: "8", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.burpees, sets: 3, reps: "6", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.sidePlank, sets: 2, reps: nil, seconds: 20, rest: 30),
        ])

    static let movilidad = Workout(
        id: "movilidad", name: "Movilidad y calma", focus: "Recuperación, flexibilidad y control del estrés",
        place: "Casa", minPhase: 0, minutes: 15, notes: "Perfecta para los días de descanso o antes de dormir.",
        blocks: [
            WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 180, rest: 10),
            WorkoutBlock(exercise: Exercises.hipStretch, sets: 2, reps: nil, seconds: 40, rest: 10),
            WorkoutBlock(exercise: Exercises.hamstring, sets: 2, reps: nil, seconds: 45, rest: 10),
            WorkoutBlock(exercise: Exercises.boxBreathing, sets: 1, reps: nil, seconds: 300, rest: 0),
        ])

    static let caidas = Workout(
        id: "caidas", name: "Aprender a caer", focus: "Caídas seguras (ukemi)",
        place: "Casa (colchoneta)", minPhase: 1, minutes: 20,
        notes: "Solo sobre superficie blanda: colchoneta gruesa, colchón en el suelo o tatami. Lee antes las técnicas de caídas del Dojo. Si tienes problemas de cuello o espalda, consulta antes con tu médico.",
        blocks: [
            WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 120, rest: 10),
            WorkoutBlock(exercise: Exercises.breakfallBack, sets: 3, reps: "8", seconds: nil, rest: 45),
            WorkoutBlock(exercise: Exercises.breakfallSide, sets: 3, reps: "6/lado", seconds: nil, rest: 45),
            WorkoutBlock(exercise: Exercises.roll, sets: 3, reps: "4", seconds: nil, rest: 60),
        ])

    static let forjaFuerza = Workout(
        id: "forja-fuerza", name: "Forja · Fuerza", focus: "Fuerza relativa y control corporal",
        place: "Casa o parque", minPhase: 1, minutes: 35, notes: nil,
        blocks: [
            WorkoutBlock(exercise: Exercises.jumpingJacks, sets: 2, reps: nil, seconds: 45, rest: 15),
            WorkoutBlock(exercise: Exercises.pushups, sets: 4, reps: "12–15", seconds: nil, rest: 75),
            WorkoutBlock(exercise: Exercises.invertedRow, sets: 4, reps: "8", seconds: nil, rest: 75),
            WorkoutBlock(exercise: Exercises.bulgarian, sets: 3, reps: "10/pierna", seconds: nil, rest: 75),
            WorkoutBlock(exercise: Exercises.chairDips, sets: 3, reps: "12", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.hollow, sets: 3, reps: nil, seconds: 30, rest: 45),
        ])

    static let forjaCombate = Workout(
        id: "forja-combate", name: "Forja · Combate", focus: "Resistencia anaeróbica tipo asalto",
        place: "Casa", minPhase: 1, minutes: 30,
        notes: "Simula la intensidad de un asalto, que es agotadora incluso para gente en forma. Complementa las clases del Dojo.",
        blocks: [
            WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 120, rest: 10),
            WorkoutBlock(exercise: Exercises.shadowBoxing, sets: 5, reps: nil, seconds: 60, rest: 30),
            WorkoutBlock(exercise: Exercises.sprawl, sets: 4, reps: nil, seconds: 30, rest: 30),
            WorkoutBlock(exercise: Exercises.burpees, sets: 3, reps: "10", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.plank, sets: 2, reps: nil, seconds: 60, rest: 30),
            WorkoutBlock(exercise: Exercises.boxBreathing, sets: 1, reps: nil, seconds: 120, rest: 0),
        ])

    static let carrera = Workout(
        id: "carrera", name: "Reconocimiento", focus: "Carrera aeróbica por tu barrio",
        place: "Exterior", minPhase: 2, minutes: 40,
        notes: "De día o por zonas iluminadas. Si es de noche: chaleco reflectante, «Salida segura» activada y ruta conocida. Aprovecha para fijarte en calles y puntos seguros.",
        blocks: [
            WorkoutBlock(exercise: Exercises.warmJog, sets: 1, reps: nil, seconds: 300, rest: 0),
            WorkoutBlock(exercise: Exercises.easyRun, sets: 1, reps: nil, seconds: 1500, rest: 60),
            WorkoutBlock(exercise: Exercises.strides, sets: 5, reps: nil, seconds: 20, rest: 60),
            WorkoutBlock(exercise: Exercises.hamstring, sets: 1, reps: nil, seconds: 60, rest: 0),
        ])

    static let agilidad = Workout(
        id: "agilidad", name: "Agilidad urbana", focus: "Equilibrio, aterrizajes y control (parkour seguro)",
        place: "Parque", minPhase: 2, minutes: 30,
        notes: "Nada de alturas, tejados ni propiedad privada. Esto es control del cuerpo a ras de suelo. Si quieres más, busca un club de parkour con monitores.",
        blocks: [
            WorkoutBlock(exercise: Exercises.mobility, sets: 1, reps: nil, seconds: 120, rest: 10),
            WorkoutBlock(exercise: Exercises.balance, sets: 3, reps: nil, seconds: 60, rest: 30),
            WorkoutBlock(exercise: Exercises.precision, sets: 3, reps: "8", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.stepUps, sets: 3, reps: "12/pierna", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.quadruped, sets: 3, reps: nil, seconds: 30, rest: 45),
        ])

    static let guardian = Workout(
        id: "guardian", name: "Circuito del Guardián", focus: "Preparación física para pruebas de acceso",
        place: "Casa o parque", minPhase: 4, minutes: 45,
        notes: "Inspirado en las pruebas físicas de cuerpos de seguridad y bomberos. Ajusta el volumen a tu nivel.",
        blocks: [
            WorkoutBlock(exercise: Exercises.jumpingJacks, sets: 2, reps: nil, seconds: 60, rest: 15),
            WorkoutBlock(exercise: Exercises.burpees, sets: 4, reps: "12", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.pushups, sets: 4, reps: "20", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.invertedRow, sets: 4, reps: "12", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.bulgarian, sets: 3, reps: "12/pierna", seconds: nil, rest: 60),
            WorkoutBlock(exercise: Exercises.strides, sets: 6, reps: nil, seconds: 20, rest: 45),
            WorkoutBlock(exercise: Exercises.hollow, sets: 3, reps: nil, seconds: 45, rest: 30),
        ])
}
