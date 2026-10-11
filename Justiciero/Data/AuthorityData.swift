import Foundation

/// Caminos reales para trabajar con la autoridad y frenar la delincuencia sin oposición.
enum Authority {
    static let intro = "Batman tenía al comisario Gordon. En la vida real, la confianza de la policía no se pide: se gana entrando en los equipos que ya trabajan con ella. Estos son tres caminos sin oposición. Elige uno como principal y el plan diario te irá marcando sus pasos."

    static let warning = "Ningún cuerpo de policía puede autorizar a un particular a intervenir por su cuenta. Cualquier pelea, «detención» mal hecha o denuncia te cierra estos caminos: sin antecedentes no hay uniforme."

    static let routes: [AuthorityRoute] = [proteccion, vigilante, ciber]

    static let proteccion = AuthorityRoute(
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
            ProgramTask("r-pc-0", 1, .habilidad, "Audita tu huella en internet",
                        "Antes de ponerte el uniforme, haz la lección Academia › Ciber-Batman › Protege tu identidad: que nadie pueda encontrar dónde vives buscando tu nombre."),
            ProgramTask("r-pc-1", 1, .comunidad, "Localiza tu agrupación",
                        "Busca «Protección Civil» + tu municipio, o pregunta en el ayuntamiento o en la Policía Local. Apunta teléfono, correo y cuándo hacen las reuniones o la formación."),
            ProgramTask("r-pc-2", 2, .ley, "Pide tus certificados",
                        "Certificado de antecedentes penales y de delitos de naturaleza sexual. Se piden gratis en la sede electrónica del Ministerio de Justicia (enlace abajo) con Cl@ve o certificado digital."),
            ProgramTask("r-pc-3", 3, .comunidad, "Solicitud y entrevista",
                        "Presenta la solicitud de ingreso. En la entrevista cuenta tu formación en primeros auxilios del programa y tu perfil técnico: las agrupaciones siempre necesitan gente de comunicaciones e informática."),
            ProgramTask("r-pc-4", 6, .habilidad, "Completa el curso básico",
                        "Primeros auxilios, transmisiones por radio, organización de emergencias. Ve a todas las sesiones: es tu primera impresión."),
            ProgramTask("r-pc-5", 8, .comunidad, "Primer servicio preventivo",
                        "Fiestas, una carrera popular, un concierto... Empieza acompañando a voluntarios veteranos y escucha más de lo que hablas."),
            ProgramTask("r-pc-6", 10, .comunidad, "Primer servicio nocturno",
                        "Tu primera noche protegiendo tu ciudad con uniforme y respaldo. Usa «Salida segura» para volver a casa."),
            ProgramTask("r-pc-7", 12, .habilidad, "Ofrece tu perfil técnico",
                        "Propón ayudar con comunicaciones, la web o la ciberseguridad de la agrupación. Así pasas de voluntario a persona clave."),
            ProgramTask("r-pc-8", 14, .comunidad, "Preséntate a la policía de proximidad",
                        "Acude a tu comisaría y pregunta por el Delegado de Participación Ciudadana, o ve a las reuniones de seguridad de tu asociación vecinal. Preséntate como voluntario: así es como se gana la confianza de la autoridad."),
        ],
        links: [
            RouteLink(title: "Certificado de antecedentes penales (Ministerio de Justicia)", url: "https://sede.mjusticia.gob.es/es/tramites/certificado-antecedentes"),
        ])

    static let vigilante = AuthorityRoute(
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
            ProgramTask("r-vs-0", 1, .habilidad, "Audita tu huella en internet",
                        "Antes de trabajar de cara al público, haz la lección Academia › Ciber-Batman › Protege tu identidad: que nadie pueda encontrar dónde vives buscando tu nombre."),
            ProgramTask("r-vs-1", 1, .habilidad, "Elige un centro de formación homologado",
                        "Compara precio, horario (presencial u online), porcentaje de aprobados y si te preparan las pruebas físicas. Pide referencias."),
            ProgramTask("r-vs-2", 2, .fisico, "Haz un test de las pruebas físicas",
                        "Pregunta en el centro qué pruebas físicas piden y haz un simulacro. Apunta tus marcas en tu test físico de la app y entrena lo que te falte."),
            ProgramTask("r-vs-3", 4, .habilidad, "Completa el curso",
                        "Derecho básico, seguridad, primeros auxilios, defensa personal. Mucho ya lo has visto en la Academia."),
            ProgramTask("r-vs-4", 5, .ley, "Informe médico y certificados",
                        "Informe de aptitud psicofísica en un centro de reconocimiento autorizado y certificado de antecedentes penales."),
            ProgramTask("r-vs-5", 6, .habilidad, "Preséntate al examen oficial",
                        "Convocatoria de la Policía Nacional (se publica en el BOE). Test teórico y pruebas físicas."),
            ProgramTask("r-vs-6", 8, .ley, "Solicita tu TIP",
                        "Con el examen aprobado, solicita la Tarjeta de Identidad Profesional. Ya eres vigilante de seguridad."),
            ProgramTask("r-vs-7", 10, .comunidad, "Tu primer puesto",
                        "Empresas de seguridad privada. Con tu perfil informático, pregunta por puestos en centros de control y vigilancia tecnológica."),
        ],
        links: [
            RouteLink(title: "Policía Nacional (seguridad privada y convocatorias)", url: "https://www.policia.es/"),
        ])

    static let ciber = AuthorityRoute(
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
            ProgramTask("r-cb-1", 1, .ley, "Completa el módulo Ciber-Batman",
                        "Academia › Ciber-Batman: estafas, ayuda a víctimas, OSINT legal, peritaje y las líneas rojas que nunca se cruzan."),
            ProgramTask("r-cb-0", 2, .habilidad, "Audita tu propia huella",
                        "Haz contigo mismo el OSINT de la lección «Protege tu identidad» y borra lo que revele dónde vives. Primero protégete tú; luego, a los demás."),
            ProgramTask("r-cb-2", 2, .comunidad, "Sé el informático de confianza de tu familia",
                        "Revisa con tus padres, abuelos o vecinos mayores: doble factor en el correo y el banco, cómo reconocer un SMS falso y qué hacer si les estafan."),
            ProgramTask("r-cb-3", 3, .comunidad, "Da tu primera charla anti-estafas",
                        "30 minutos en tu asociación vecinal, un centro de mayores o una biblioteca. Usa los casos del módulo Ciber-Batman."),
            ProgramTask("r-cb-4", 5, .comunidad, "Hazte cibercooperante del INCIBE",
                        "Programa de voluntarios que dan charlas de seguridad en internet en colegios y asociaciones con materiales del INCIBE. Busca «Cibercooperantes» en incibe.es."),
            ProgramTask("r-cb-5", 7, .habilidad, "Participa en una búsqueda de desaparecidos",
                        "Las competiciones de Trace Labs reúnen voluntarios que buscan información pública sobre personas desaparecidas reales y la entregan a la policía. Antes, repasa la lección de OSINT legal."),
            ProgramTask("r-cb-6", 10, .habilidad, "Fórmate en análisis forense",
                        "Adquisición de evidencias, cadena de custodia, informes periciales. Es lo que convierte tu conocimiento en pruebas válidas en un juicio."),
            ProgramTask("r-cb-7", 12, .comunidad, "Da el salto profesional",
                        "Envía tu currículum a empresas de respuesta a incidentes, análisis forense e inteligencia de amenazas, o a despachos de peritaje informático. Infórmate en tu colegio profesional sobre las listas de peritos."),
        ],
        links: [
            RouteLink(title: "INCIBE (línea de ayuda 017 y Cibercooperantes)", url: "https://www.incibe.es/"),
            RouteLink(title: "Trace Labs (búsqueda de desaparecidos con OSINT)", url: "https://www.tracelabs.org/"),
        ])
}
