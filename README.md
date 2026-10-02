# 🌙 Justiciero

App para iOS que convierte la idea de ser un «justiciero nocturno estilo Batman» en un **programa realista de 12 meses**: empiezas en casa y terminas haciendo servicios nocturnos reales con uniforme oficial, en forma, formado y dentro de la ley.

> Batman no existe. Tú sí.

## Qué incluye

| Sección | Contenido |
|---|---|
| **Base** | Rango y XP, racha diaria, fase actual, misiones pendientes, entreno sugerido, consejo del día y accesos rápidos a Salida segura y Emergencia. |
| **Programa** | 6 fases (~70 misiones semana a semana). Cada fase se desbloquea al completar el 80 % de la anterior. |
| **Entreno** | 9 sesiones guiadas con temporizador (series, repeticiones, descansos), test físico y historial. |
| **Academia** | 8 módulos y 29 lecciones, simulador con 10 escenarios reales, Juego de Kim (memoria visual) y el Código del Vigilante. |
| **Más** | Salida segura (checklist + check-ins con notificaciones + SMS a tu contacto), Emergencias (112 y otros números), Equipamiento legal, Bitácora, Perfil con gráficas de evolución y Rangos. |

### Las 6 fases

0. **La Cueva** (sem. 1–4) · En casa: evaluación física, sueño, ley, primeros auxilios básicos. *Nada de calle.*
1. **La Forja** (sem. 5–12) · Arte marcial con instructor, 0 a 5 km, curso presencial de RCP/DEA, aprender a caer.
2. **La Ciudad** (sem. 13–20) · Conocer tu barrio: primero de día, luego al anochecer acompañado. Puntos seguros, AlertCops.
3. **El Detective** (sem. 21–28) · Observación, descripción de personas y vehículos, la llamada perfecta al 112.
4. **El Guardián** (sem. 29–40) · Voluntariado en Protección Civil o Cruz Roja: servicios nocturnos reales.
5. **Caballero de la Noche** (sem. 41+) · Profesionalizarte (policía, bombero, TES, socorrista…) o ser mentor.

## Cómo instalarla en tu iPhone

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
Justiciero/
├── App/        Punto de entrada, pestañas y tema visual
├── Models/     Tipos de datos (fases, tareas, lecciones, escenarios…)
├── Data/       Contenido: programa, entrenos, academia, escenarios, equipo
├── Store/      Progreso del usuario (JSON local en el dispositivo)
└── Views/      Pantallas SwiftUI
```

SwiftUI puro, sin dependencias. Los datos se guardan solo en el dispositivo.

## Aviso

Esta app **no** anima a enfrentarse a delincuentes, patrullar por cuenta propia, perseguir, retener ni castigar a nadie. El contenido es divulgativo, no sustituye a la formación presencial, al consejo médico ni al asesoramiento jurídico, y la información legal se refiere a España.
