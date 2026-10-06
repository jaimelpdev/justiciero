# 🌙 Justiciero

App para iOS que convierte la idea de ser un «justiciero nocturno estilo Batman» en un **programa realista de 12 meses**: empiezas en casa y terminas haciendo servicios nocturnos reales con uniforme oficial, en forma, formado y dentro de la ley.

> Batman no existe. Tú sí.

## Qué incluye

| Sección | Contenido |
|---|---|
| **Base** | Rango y XP, racha diaria, fase actual, misiones pendientes, entreno sugerido, consejo del día y accesos rápidos a Salida segura y Emergencia. |
| **Programa** | 6 fases (~70 misiones semana a semana). Cada fase se desbloquea al completar el 80 % de la anterior. |
| **Entreno** | 9 sesiones guiadas con temporizador (series, repeticiones, descansos) o marcadas como hechas sin temporizador, test físico y historial. |
| **Dojo en casa** | Artes marciales sin gimnasio: 7 cinturones (blanco a negro), 27 técnicas paso a paso con errores típicos y variantes opcionales con compañero, clases guiadas por asaltos con un entrenador por voz que canta combinaciones, y examen para cada cinturón. |
| **Academia** | 8 módulos y 29 lecciones, simulador con 10 escenarios reales, Juego de Kim (memoria visual) y el Código del Vigilante. |
| **Sucesos** | Sucesos de tu zona: con «Usar mi ubicación» (o a mano) detecta tu ciudad y tu barrio, y muestra primero las noticias que mencionan tu barrio y después el resto de la ciudad (últimos días) (se marcan las nuevas desde tu última visita), enlaces a fuentes oficiales (AlertCops, Policía Nacional, Guardia Civil, balance de criminalidad) y alerta de Google por correo. En iOS se consulta Google Noticias directamente; en la web, un workflow publica cada hora un resumen para las 68 ciudades más grandes de España (`tools/fetch_sucesos.py`). |
| **Más** | Salida segura (checklist + check-ins con notificaciones + SMS a tu contacto), Emergencias (112 y otros números), Equipamiento legal, Bitácora, Perfil con gráficas de evolución y Rangos. |

### Las 6 fases

0. **La Cueva** (sem. 1–4) · En casa: evaluación física, sueño, ley, primeros auxilios básicos. *Nada de calle.*
1. **La Forja** (sem. 5–12) · Dojo en casa hasta el cinturón blanco, 0 a 5 km, curso presencial de RCP/DEA, aprender a caer.
2. **La Ciudad** (sem. 13–20) · Conocer tu barrio: primero de día, luego al anochecer acompañado. Puntos seguros, AlertCops.
3. **El Detective** (sem. 21–28) · Observación, descripción de personas y vehículos, la llamada perfecta al 112.
4. **El Guardián** (sem. 29–40) · Voluntariado en Protección Civil o Cruz Roja: servicios nocturnos reales.
5. **Caballero de la Noche** (sem. 41+) · Profesionalizarte (policía, bombero, TES, socorrista…) o ser mentor.

## Dos versiones

- **App web (PWA)** en `web/`: se instala desde Safari, es gratis, no caduca y no necesita Mac. Recomendada.
- **App nativa** (SwiftUI) en `Justiciero/`: necesita Mac y Xcode, y con cuenta gratuita de Apple caduca cada 7 días.

Las dos comparten el mismo contenido: la web lo genera a partir de los ficheros Swift con `python3 tools/swift_data_to_js.py` (el CI comprueba que estén sincronizados).

## App web: instalarla en el iPhone

1. Publica la carpeta `web/` (ver abajo) y abre la dirección en **Safari**.
2. Pulsa **Compartir** › **Añadir a pantalla de inicio** › **Añadir**.
3. Ya tienes el icono de Justiciero: abre a pantalla completa y funciona sin conexión.

Tu progreso se guarda en el iPhone. Usa **Más › Exportar copia de seguridad** de vez en cuando por si borras la app.

Limitación: los avisos de check-in de *Salida segura* solo suenan con seguridad si la app está abierta.

### Publicarla en GitHub Pages

El workflow `.github/workflows/web.yml` publica `web/` automáticamente en cada push a `main`. Solo hay que activarlo una vez en **Settings › Pages › Source: GitHub Actions**. La dirección será `https://jaimelpdev.github.io/justiciero/`.

> GitHub Pages es gratis en repositorios **públicos**. En uno privado necesita GitHub Pro.

Para probarla en local: `cd web && python3 -m http.server` y abre `http://localhost:8000`.

## App nativa: instalarla en el iPhone

Necesitas un Mac con **Xcode 16 o superior** (gratis en la App Store) y un iPhone con **iOS 17+**.

1. Clona el repo y abre `Justiciero.xcodeproj`.
2. Selecciona el target **Justiciero** › *Signing & Capabilities* › en *Team* elige tu Apple ID (con una cuenta gratuita basta; añádela en Xcode › Settings › Accounts).
3. Si Xcode se queja del Bundle Identifier, cámbialo por algo único (p. ej. `com.tunombre.justiciero`).
4. Conecta el iPhone por cable, selecciónalo arriba y pulsa ▶︎ (Cmd+R).
5. En el iPhone: Ajustes › General › VPN y gestión de dispositivos › confía en tu certificado de desarrollador. Si te lo pide, activa también el *Modo desarrollador* (Ajustes › Privacidad y seguridad).

> Con una cuenta gratuita de Apple, la app caduca a los 7 días y hay que volver a instalarla desde Xcode. Con la cuenta de desarrollador de pago (99 €/año) dura 1 año y puedes usar TestFlight.

Para probarla sin iPhone, elige cualquier simulador de iPhone en Xcode y pulsa ▶︎.

## Estructura

```
web/            App web (PWA): HTML, CSS, JS, service worker e iconos
tools/          Script que genera web/data.js desde los ficheros Swift
Justiciero/
├── App/        Punto de entrada, pestañas y tema visual
├── Models/     Tipos de datos (fases, tareas, lecciones, escenarios…)
├── Data/       Contenido: programa, entrenos, academia, escenarios, equipo
├── Store/      Progreso del usuario (JSON local en el dispositivo)
└── Views/      Pantallas SwiftUI
```

Sin dependencias: SwiftUI puro en iOS y JavaScript sin frameworks en la web. Los datos se guardan solo en el dispositivo.

## Aviso

Esta app **no** anima a enfrentarse a delincuentes, patrullar por cuenta propia, perseguir, retener ni castigar a nadie. El contenido es divulgativo, no sustituye a la formación presencial, al consejo médico ni al asesoramiento jurídico, y la información legal se refiere a España.
