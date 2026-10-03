"use strict";

/* ============================================================
   Justiciero · versión web (PWA)
   El contenido viene de data.js (generado desde los ficheros Swift).
   ============================================================ */

const STORAGE_KEY = "justiciero.v1";
const XP = { task: 20, lesson: 15, workout: 30, scenarioPerPoint: 10, test: 25, journal: 5 };

const RANKS = [
  { name: "Recluta", minXP: 0, emoji: "🧑", motto: "Todo héroe empezó sin saber nada." },
  { name: "Aprendiz", minXP: 400, emoji: "🚶", motto: "La disciplina empieza a notarse." },
  { name: "Centinela", minXP: 1000, emoji: "👁️", motto: "Ves lo que otros no ven." },
  { name: "Vigilante", minXP: 2000, emoji: "🛡️", motto: "Preparado para actuar con cabeza." },
  { name: "Guardián", minXP: 3500, emoji: "⚔️", motto: "Tu barrio está mejor contigo en él." },
  { name: "Caballero de la Noche", minXP: 5500, emoji: "🌙", motto: "No necesitas máscara: la gente sabe quién eres." },
];

const CATEGORIES = {
  fisico: { label: "Físico", emoji: "🏃", color: "var(--orange)" },
  mente: { label: "Mente", emoji: "🧠", color: "var(--purple)" },
  ley: { label: "Ley", emoji: "⚖️", color: "var(--info)" },
  habilidad: { label: "Habilidad", emoji: "⛑️", color: "var(--danger)" },
  comunidad: { label: "Comunidad", emoji: "🤝", color: "var(--success)" },
  equipo: { label: "Equipo", emoji: "🎒", color: "var(--accent)" },
};

const PHASE_EMOJI = ["🏠", "🔥", "🏙️", "🔍", "🛡️", "🌙"];
const MODULE_STYLE = {
  ley: ["⚖️", "var(--info)"], auxilios: ["⛑️", "var(--danger)"], desescalada: ["🗣️", "var(--success)"],
  defensa: ["🥋", "var(--orange)"], observacion: ["👁️", "var(--purple)"], ciudad: ["🌃", "#2dd4bf"],
  mentalidad: ["🧠", "#f472b6"], caminos: ["🧭", "var(--accent)"],
};
const SCENARIO_EMOJI = {
  tiron: "👜", "pelea-bar": "🍺", inconsciente: "🧍", "me-siguen": "👣", coche: "🚗",
  metro: "🚇", navaja: "🔪", puente: "🌉", venganza: "✊", incendio: "🔥",
};
const GEAR_STATUS = {
  recomendado: { label: "Recomendado", emoji: "✅", color: "var(--success)" },
  condicionado: { label: "Con condiciones", emoji: "⚠️", color: "var(--accent)" },
  prohibido: { label: "No llevar", emoji: "⛔", color: "var(--danger)" },
};
const JOURNAL_KINDS = {
  entrenamiento: { label: "Entrenamiento", emoji: "🏃", prompt: "¿Qué has entrenado? ¿Cómo te has sentido? ¿Alguna molestia?" },
  salida: { label: "Salida nocturna", emoji: "🌙", prompt: "Ruta, duración, qué has observado, qué harías distinto." },
  observacion: { label: "Observación", emoji: "👁️", prompt: "Describe de arriba abajo: edad aprox., altura, complexión, ropa, calzado, rasgo distintivo. Sin nombres ni datos que identifiquen a nadie." },
  estudio: { label: "Estudio", emoji: "📚", prompt: "¿Qué has aprendido hoy? Explícalo con tus palabras." },
  voluntariado: { label: "Voluntariado", emoji: "❤️", prompt: "¿Qué servicio has hecho? ¿Qué has aprendido de tus compañeros?" },
  reflexion: { label: "Reflexión", emoji: "✍️", prompt: "¿Por qué haces esto? ¿Cómo te sientes? ¿Qué te preocupa?" },
};
const KIM_POOL = [
  "🔑", "🚗", "🚲", "🔦", "📱", "☂️", "👜", "☕", "📕", "👓", "✂️", "🔨", "🔧", "🔔", "⏰", "📷",
  "🎧", "🎮", "💡", "🍃", "🔥", "💧", "🌙", "⭐", "❤️", "🏠", "✈️", "🚌", "🗺️", "🚩", "🏷️", "💳",
  "🎁", "💊", "✉️", "📌", "✏️", "🗑️", "🔒", "⚡", "👕", "🎸", "⚽", "🍎", "🧲", "🕯️", "🧭", "🪑",
];
const EXERCISE_EMOJI = {
  jacks: "🤸", squat: "🦵", pushup: "💪", bridge: "🍑", plank: "🧱", sideplank: "🧱", superman: "🦸",
  climbers: "⛰️", lunge: "🚶", dips: "🪑", burpee: "🔥", row: "🚣", bulgarian: "🦵", hollow: "🍌",
  shadow: "🥊", sprawl: "🤼", "ukemi-back": "🥋", "ukemi-side": "🥋", roll: "🔄", mobility: "🔃",
  hip: "🧘", hamstring: "🧘", breath: "🌬️", "jog-warm": "🚶", jog: "🏃", strides: "⚡", balance: "🧍",
  precision: "🎯", stepup: "🪜", quad: "🐾",
};

/* ---------- Estado ---------- */

function defaultState() {
  return {
    profile: { alias: "", isAdult: true, onboarded: false, startDate: Date.now(), contactName: "", contactPhone: "" },
    xp: 0,
    completedTasks: [],
    completedLessons: [],
    scenarioBest: {},
    kimBest: 0,
    kimGames: 0,
    workouts: [],
    tests: [],
    journal: [],
    activeDays: [],
    outing: null,
  };
}

function load() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) return Object.assign(defaultState(), JSON.parse(raw));
  } catch (e) { /* almacenamiento no disponible */ }
  return defaultState();
}

let state = load();

function save() {
  try { localStorage.setItem(STORAGE_KEY, JSON.stringify(state)); } catch (e) { /* sin espacio o bloqueado */ }
}

function commit(fn, rerender = true) {
  fn(state);
  save();
  if (rerender) render();
}

/* ---------- Utilidades ---------- */

const $ = (sel) => document.querySelector(sel);
const esc = (s) => String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
const md = (s) => esc(s).replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>").replace(/\*(.+?)\*/g, "<em>$1</em>");
const pad = (n) => String(n).padStart(2, "0");
const mmss = (s) => `${Math.floor(s / 60)}:${pad(s % 60)}`;
const dayKey = (d = new Date()) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
const fmtDate = (t, opts = { day: "numeric", month: "short", hour: "2-digit", minute: "2-digit" }) =>
  new Date(t).toLocaleString("es-ES", opts);
const telLink = (n) => `tel:${String(n).replace(/[^\d+]/g, "")}`;
const smsLink = (phone, body) => `sms:${String(phone).replace(/[^\d+]/g, "")}&body=${encodeURIComponent(body)}`;

function toast(text) {
  const el = $("#toast");
  el.textContent = text;
  el.classList.add("show");
  clearTimeout(toast.t);
  toast.t = setTimeout(() => el.classList.remove("show"), 1800);
}

function markActive() {
  const k = dayKey();
  if (!state.activeDays.includes(k)) state.activeDays.push(k);
}

function gainXP(n) {
  if (n > 0) {
    state.xp += n;
    toast(`+${n} XP`);
  }
}

function streak() {
  const days = new Set(state.activeDays);
  const d = new Date();
  if (!days.has(dayKey(d))) d.setDate(d.getDate() - 1);
  let n = 0;
  while (days.has(dayKey(d))) { n++; d.setDate(d.getDate() - 1); }
  return n;
}

function programWeek() {
  const start = new Date(state.profile.startDate); start.setHours(0, 0, 0, 0);
  const today = new Date(); today.setHours(0, 0, 0, 0);
  return Math.floor(Math.max(0, Math.round((today - start) / 86400000)) / 7) + 1;
}

function rank() { return [...RANKS].reverse().find((r) => state.xp >= r.minXP) || RANKS[0]; }
function nextRank(r) { return RANKS[RANKS.indexOf(r) + 1]; }
function rankProgress() {
  const r = rank(), n = nextRank(r);
  return n ? (state.xp - r.minXP) / (n.minXP - r.minXP) : 1;
}

const isDone = (task) => state.completedTasks.includes(task.id);
function completion(phase) {
  return phase.tasks.filter(isDone).length / phase.tasks.length;
}
function isUnlocked(phase) {
  if (phase.id === 0) return true;
  const prev = PHASES[phase.id - 1];
  return isUnlocked(prev) && completion(prev) >= 0.8;
}
function currentPhase() { return [...PHASES].reverse().find(isUnlocked) || PHASES[0]; }
function weeksLabel(p) {
  return p.id === PHASES.length - 1 ? `Semana ${p.weeks[0]}+` : `Semanas ${p.weeks[0]}–${p.weeks[1]}`;
}
function workoutsThisWeek() {
  const now = new Date();
  const monday = new Date(now); monday.setHours(0, 0, 0, 0);
  monday.setDate(monday.getDate() - ((monday.getDay() + 6) % 7));
  return state.workouts.filter((w) => w.date >= monday.getTime()).length;
}
const learnedCount = (m) => m.lessons.filter((l) => state.completedLessons.includes(l.id)).length;
const optimalScenarios = () => Object.values(state.scenarioBest).filter((v) => v === 2).length;
function dailyTip() {
  const day = Math.floor(Date.now() / 86400000);
  return TIPS[day % TIPS.length];
}

/* ---------- Componentes HTML ---------- */

const bar = (v, color, thin) =>
  `<div class="bar${thin ? " thin" : ""}" style="${color ? `--c:${color}` : ""}"><span style="width:${Math.round(Math.max(0, Math.min(1, v)) * 100)}%"></span></div>`;
const pill = (text, color) => `<span class="pill" style="${color ? `--c:${color}` : ""}">${esc(text)}</span>`;
const section = (title, emoji = "") => `<div class="section">${emoji} ${esc(title)}</div>`;
const CALLOUT_ICON = { tip: "💡", warning: "⚠️", danger: "⛔", info: "ℹ️" };
const callout = (kind, text) => `<div class="callout ${kind}"><span class="ico">${CALLOUT_ICON[kind]}</span><div>${md(text)}</div></div>`;
const stat = (v, l, emoji) => `<div class="stat"><div class="ico">${emoji}</div><div class="v">${esc(v)}</div><div class="l">${esc(l)}</div></div>`;
const link = (href, inner, cls = "card chev row") => `<a class="${cls}" href="${href}">${inner}</a>`;

function taskRow(task, { compact = false, locked = false } = {}) {
  const done = isDone(task);
  const cat = CATEGORIES[task.category];
  return `
    <div class="card row top ${done ? "done" : ""} ${locked ? "locked" : ""}">
      <button class="check ${done ? "on" : ""}" data-act="toggle-task" data-id="${task.id}" ${locked ? "disabled" : ""} aria-label="Completar">${done ? "✓" : ""}</button>
      <div class="grow stack" style="gap:6px" ${compact ? 'data-act="expand"' : ""}>
        <div class="pills">${pill(`${cat.emoji} ${cat.label}`, cat.color)}${pill(`Sem. ${task.week}`, "var(--muted)")}</div>
        <p class="title task-title">${esc(task.title)}</p>
        <p class="small muted ${compact ? "clamp" : ""}">${esc(task.detail)}</p>
      </div>
    </div>`;
}

function workoutRow(w, locked) {
  const inner = `
    <div class="tile-ico">${locked ? "🔒" : EXERCISE_EMOJI[w.blocks[0].exercise.id] || "💪"}</div>
    <div class="grow stack" style="gap:4px">
      <p class="title">${esc(w.name)}</p>
      <p class="small muted">${esc(w.focus)}</p>
      <div class="pills">${pill(`⏱ ${w.minutes} min`, "var(--info)")}${pill(`📍 ${w.place}`, "var(--success)")}${locked ? pill(`🔒 Fase ${w.minPhase}`, "var(--muted)") : ""}</div>
    </div>`;
  return locked ? `<div class="card row locked">${inner}</div>` : link(`#/entreno/${w.id}`, inner);
}

/* ---------- Vistas: pestañas ---------- */

function viewBase() {
  const r = rank(), next = nextRank(r), phase = currentPhase();
  const hour = new Date().getHours();
  const greeting = hour >= 6 && hour < 13 ? "Buenos días" : hour >= 13 && hour < 21 ? "Buenas tardes" : "Buenas noches";
  const available = WORKOUTS.filter((w) => w.minPhase <= phase.id);
  const suggested = available[Math.floor(Date.now() / 86400000) % available.length];
  const tasks = phase.tasks.filter((t) => !isDone(t)).sort((a, b) => a.week - b.week).slice(0, 3);

  return {
    title: "Base", large: true,
    html: `
    <div class="stack">
      <div class="card stack" style="gap:12px">
        <p class="small muted">${greeting}, ${esc(state.profile.alias)}</p>
        <div class="row"><div class="avatar">${r.emoji}</div>
          <div><p class="h2">${esc(r.name)}</p><p class="tiny muted">${esc(r.motto)}</p></div></div>
        ${bar(rankProgress())}
        <div class="row tiny muted"><span class="grow">${state.xp} XP</span>
          <span>${next ? `Siguiente: ${esc(next.name)} (${next.minXP} XP)` : "Rango máximo"}</span></div>
      </div>
      <div class="grid3">
        ${stat(streak(), "Racha (días)", "🔥")}${stat(workoutsThisWeek(), "Entrenos semana", "🏃")}${stat(programWeek(), "Semana", "📅")}
      </div>
      ${link(`#/fase/${phase.id}`, `
        <div class="grow stack" style="gap:8px">
          <div class="row"><span class="grow">${pill(`${PHASE_EMOJI[phase.id]} FASE ${phase.id}`)}</span><span class="tiny muted">${weeksLabel(phase)}</span></div>
          <p class="codename">${esc(phase.codename)}</p>
          <p class="small muted">${esc(phase.title)}</p>
          ${bar(completion(phase))}
          <p class="tiny muted">${Math.round(completion(phase) * 100)} % completado · necesitas 80 % para avanzar</p>
        </div>`, "card row")}
      ${section("Misiones pendientes", "🎯")}
      ${tasks.length ? tasks.map((t) => taskRow(t, { compact: true })).join("") : `<div class="card">Has completado todas las misiones de esta fase. ¡Enorme!</div>`}
      ${section("Entreno sugerido hoy", "🏋️")}
      ${workoutRow(suggested, false)}
      ${section("Consejo del día", "💡")}
      <div class="card"><em>${esc(dailyTip())}</em></div>
      <div class="grid2">
        <a class="card center" href="#/salida" style="background:color-mix(in srgb, var(--info) 15%, transparent)"><div style="font-size:1.8rem">📍</div><strong style="color:var(--info)">Salida segura</strong></a>
        <a class="card center" href="#/emergencias" style="background:color-mix(in srgb, var(--danger) 15%, transparent)"><div style="font-size:1.8rem">🆘</div><strong style="color:var(--danger)">Emergencia</strong></a>
      </div>
    </div>`,
  };
}

function viewProgram() {
  const cur = currentPhase();
  return {
    title: "Programa", large: true,
    html: `<div class="stack">
      ${callout("info", "Un programa de **12 meses** en 6 fases. Cada fase se desbloquea al completar el **80 %** de la anterior. No hay atajos: el orden existe para que llegues a la calle preparado.")}
      ${PHASES.map((p) => {
        const un = isUnlocked(p), c = completion(p);
        return link(`#/fase/${p.id}`, `
          <div class="tile-ico" style="${un ? "background:var(--accent)" : "--c:var(--muted)"}">${un ? PHASE_EMOJI[p.id] : "🔒"}</div>
          <div class="grow stack" style="gap:4px">
            <div class="row"><span class="tiny muted grow">FASE ${p.id} · ${weeksLabel(p)}</span>${p.id === cur.id ? pill("ACTUAL") : ""}</div>
            <p class="title" style="font-weight:900">${esc(p.codename)}</p>
            <p class="small muted">${esc(p.title)}</p>
            <p class="tiny muted">📍 ${esc(p.location)}</p>
            ${un ? bar(c, c >= 0.8 ? "var(--success)" : null, true) : `<p class="tiny" style="color:var(--accent)">Completa el 80 % de la fase anterior</p>`}
          </div>`, `card row top chev ${p.id === cur.id ? "hi" : ""}`);
      }).join("")}
    </div>`,
  };
}

function viewTraining() {
  const phase = currentPhase();
  return {
    title: "Entreno", large: true,
    html: `<div class="stack">
      ${callout("tip", "Objetivo semanal: **3 sesiones** de la app + tus clases de arte marcial cuando llegues a la Fase 1. Deja siempre un día de descanso entre sesiones intensas.")}
      <div class="grid3">${stat(`${workoutsThisWeek()}/3`, "Esta semana", "📅")}${stat(state.workouts.length, "Totales", "🔥")}${stat(state.tests.length, "Tests físicos", "📈")}</div>
      <a class="btn" href="#/test">⏱ Registrar test físico</a>
      ${section("Sesiones", "🏋️")}
      ${WORKOUTS.map((w) => workoutRow(w, w.minPhase > phase.id)).join("")}
      ${state.workouts.length ? `${section("Historial reciente", "🕘")}
        <div class="card list">${state.workouts.slice(0, 10).map((w) =>
          `<div class="list-item small"><span class="grow">${esc(w.name)}</span><span class="muted">${fmtDate(w.date)}</span></div>`).join("")}</div>` : ""}
    </div>`,
  };
}

function viewAcademy() {
  return {
    title: "Academia", large: true,
    html: `<div class="stack">
      ${section("Entrenamiento mental", "🧠")}
      <div class="grid2">
        <a class="card stack" style="gap:8px" href="#/escenarios"><div style="font-size:2rem">🎭</div><p class="title">Simulador</p><p class="tiny muted">${optimalScenarios()}/${SCENARIOS.length} óptimos</p></a>
        <a class="card stack" style="gap:8px" href="#/kim"><div style="font-size:2rem">👁️</div><p class="title">Juego de Kim</p><p class="tiny muted">Récord: ${state.kimBest} %</p></a>
      </div>
      ${link("#/codigo", `<div style="font-size:1.6rem">📜</div><div class="grow"><p class="title">El Código del Vigilante</p><p class="small muted">Las ${CODE_RULES.length} reglas que nunca rompes</p></div>`)}
      ${section("Módulos", "📚")}
      ${MODULES.map((m) => {
        const [emoji, color] = MODULE_STYLE[m.id] || ["📘", "var(--accent)"];
        const n = learnedCount(m);
        return link(`#/modulo/${m.id}`, `
          <div class="tile-ico" style="--c:${color}">${emoji}</div>
          <div class="grow stack" style="gap:6px"><p class="title">${esc(m.title)}</p>${bar(n / m.lessons.length, color, true)}
          <p class="tiny muted">${n}/${m.lessons.length} lecciones</p></div>`);
      }).join("")}
    </div>`,
  };
}

function viewMore() {
  const item = (href, emoji, label) => `<a class="list-item chev" href="${href}"><span style="width:28px;text-align:center">${emoji}</span><span class="grow">${label}</span></a>`;
  return {
    title: "Más", large: true,
    html: `<div class="stack">
      ${section("En la calle")}
      <div class="card list" style="padding:4px 16px">${item("#/salida", "📍", "Salida segura")}${item("#/emergencias", "🆘", "Emergencias")}${item("#/equipo", "🎒", "Equipamiento")}</div>
      ${section("Tu progreso")}
      <div class="card list" style="padding:4px 16px">${item("#/perfil", "👤", "Perfil y tests físicos")}${item("#/bitacora", "📓", "Bitácora")}${item("#/rangos", "🏅", "Rangos")}</div>
      ${section("Información")}
      <div class="card list" style="padding:4px 16px">${item("#/codigo", "📜", "El Código del Vigilante")}${item("#/aviso", "ℹ️", "Aviso importante")}${item("#/instalar", "📲", "Instalar en el iPhone")}</div>
      ${section("Datos")}
      <div class="card list" style="padding:4px 16px">
        <button class="list-item" data-act="export"><span style="width:28px;text-align:center">💾</span><span class="grow">Exportar copia de seguridad</span></button>
        <label class="list-item" style="cursor:pointer"><span style="width:28px;text-align:center">📂</span><span class="grow">Importar copia de seguridad</span>
          <input type="file" accept="application/json,.json" data-act="import" hidden></label>
        <button class="list-item" data-act="reset" style="color:var(--danger)"><span style="width:28px;text-align:center">🗑️</span><span class="grow">Reiniciar todo el progreso</span></button>
      </div>
      <p class="tiny muted center">Tus datos se guardan solo en este dispositivo. Exporta una copia de vez en cuando.</p>
    </div>`,
  };
}

/* ---------- Vistas: programa ---------- */

function viewPhase(id) {
  const p = PHASES[Number(id)];
  if (!p) return null;
  const un = isUnlocked(p);
  const weeks = [...new Set(p.tasks.map((t) => t.week))].sort((a, b) => a - b);
  return {
    title: p.codename, back: "#/programa",
    html: `<div class="stack">
      <div class="pills">${pill(`${PHASE_EMOJI[p.id]} FASE ${p.id}`)}${pill(`📍 ${p.location}`, "var(--info)")}</div>
      <p class="h2">${esc(p.title)}</p>
      <p class="muted">${esc(p.summary)}</p>
      ${bar(completion(p))}
      ${un ? "" : callout("warning", "Fase bloqueada. Puedes leerla para saber lo que viene, pero no marcar tareas hasta completar el 80 % de la fase anterior.")}
      ${section("Por qué en este orden", "❓")}
      <div class="card">${esc(p.whyThisOrder)}</div>
      ${section("Objetivos", "🎯")}
      <div class="card stack" style="gap:8px">${p.objectives.map((o) => `<div class="row top"><span style="color:var(--accent)">◆</span><span>${esc(o)}</span></div>`).join("")}</div>
      ${section("Reglas de seguridad de la fase", "🛑")}
      ${p.safetyRules.map((r) => callout("danger", r)).join("")}
      ${!state.profile.isAdult && p.minorNote ? callout("info", p.minorNote) : ""}
      ${weeks.map((w) => section(`Semana ${w}`, "📅") + p.tasks.filter((t) => t.week === w).map((t) => taskRow(t, { locked: !un })).join("")).join("")}
    </div>`,
  };
}

/* ---------- Vistas: entreno ---------- */

function prescription(b) {
  if (b.seconds) return `${b.sets} × ${b.seconds >= 60 ? `${b.seconds / 60} min` : `${b.seconds} s`}`;
  return `${b.sets} × ${b.reps}`;
}

function viewWorkout(id) {
  const w = WORKOUTS.find((x) => x.id === id);
  if (!w) return null;
  return {
    title: w.name, back: "#/entreno",
    html: `<div class="stack">
      <p class="muted">${esc(w.focus)}</p>
      <div class="pills">${pill(`⏱ ${w.minutes} min`, "var(--info)")}${pill(`📍 ${w.place}`, "var(--success)")}</div>
      ${w.notes ? callout("warning", w.notes) : ""}
      ${section("Ejercicios", "📋")}
      ${w.blocks.map((b, i) => `
        <div class="card stack" style="gap:8px">
          <div class="row"><strong style="color:var(--accent)">${i + 1}</strong><span>${EXERCISE_EMOJI[b.exercise.id] || "💪"}</span>
            <p class="title grow">${esc(b.exercise.name)}</p><strong class="small" style="color:var(--accent)">${prescription(b)}</strong></div>
          <p class="small muted">${esc(b.exercise.howTo)}</p>
          <p class="tiny muted"><strong>Más fácil:</strong> ${esc(b.exercise.easier)}</p>
          ${b.rest ? `<p class="tiny muted">⏸ Descanso ${b.rest} s</p>` : ""}
        </div>`).join("")}
      <a class="btn" href="#/sesion/${w.id}">▶ Empezar sesión</a>
    </div>`,
  };
}

let session = null;

function startSession(w) {
  session = { w, block: 0, set: 0, stage: "work", remaining: w.blocks[0].seconds || 0, running: false, start: Date.now(), saved: false };
  requestWakeLock();
}

function sessionAdvance() {
  const s = session, b = s.w.blocks[s.block];
  if (s.set + 1 < b.sets) s.set++;
  else if (s.block + 1 < s.w.blocks.length) { s.block++; s.set = 0; }
  else { s.stage = "finished"; return; }
  s.stage = "work";
  s.running = false;
  s.remaining = s.w.blocks[s.block].seconds || 0;
}

function sessionFinishSet() {
  const s = session, b = s.w.blocks[s.block];
  s.running = false;
  if (s.set + 1 >= b.sets && s.block + 1 >= s.w.blocks.length) { s.set = b.sets; s.stage = "finished"; beep(3); return; }
  if (b.rest > 0) { s.stage = "rest"; s.remaining = b.rest; beep(1); }
  else sessionAdvance();
}

function sessionTick() {
  const s = session;
  if (!s || s.stage === "finished") return;
  const b = s.w.blocks[s.block];
  if (s.stage === "rest" || (s.stage === "work" && s.running && b.seconds)) {
    s.remaining = Math.max(0, s.remaining - 1);
    if (s.remaining === 0) {
      if (s.stage === "work") sessionFinishSet();
      else { beep(2); sessionAdvance(); }
    }
    render();
  }
}

function viewSession(id) {
  const w = WORKOUTS.find((x) => x.id === id);
  if (!w) return null;
  if (!session || session.w.id !== id) startSession(w);
  const s = session, b = w.blocks[s.block];
  const total = w.blocks.reduce((a, x) => a + x.sets, 0);
  const doneSets = w.blocks.slice(0, s.block).reduce((a, x) => a + x.sets, 0) + s.set;
  let body;
  if (s.stage === "work") {
    body = `
      <p class="eyebrow center" style="color:var(--accent)">Serie ${s.set + 1} de ${b.sets}</p>
      <div class="huge-ico">${EXERCISE_EMOJI[b.exercise.id] || "💪"}</div>
      <p class="h2 center">${esc(b.exercise.name)}</p>
      ${b.seconds
        ? `<div class="big-timer">${mmss(s.remaining)}</div>
           <button class="btn" data-act="session-toggle" style="${s.running ? "--c:var(--card-hi);color:var(--text)" : ""}">${s.running ? "Pausar" : "Iniciar"}</button>`
        : `<div class="big-timer" style="font-size:3.2rem">${esc(b.reps)}</div><p class="center muted">repeticiones</p>
           <button class="btn" data-act="session-done">Hecho</button>`}
      <p class="small muted center">${esc(b.exercise.howTo)}</p>`;
  } else if (s.stage === "rest") {
    const next = s.set + 1 < b.sets ? `${b.exercise.name} · serie ${s.set + 2}` : s.block + 1 < w.blocks.length ? w.blocks[s.block + 1].exercise.name : "¡Final!";
    body = `
      <p class="eyebrow center" style="color:var(--info)">Descanso</p>
      <div class="big-timer">${mmss(s.remaining)}</div>
      <p class="center muted">Respira: 4 s dentro, 4 s fuera</p>
      <p class="center title">Siguiente: ${esc(next)}</p>
      <button class="btn" style="--c:var(--info)" data-act="session-skip">Saltar descanso</button>`;
  } else {
    body = `
      <div class="huge-ico">✅</div>
      <p class="h2 center">Sesión completada</p>
      <p class="center muted">Cada sesión te acerca un paso más. Hidrátate y estira.</p>
      <button class="btn" style="--c:var(--success)" data-act="session-save">Registrar sesión (+${XP.workout} XP)</button>`;
  }
  return {
    title: w.name, back: `#/entreno/${w.id}`, hideTabs: true,
    html: `<div class="session">${bar(doneSets / total)}${body}</div>`,
  };
}

function stepper(name, label, value, step = 1, max = 600) {
  return `<div class="stepper"><span>${label}</span><div class="ctrl">
    <button type="button" data-act="step" data-target="${name}" data-step="${-step}">−</button>
    <input type="number" inputmode="numeric" name="${name}" value="${value}" min="0" max="${max}">
    <button type="button" data-act="step" data-target="${name}" data-step="${step}">+</button></div></div>`;
}

function viewTest() {
  const last = state.tests[state.tests.length - 1] || { pushups: 10, squats: 20, plankSeconds: 30, burpees: 10, run5kMinutes: null };
  return {
    title: "Test físico", back: "#/entreno",
    html: `<form class="stack" data-form="test">
      <p class="small muted">Hazlo descansado, con calentamiento previo de 5 minutos y descansando 3 minutos entre pruebas. Técnica limpia: las repeticiones malas no cuentan.</p>
      ${section("Fuerza")}
      <div class="card">${stepper("pushups", "Flexiones seguidas", last.pushups)}${stepper("squats", "Sentadillas en 1 min", last.squats)}</div>
      ${section("Core y resistencia")}
      <div class="card">${stepper("plank", "Plancha (s)", last.plankSeconds, 5)}${stepper("burpees", "Burpees en 1 min", last.burpees)}</div>
      ${section("Carrera")}
      <div class="card">
        <label class="switch"><span>He corrido 5 km</span><input type="checkbox" name="hasRun" ${last.run5kMinutes ? "checked" : ""}></label>
        ${stepper("run", "Tiempo 5 km (min)", last.run5kMinutes || 35, 1, 120)}
      </div>
      <button class="btn" type="submit">Guardar (+${XP.test} XP)</button>
    </form>`,
  };
}

/* ---------- Vistas: academia ---------- */

function lessonBlock(b, color) {
  switch (b.type) {
    case "heading": return `<h3>${esc(b.value)}</h3>`;
    case "paragraph": return `<p>${md(b.value)}</p>`;
    case "bullets": return `<ul style="--c:${color}">${b.value.map((x) => `<li><span>${md(x)}</span></li>`).join("")}</ul>`;
    case "steps": return `<ol style="--c:${color}">${b.value.map((x) => `<li><span>${md(x)}</span></li>`).join("")}</ol>`;
    case "tip": return callout("tip", b.value);
    case "warning": return callout("warning", b.value);
    case "danger": return callout("danger", b.value);
    default: return "";
  }
}

function viewModule(id) {
  const m = MODULES.find((x) => x.id === id);
  if (!m) return null;
  return {
    title: m.title, back: "#/academia",
    html: `<div class="stack">
      <p class="muted">${esc(m.intro)}</p>
      ${m.lessons.map((l) => {
        const done = state.completedLessons.includes(l.id);
        return link(`#/leccion/${m.id}/${l.id}`, `<span class="check ${done ? "on" : ""}">${done ? "✓" : ""}</span>
          <div class="grow"><p class="title">${esc(l.title)}</p><p class="tiny muted">${l.minutes} min de lectura</p></div>`);
      }).join("")}
    </div>`,
  };
}

function viewLesson(mid, lid) {
  const m = MODULES.find((x) => x.id === mid);
  const l = m && m.lessons.find((x) => x.id === lid);
  if (!l) return null;
  const color = (MODULE_STYLE[m.id] || [])[1] || "var(--accent)";
  const done = state.completedLessons.includes(l.id);
  return {
    title: l.title, back: `#/modulo/${m.id}`,
    html: `<div class="stack lesson">
      ${l.blocks.map((b) => lessonBlock(b, color)).join("")}
      <button class="btn" style="${done ? "--c:var(--success)" : ""}" data-act="lesson-done" data-mid="${m.id}" data-lid="${l.id}">
        ${done ? "✓ Aprendida" : `Marcar como aprendida (+${XP.lesson} XP)`}</button>
    </div>`,
  };
}

function viewCode() {
  return {
    title: "El Código", back: "#/academia",
    html: `<div class="stack">
      <p class="muted">Batman tenía una sola regla. Tú tienes trece, porque la realidad es más complicada que un cómic. Léelas antes de cada salida.</p>
      ${CODE_RULES.map((r) => `<div class="card row top"><strong style="font-size:1.5rem;color:var(--accent);font-variant-numeric:tabular-nums">${pad(r.number)}</strong>
        <div><p class="title">${esc(r.title)}</p><p class="small muted">${esc(r.text)}</p></div></div>`).join("")}
    </div>`,
  };
}

function viewScenarios() {
  const badge = (s) => s === 2 ? pill("★ Óptimo", "var(--success)") : s === 1 ? pill("Mejorable") : s === 0 ? pill("Repetir", "var(--danger)") : pill("Nuevo", "var(--muted)");
  return {
    title: "Simulador", back: "#/academia",
    html: `<div class="stack">
      <p class="muted">Situaciones reales. Elige qué harías. No hay trampa: lo que funciona en el cine casi nunca funciona en la calle.</p>
      ${SCENARIOS.map((s) => link(`#/escenario/${s.id}`, `<span style="font-size:1.6rem;width:36px;text-align:center">${SCENARIO_EMOJI[s.id] || "❓"}</span>
        <p class="title grow">${esc(s.title)}</p>${badge(state.scenarioBest[s.id])}`)).join("")}
    </div>`,
  };
}

let scenarioPlay = null;

function viewScenario(id) {
  const s = SCENARIOS.find((x) => x.id === id);
  if (!s) return null;
  if (!scenarioPlay || scenarioPlay.id !== id) {
    scenarioPlay = { id, order: shuffle(s.options.map((_, i) => i)), selected: null, gained: 0 };
  }
  const sp = scenarioPlay;
  const sel = sp.selected === null ? null : s.options[sp.selected];
  const best = s.options.find((o) => o.score === 2);
  return {
    title: s.title, back: "#/escenarios",
    html: `<div class="stack">
      <div style="font-size:2.6rem">${SCENARIO_EMOJI[s.id] || "❓"}</div>
      <p style="font-size:1.2rem">${esc(s.situation)}</p>
      ${section("¿Qué haces?", "👆")}
      ${sp.order.map((i) => {
        const o = s.options[i];
        let cls = "";
        if (sel) cls = o.score === 2 ? "best" : i === sp.selected ? `sel-${o.score}` : "";
        return `<button class="card option ${cls}" data-act="scenario-pick" data-i="${i}" ${sel ? "disabled" : ""}>${esc(o.text)}</button>`;
      }).join("")}
      ${sel ? `
        ${callout(sel.score === 2 ? "tip" : sel.score === 1 ? "warning" : "danger", sel.feedback)}
        ${sel.score < 2 ? callout("info", `**Mejor opción:** ${best.text}`) : ""}
        <div class="card">${md(`**Lección:** ${s.lesson}`)}</div>
        ${sp.gained ? `<p class="title" style="color:var(--accent)">+${sp.gained} XP</p>` : ""}
        <button class="btn ghost" data-act="scenario-retry">Intentar de nuevo</button>` : ""}
    </div>`,
  };
}

let kim = { stage: "menu", hard: false };

function kimStart() {
  const targetCount = kim.hard ? 12 : 8, boardCount = kim.hard ? 24 : 16;
  const chosen = shuffle([...KIM_POOL]).slice(0, boardCount);
  kim = { ...kim, stage: "memorize", targets: chosen.slice(0, targetCount), board: shuffle([...chosen]), picks: [], countdown: kim.hard ? 20 : 25, percent: 0, gained: 0 };
}

function kimFinish() {
  const targetCount = kim.targets.length;
  const correct = kim.picks.filter((p) => kim.targets.includes(p)).length;
  const wrong = kim.picks.length - correct;
  kim.percent = Math.round((Math.max(0, correct - wrong) / targetCount) * 100);
  kim.stage = "result";
  commit((s) => {
    s.kimGames++;
    s.kimBest = Math.max(s.kimBest, kim.percent);
    kim.gained = Math.floor(kim.percent / 5);
    gainXP(kim.gained);
    markActive();
  });
}

function viewKim() {
  let html;
  if (kim.stage === "menu") {
    html = `
      <p class="muted">Un ejercicio clásico de entrenamiento de scouts, militares y policías para desarrollar la memoria visual.</p>
      ${callout("info", "Verás varios objetos durante unos segundos. Después aparecerán mezclados con otros y tendrás que marcar solo los que viste.")}
      <div class="segmented"><button class="${kim.hard ? "" : "on"}" data-act="kim-level" data-hard="0">Normal (8)</button><button class="${kim.hard ? "on" : ""}" data-act="kim-level" data-hard="1">Difícil (12)</button></div>
      <div class="grid2">${stat(state.kimGames, "Partidas", "🎮")}${stat(`${state.kimBest}%`, "Récord", "🏆")}</div>
      <button class="btn" data-act="kim-start">Empezar</button>`;
  } else if (kim.stage === "memorize") {
    html = `
      <p class="h2 center">Memoriza</p>
      <div class="big-timer" style="color:var(--accent);font-size:3.2rem">${kim.countdown}</div>
      <div class="kim">${kim.targets.map((e) => `<div>${e}</div>`).join("")}</div>
      <button class="btn ghost" data-act="kim-recall">Ya lo tengo</button>`;
  } else if (kim.stage === "recall") {
    html = `
      <p class="h2 center">¿Cuáles viste?</p>
      <p class="center muted">Marcados: ${kim.picks.length} de ${kim.targets.length}</p>
      <div class="kim">${kim.board.map((e) => `<button class="${kim.picks.includes(e) ? "on" : ""}" data-act="kim-pick" data-e="${e}">${e}</button>`).join("")}</div>
      <button class="btn" data-act="kim-check">Comprobar</button>`;
  } else {
    html = `
      <div class="big-timer" style="color:${kim.percent >= 80 ? "var(--success)" : "var(--accent)"}">${kim.percent} %</div>
      <p class="center muted">${kim.percent >= 80 ? "Memoria de detective." : "Sigue practicando: mejora rápido con la repetición."}</p>
      ${kim.gained ? `<p class="center title" style="color:var(--accent)">+${kim.gained} XP</p>` : ""}
      <div class="kim">${kim.board.map((e) => {
        const t = kim.targets.includes(e), p = kim.picks.includes(e);
        return `<div class="${t ? (p ? "ok" : "miss") : p ? "bad" : ""}">${e}</div>`;
      }).join("")}</div>
      <p class="tiny center"><span style="color:var(--success)">■ Acierto</span> · <span style="color:var(--accent)">■ Olvidado</span> · <span style="color:var(--danger)">■ Error</span></p>
      <button class="btn" data-act="kim-start">Otra partida</button>
      <button class="linkbtn" data-act="kim-menu">Menú</button>`;
  }
  return { title: "Juego de Kim", back: "#/academia", html: `<div class="stack">${html}</div>` };
}

/* ---------- Vistas: más ---------- */

const EMERGENCY_NUMBERS = [
  ["091", "Policía Nacional", "Delitos en ciudades", "👮"],
  ["062", "Guardia Civil", "Delitos en zonas rurales y carreteras", "🚓"],
  ["092", "Policía Local", "Convivencia, tráfico, ruido", "🏛️"],
  ["016", "Violencia de género", "Gratuito, 24 h, no deja rastro en la factura", "💜"],
  ["024", "Conducta suicida", "Gratuito, 24 h, confidencial", "💬"],
  ["900202010", "ANAR (menores)", "Ayuda a niños y adolescentes", "🧒"],
];

function viewEmergency() {
  const p = state.profile;
  return {
    title: "Emergencias", back: "#/mas",
    html: `<div class="stack">
      <a class="sos" href="tel:112"><div class="n">112</div><div class="eyebrow">Emergencias</div><div class="tiny">Gratuito · Funciona sin saldo y sin cobertura de tu operador</div></a>
      ${callout("info", "**Qué decir:** dónde estás (calle, número, referencia), qué pasa, cuántos heridos, si hay armas y hacia dónde huyeron. No cuelgues hasta que te lo digan.")}
      ${p.contactPhone ? `${section("Tu contacto de confianza", "🤝")}
        <div class="grid2">
          <a class="card center" href="${telLink(p.contactPhone)}" style="color:var(--success)"><div style="font-size:1.6rem">📞</div><strong>Llamar a ${esc(p.contactName || "contacto")}</strong></a>
          <a class="card center" href="${smsLink(p.contactPhone, "Necesito ayuda. Llámame en cuanto puedas.")}" style="color:var(--info)"><div style="font-size:1.6rem">💬</div><strong>SMS de ayuda</strong></a>
        </div>` : ""}
      ${section("Otros números (España)", "📞")}
      ${EMERGENCY_NUMBERS.map(([n, name, detail, emoji]) => `<a class="card row" href="${telLink(n)}">
        <span style="font-size:1.5rem;width:32px;text-align:center">${emoji}</span>
        <div class="grow"><p class="title">${name}</p><p class="tiny muted">${detail}</p></div><strong style="font-size:1.2rem">${n}</strong></a>`).join("")}
      ${callout("tip", "Instala **AlertCops** (Ministerio del Interior) para alertar a la policía por chat si no puedes hablar, y configura **Emergencia SOS** en Ajustes del iPhone.")}
    </div>`,
  };
}

function viewGear() {
  return {
    title: "Equipamiento", back: "#/mas",
    html: `<div class="stack">
      <p class="muted">El cinturón de Batman, versión legal. Tu equipo sirve para ayudar, avisar y protegerte, no para atacar.</p>
      ${Object.entries(GEAR_STATUS).map(([key, st]) => section(st.label, st.emoji) + GEAR.filter((g) => g.status === key).map((g) =>
        `<div class="card"><p class="title" style="color:${st.color}">${esc(g.name)}</p><p class="small muted">${esc(g.why)}</p></div>`).join("")).join("")}
      ${callout("info", "Información orientativa basada en la normativa española. La legislación cambia y depende del país: ante la duda, consulta a la policía local.")}
    </div>`,
  };
}

function viewRanks() {
  const cur = rank();
  return {
    title: "Rangos", back: "#/mas",
    html: `<div class="stack">
      ${callout("info", `Ganas XP con cada misión (${XP.task}), sesión de entreno (${XP.workout}), test físico (${XP.test}), lección (${XP.lesson}), escenario mejorado y partida del Juego de Kim.`)}
      ${RANKS.map((r) => {
        const reached = state.xp >= r.minXP;
        return `<div class="card row ${r === cur ? "hi" : ""}" style="${reached ? "" : "opacity:.6"}">
          <div class="avatar" style="${reached ? "" : "background:var(--card-hi)"}">${r.emoji}</div>
          <div class="grow"><p class="title">${r.name}</p><p class="tiny muted">${r.motto}</p><p class="tiny" style="color:var(--accent)">${r.minXP} XP</p></div>
          ${r === cur ? pill("TÚ") : ""}</div>`;
      }).join("")}
    </div>`,
  };
}

function viewAbout() {
  return {
    title: "Aviso", back: "#/mas",
    html: `<div class="stack">
      <p class="h2">Batman no existe. Tú sí.</p>
      <p>Esta app toma la idea del justiciero nocturno y la convierte en algo real: una persona en forma, formada en primeros auxilios, que conoce la ley, observa con atención y protege a su comunidad desde dentro de la legalidad.</p>
      ${callout("danger", "Esta app **no** te anima a enfrentarte a delincuentes, patrullar por tu cuenta, perseguir, retener ni castigar a nadie. Hacerlo es peligroso y, en la mayoría de los casos, ilegal.")}
      ${callout("warning", "El contenido es divulgativo y no sustituye a la formación presencial (primeros auxilios, artes marciales), al consejo médico ni al asesoramiento jurídico. La información legal se refiere a España y puede cambiar.")}
      ${callout("info", "Antes de empezar un programa de ejercicio, consulta con tu médico si tienes cualquier condición de salud.")}
      <p class="tiny muted">Tus datos se guardan solo en tu dispositivo.</p>
    </div>`,
  };
}

function viewInstall() {
  const standalone = window.matchMedia("(display-mode: standalone)").matches || navigator.standalone;
  return {
    title: "Instalar", back: "#/mas",
    html: `<div class="stack">
      ${standalone ? callout("tip", "Ya estás usando la app instalada. ¡Perfecto!") : ""}
      <p class="h2">Instálala en tu iPhone</p>
      <div class="card lesson"><ol style="--c:var(--accent)">
        <li><span>Abre esta página en <strong>Safari</strong>.</span></li>
        <li><span>Pulsa el botón <strong>Compartir</strong> (el cuadrado con la flecha hacia arriba).</span></li>
        <li><span>Elige <strong>Añadir a pantalla de inicio</strong>.</span></li>
        <li><span>Pulsa <strong>Añadir</strong>. Ya tienes el icono de Justiciero, a pantalla completa y funcionando sin conexión.</span></li>
      </ol></div>
      ${callout("info", "Tu progreso se guarda en el iPhone. Si borras la app de la pantalla de inicio, se borra también: usa **Más › Exportar copia de seguridad** de vez en cuando.")}
    </div>`,
  };
}

function viewJournal(filter) {
  const entries = filter ? state.journal.filter((e) => e.kind === filter) : state.journal;
  return {
    title: "Bitácora", back: "#/mas",
    action: `<a class="linkbtn" href="#/bitacora-nueva/${filter || "reflexion"}" aria-label="Nueva entrada">✎ Nueva</a>`,
    html: `<div class="stack">
      <div class="chips">
        <a class="chip ${filter ? "" : "on"}" href="#/bitacora">Todo</a>
        ${Object.entries(JOURNAL_KINDS).map(([k, v]) => `<a class="chip ${filter === k ? "on" : ""}" href="#/bitacora/${k}">${v.emoji} ${v.label}</a>`).join("")}
      </div>
      ${entries.length ? entries.map((e) => `
        <div class="card stack" style="gap:6px">
          <div class="row"><span class="tiny grow" style="color:var(--accent);font-weight:600">${JOURNAL_KINDS[e.kind].emoji} ${JOURNAL_KINDS[e.kind].label}</span>
            <span class="tiny muted">${fmtDate(e.date, { day: "numeric", month: "short", year: "numeric", hour: "2-digit", minute: "2-digit" })}</span></div>
          <p class="title">${esc(e.title)}</p>
          ${e.notes ? `<p class="small muted" style="white-space:pre-wrap">${esc(e.notes)}</p>` : ""}
          <div class="row"><span class="tiny grow" style="color:var(--accent)">${"★".repeat(e.mood)}${"☆".repeat(5 - e.mood)}</span>
            <button class="linkbtn tiny" style="color:var(--danger)" data-act="journal-delete" data-id="${e.id}">Borrar</button></div>
        </div>`).join("") : `<div class="card muted">Aún no hay entradas. La bitácora es tu memoria: observaciones, salidas, reflexiones y puntos seguros de tu barrio.</div>`}
    </div>`,
  };
}

function viewJournalNew(kind = "reflexion", title = "") {
  if (!JOURNAL_KINDS[kind]) kind = "reflexion";
  return {
    title: "Nueva entrada", back: "#/bitacora",
    html: `<form class="stack" data-form="journal">
      <div class="field"><label>Tipo</label><select name="kind" data-act="journal-kind">
        ${Object.entries(JOURNAL_KINDS).map(([k, v]) => `<option value="${k}" ${k === kind ? "selected" : ""}>${v.emoji} ${v.label}</option>`).join("")}</select></div>
      <div class="field"><label>Título</label><input type="text" name="title" value="${esc(title)}" placeholder="${JOURNAL_KINDS[kind].label}"></div>
      <div class="field"><label>Notas</label><textarea name="notes" placeholder="${esc(JOURNAL_KINDS[kind].prompt)}"></textarea></div>
      <div class="field"><label>¿Cómo te has sentido?</label>
        <div class="segmented" data-mood>${[1, 2, 3, 4, 5].map((n) => `<button type="button" class="${n === 3 ? "on" : ""}" data-act="mood" data-v="${n}">${"★".repeat(n)}</button>`).join("")}</div>
        <input type="hidden" name="mood" value="3"></div>
      <button class="btn" type="submit">Guardar (+${XP.journal} XP)</button>
    </form>`,
  };
}

function chartSVG(points) {
  const W = 320, H = 180, P = 24;
  const xs = points.map((p) => p.date), ys = points.map((p) => p.value);
  const minX = Math.min(...xs), maxX = Math.max(...xs), minY = Math.min(0, ...ys), maxY = Math.max(...ys) || 1;
  const x = (v) => P + (maxX === minX ? (W - 2 * P) / 2 : ((v - minX) / (maxX - minX)) * (W - 2 * P));
  const y = (v) => H - P - ((v - minY) / (maxY - minY)) * (H - 2 * P);
  const path = points.map((p, i) => `${i ? "L" : "M"}${x(p.date).toFixed(1)},${y(p.value).toFixed(1)}`).join(" ");
  return `<svg class="chart" viewBox="0 0 ${W} ${H}" preserveAspectRatio="none">
    <line x1="${P}" y1="${H - P}" x2="${W - P}" y2="${H - P}" stroke="rgba(255,255,255,.15)"/>
    <text x="${P}" y="${H - 6}">${fmtDate(minX, { day: "numeric", month: "short" })}</text>
    <text x="${W - P}" y="${H - 6}" text-anchor="end">${fmtDate(maxX, { day: "numeric", month: "short" })}</text>
    <text x="4" y="${y(maxY) + 4}">${maxY}</text>
    <path d="${path}" fill="none" stroke="var(--accent)" stroke-width="2.5" stroke-linejoin="round"/>
    ${points.map((p) => `<circle cx="${x(p.date)}" cy="${y(p.value)}" r="4" fill="var(--accent)"/>`).join("")}
  </svg>`;
}

const METRICS = {
  pushups: ["Flexiones", (t) => t.pushups],
  squats: ["Sentadillas", (t) => t.squats],
  plank: ["Plancha (s)", (t) => t.plankSeconds],
  burpees: ["Burpees", (t) => t.burpees],
  run: ["5 km (min)", (t) => t.run5kMinutes],
};
let metric = "pushups";

function viewProfile() {
  const p = state.profile;
  const points = state.tests.map((t) => ({ date: t.date, value: METRICS[metric][1](t) })).filter((x) => x.value != null);
  let evolution = `<p class="muted">Aún no has registrado ningún test.</p>`;
  if (state.tests.length) {
    const diff = points.length > 1 ? points[points.length - 1].value - points[0].value : 0;
    const better = metric === "run" ? diff < 0 : diff > 0;
    evolution = `
      <div class="chips">${Object.entries(METRICS).map(([k, [label]]) => `<button class="chip ${metric === k ? "on" : ""}" data-act="metric" data-m="${k}">${label}</button>`).join("")}</div>
      ${points.length ? chartSVG(points) : `<p class="muted">Sin datos para esta métrica.</p>`}
      ${points.length > 1 ? `<p style="color:${better ? "var(--success)" : "var(--muted)"}">Desde tu primer test: ${diff > 0 ? "+" : ""}${diff}</p>` : ""}`;
  }
  return {
    title: "Perfil", back: "#/mas",
    html: `<div class="stack">
      <form class="card stack" data-form="profile">
        <div class="field"><label>Alias</label><input type="text" name="alias" value="${esc(p.alias)}"></div>
        <label class="switch"><span>Soy mayor de edad</span><input type="checkbox" name="isAdult" ${p.isAdult ? "checked" : ""}></label>
        <p class="small muted">Tu «Alfred» (contacto de confianza): se usa para llamarle o enviarle un SMS desde Salida segura y Emergencias.</p>
        <div class="field"><label>Nombre</label><input type="text" name="contactName" value="${esc(p.contactName)}"></div>
        <div class="field"><label>Teléfono</label><input type="tel" name="contactPhone" value="${esc(p.contactPhone)}"></div>
        <button class="btn" type="submit">Guardar perfil</button>
      </form>
      <div class="card list" style="padding:4px 16px">
        <div class="list-item"><span class="grow muted">Empezaste</span><span>${fmtDate(p.startDate, { day: "numeric", month: "long", year: "numeric" })}</span></div>
        <div class="list-item"><span class="grow muted">Rango</span><span>${rank().name}</span></div>
        <div class="list-item"><span class="grow muted">Experiencia</span><span>${state.xp} XP</span></div>
      </div>
      ${section("Evolución física", "📈")}
      <div class="card stack">${evolution}</div>
      <a class="btn ghost" href="#/test">＋ Registrar nuevo test</a>
      ${state.tests.length ? section("Historial de tests", "🗂️") + `<div class="card list" style="padding:4px 16px">${[...state.tests].reverse().map((t) => `
        <div class="list-item" style="display:block"><p class="title">${fmtDate(t.date, { day: "numeric", month: "short", year: "numeric" })}</p>
        <p class="tiny muted">Flexiones ${t.pushups} · Sentadillas ${t.squats} · Plancha ${t.plankSeconds} s · Burpees ${t.burpees}${t.run5kMinutes ? ` · 5 km en ${t.run5kMinutes} min` : ""}</p></div>`).join("")}</div>` : ""}
    </div>`,
  };
}

/* ---------- Salida segura ---------- */

const OUTING_CHECKLIST = [
  "Alguien de confianza sabe dónde voy y a qué hora vuelvo",
  "Móvil por encima del 50 % (o llevo batería externa)",
  "Ubicación compartida con mi contacto",
  "Ropa visible o reflectante y calzado cómodo",
  "Botiquín de bolsillo, linterna y DNI",
  "No llevo armas ni nada que pueda parecerlo",
  "Estoy sobrio y descansado",
  "He repasado el Código del Vigilante",
];
let outingChecks = new Set();
let outingInterval = 45;

function viewOuting() {
  const phase = currentPhase(), p = state.profile, o = state.outing;
  const warnings = (phase.id < 2 ? callout("warning", `Estás en la fase ${phase.id}. Las salidas nocturnas de entrenamiento empiezan en la **Fase 2**. Mientras tanto, usa esto para cualquier vuelta a casa de noche.`) : "")
    + (!p.isAdult ? callout("warning", "Eres menor de edad: tus salidas nocturnas, siempre acompañado por un adulto y con permiso de tu familia.") : "");
  if (o) {
    const remaining = Math.max(0, Math.round((o.end - Date.now()) / 1000));
    const overdue = remaining === 0;
    return {
      title: "Salida segura", back: "#/mas",
      html: `<div class="stack">${warnings}
        <div class="card center" style="${overdue ? "background:color-mix(in srgb, var(--danger) 22%, var(--card))" : ""}">
          <p class="eyebrow" style="color:${overdue ? "var(--danger)" : "var(--accent)"}">${overdue ? "Check-in pendiente" : "Próximo check-in"}</p>
          <div class="big-timer" id="outing-timer" style="color:${overdue ? "var(--danger)" : "inherit"}">${mmss(remaining)}</div>
          <p class="tiny muted">Fuera desde las ${fmtDate(o.started, { hour: "2-digit", minute: "2-digit" })}</p>
        </div>
        <button class="btn" style="--c:var(--success)" data-act="outing-checkin">👍 Estoy bien</button>
        <div class="grid2">
          <a class="card center" href="tel:112" style="color:var(--danger)"><div style="font-size:1.6rem">🆘</div><strong>112</strong></a>
          ${p.contactPhone
            ? `<a class="card center" href="${smsLink(p.contactPhone, "Estoy en una salida y necesito que me llames. Mira mi ubicación compartida.")}" style="color:var(--info)"><div style="font-size:1.6rem">💬</div><strong>Avisar a ${esc(p.contactName || "contacto")}</strong></a>`
            : `<div class="card center muted"><div style="font-size:1.6rem">💬</div><strong>Sin contacto</strong></div>`}
        </div>
        <button class="btn ghost" data-act="outing-finish">🏠 He vuelto a casa</button>
        ${callout("tip", "Si ves algo: **distancia, 112 y descripción**. Tu trabajo esta noche es volver a casa sano.")}
        ${callout("info", "En la versión web, el aviso de check-in solo suena con certeza si la app está abierta. Déjala abierta en primer plano o pon también un temporizador en la app Reloj.")}
      </div>`,
    };
  }
  const all = outingChecks.size === OUTING_CHECKLIST.length;
  return {
    title: "Salida segura", back: "#/mas",
    html: `<div class="stack">${warnings}
      <p class="muted">Antes de salir, comprueba todo. Mientras estés fuera, la app te pedirá que confirmes que estás bien cada cierto tiempo.</p>
      ${section("Checklist", "✅")}
      <div class="card list" style="padding:4px 16px">${OUTING_CHECKLIST.map((c, i) => `
        <button class="list-item" data-act="outing-check" data-i="${i}"><span class="check sq ${outingChecks.has(i) ? "on" : ""}">${outingChecks.has(i) ? "✓" : ""}</span><span class="grow">${c}</span></button>`).join("")}</div>
      ${section("Check-in cada", "⏲️")}
      <div class="segmented">${[[20, "20 min"], [45, "45 min"], [60, "1 h"], [90, "1 h 30"]].map(([v, l]) =>
        `<button class="${outingInterval === v ? "on" : ""}" data-act="outing-interval" data-v="${v}">${l}</button>`).join("")}</div>
      ${p.contactPhone ? "" : callout("info", "Añade un contacto de confianza en Más › Perfil para poder avisarle con un toque.")}
      <button class="btn" data-act="outing-start" ${all ? "" : "disabled"}>🌙 Iniciar salida</button>
      ${all ? "" : `<p class="tiny muted center">Marca todos los puntos para poder salir.</p>`}
    </div>`,
  };
}

let outingAlerted = false;

function outingTick() {
  const o = state.outing;
  if (!o) return;
  const remaining = Math.max(0, Math.round((o.end - Date.now()) / 1000));
  if (remaining === 0 && !outingAlerted) {
    outingAlerted = true;
    beep(4);
    if (navigator.vibrate) navigator.vibrate([400, 200, 400, 200, 400]);
    notify("¿Todo bien?", "Abre Justiciero y confirma que estás bien.");
    if (location.hash === "#/salida") render();
  }
  const el = document.getElementById("outing-timer");
  if (el) el.textContent = mmss(remaining);
}

function notify(title, body) {
  if (!("Notification" in window) || Notification.permission !== "granted") return;
  navigator.serviceWorker?.ready
    .then((reg) => reg.showNotification(title, { body, icon: "icons/icon-192.png", tag: "outing" }))
    .catch(() => { try { new Notification(title, { body }); } catch (e) { /* no soportado */ } });
}

/* ---------- Onboarding ---------- */

let onb = { page: 0, alias: "", isAdult: true, accepted: false, contactName: "", contactPhone: "" };

function renderOnboarding() {
  document.body.classList.add("no-tabbar");
  $("#topbar").style.display = "none";
  const feature = (emoji, text) => `<div class="feature"><span class="ico">${emoji}</span><span>${text}</span></div>`;
  const pages = [
    `<div class="big">🌙</div><h2>Justiciero</h2>
     <p style="font-size:1.15rem" class="muted">Un programa de 12 meses para convertirte en alguien que protege a los demás por la noche. De verdad.</p>
     <div class="stack" style="gap:12px">
       ${feature("💪", "Entrenamiento progresivo, empezando en casa")}${feature("⛑️", "Primeros auxilios, la habilidad que más vidas salva")}
       ${feature("⚖️", "Lo que la ley te permite y lo que no")}${feature("👁️", "Observación y memoria de detective")}
       ${feature("🎭", "Simulador de situaciones reales")}${feature("🛡️", "Del entrenamiento al servicio real")}</div>`,
    `<div class="big">💬</div><h2>La verdad sobre Batman</h2>
     <p style="font-size:1.15rem" class="muted">En la vida real, un justiciero enmascarado que pega a delincuentes acaba herido, detenido o las dos cosas.</p>
     ${callout("danger", "Nada de armas, persecuciones, máscaras ni «dar lecciones».")}
     ${callout("tip", "Lo que sí funciona: estar en forma, saber primeros auxilios, ser un testigo excelente, saber desescalar y unirte a quienes ya protegen la ciudad de noche (Protección Civil, Cruz Roja, emergencias...).")}
     <p class="small muted">Esta app te convierte en ese tipo de héroe. El que llega a casa entero y ha ayudado de verdad.</p>`,
    `<div class="big">❤️</div><h2>Antes de empezar</h2>
     <p style="font-size:1.15rem" class="muted">Unas reglas para que esto sea seguro.</p>
     <div class="stack" style="gap:12px">
       ${feature("🩺", "Si tienes alguna condición de salud, consulta a tu médico antes de entrenar.")}
       ${feature("🏠", "Las primeras semanas son en casa. La calle llega cuando estés preparado.")}
       ${feature("🥋", "Las artes marciales se aprenden con instructor, no con vídeos.")}
       ${feature("📞", "Ante cualquier peligro: distancia y 112.")}</div>
     <label class="switch card"><span class="small">Entiendo que esta app no sustituye a la formación presencial ni me autoriza a intervenir en situaciones peligrosas.</span>
       <input type="checkbox" data-onb="accepted" ${onb.accepted ? "checked" : ""}></label>`,
    `<div class="big">🦇</div><h2>Tu identidad</h2>
     <p style="font-size:1.15rem" class="muted">Todo se guarda solo en tu iPhone.</p>
     <div class="field"><label>Tu alias de vigilante</label><input type="text" data-onb="alias" value="${esc(onb.alias)}" autocomplete="off"></div>
     <label class="switch"><span>Soy mayor de edad</span><input type="checkbox" data-onb="isAdult" ${onb.isAdult ? "checked" : ""}></label>
     <div id="minor-note">${onb.isAdult ? "" : callout("info", "Perfecto, puedes hacer el programa. Las partes de calle se adaptan: siempre de día o con un adulto, y el voluntariado a través de programas juveniles.")}</div>
     <p class="small muted">Tu «Alfred»: alguien de confianza que siempre sepa dónde estás (opcional, puedes añadirlo después).</p>
     <div class="field"><label>Nombre</label><input type="text" data-onb="contactName" value="${esc(onb.contactName)}"></div>
     <div class="field"><label>Teléfono</label><input type="tel" data-onb="contactPhone" value="${esc(onb.contactPhone)}"></div>`,
  ];
  $("#app").innerHTML = `<div class="onb">
    <div class="stack grow" style="gap:18px">${pages[onb.page]}</div>
    <div class="dots">${pages.map((_, i) => `<span class="${i === onb.page ? "on" : ""}"></span>`).join("")}</div>
    <div class="row">${onb.page ? `<button class="btn ghost" style="width:auto;padding:14px 20px" data-act="onb-back">Atrás</button>` : ""}
      <button class="btn" id="onb-next" data-act="onb-next">${onb.page < 3 ? "Siguiente" : "Empezar en La Cueva"}</button></div>
  </div>`;
  updateOnbButton();
}

function onbCanContinue() {
  if (onb.page === 2) return onb.accepted;
  if (onb.page === 3) return onb.alias.trim().length > 0;
  return true;
}
function updateOnbButton() {
  const b = $("#onb-next");
  if (b) b.disabled = !onbCanContinue();
}

/* ---------- Router y render ---------- */

const TABS = [
  ["#/base", "🌙", "Base"], ["#/programa", "🗺️", "Programa"], ["#/entreno", "💪", "Entreno"],
  ["#/academia", "📚", "Academia"], ["#/mas", "☰", "Más"],
];

const ROUTES = [
  [/^#\/base$/, viewBase],
  [/^#\/programa$/, viewProgram],
  [/^#\/entreno$/, viewTraining],
  [/^#\/academia$/, viewAcademy],
  [/^#\/mas$/, viewMore],
  [/^#\/fase\/(\d+)$/, viewPhase],
  [/^#\/entreno\/([\w-]+)$/, viewWorkout],
  [/^#\/sesion\/([\w-]+)$/, viewSession],
  [/^#\/test$/, viewTest],
  [/^#\/modulo\/([\w-]+)$/, viewModule],
  [/^#\/leccion\/([\w-]+)\/([\w-]+)$/, viewLesson],
  [/^#\/codigo$/, viewCode],
  [/^#\/escenarios$/, viewScenarios],
  [/^#\/escenario\/([\w-]+)$/, viewScenario],
  [/^#\/kim$/, viewKim],
  [/^#\/salida$/, viewOuting],
  [/^#\/emergencias$/, viewEmergency],
  [/^#\/equipo$/, viewGear],
  [/^#\/rangos$/, viewRanks],
  [/^#\/aviso$/, viewAbout],
  [/^#\/instalar$/, viewInstall],
  [/^#\/bitacora(?:\/(\w+))?$/, viewJournal],
  [/^#\/bitacora-nueva\/(\w+)$/, viewJournalNew],
  [/^#\/perfil$/, viewProfile],
];

function tabFor(hash) {
  const map = { fase: "#/programa", entreno: "#/entreno", sesion: "#/entreno", test: "#/entreno", modulo: "#/academia", leccion: "#/academia",
    codigo: "#/academia", escenarios: "#/academia", escenario: "#/academia", kim: "#/academia" };
  const key = hash.split("/")[1];
  return TABS.find(([h]) => h === hash)?.[0] || map[key] || "#/mas";
}

let lastHash = null;

function render() {
  if (!state.profile.onboarded) return renderOnboarding();
  $("#topbar").style.display = "";
  const hash = location.hash || "#/base";
  let view = null;
  for (const [re, fn] of ROUTES) {
    const m = hash.match(re);
    if (m) { view = fn(...m.slice(1)); break; }
  }
  if (!view) { location.replace("#/base"); return; }

  if (hash !== lastHash && !hash.startsWith("#/sesion")) session = null;
  if (hash !== lastHash && !hash.startsWith("#/escenario/")) scenarioPlay = null;
  if (hash !== lastHash && hash !== "#/kim") kim = { stage: "menu", hard: kim.hard };

  const top = $("#topbar");
  top.className = `topbar${view.back ? "" : " large"}`;
  top.innerHTML = `${view.back ? `<button class="back" data-act="back" data-href="${view.back}">Atrás</button>` : ""}<h1>${esc(view.title)}</h1>${view.action || ""}`;
  document.body.classList.toggle("no-tabbar", !!view.hideTabs);
  const active = tabFor(hash);
  $("#tabbar").innerHTML = TABS.map(([h, emoji, label]) =>
    `<button class="tab ${h === active ? "active" : ""}" data-act="tab" data-href="${h}"><span class="ico">${emoji}</span>${label}</button>`).join("");

  const scrollY = hash === lastHash ? window.scrollY : 0;
  $("#app").innerHTML = view.html;
  window.scrollTo(0, scrollY);
  lastHash = hash;
}

/* ---------- Acciones ---------- */

function shuffle(a) {
  for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; }
  return a;
}

let audioCtx = null;
function beep(times = 1) {
  try {
    audioCtx = audioCtx || new (window.AudioContext || window.webkitAudioContext)();
    if (audioCtx.state === "suspended") audioCtx.resume();
    for (let i = 0; i < times; i++) {
      const osc = audioCtx.createOscillator(), gain = audioCtx.createGain();
      osc.frequency.value = 880;
      gain.gain.value = 0.15;
      osc.connect(gain).connect(audioCtx.destination);
      const t = audioCtx.currentTime + i * 0.25;
      osc.start(t);
      osc.stop(t + 0.15);
    }
  } catch (e) { /* sin audio */ }
}

let wakeLock = null;
async function requestWakeLock() {
  try { if ("wakeLock" in navigator && !wakeLock) wakeLock = await navigator.wakeLock.request("screen"); wakeLock?.addEventListener?.("release", () => { wakeLock = null; }); } catch (e) { /* no soportado */ }
}

const ACTIONS = {
  tab: (d) => { location.hash = d.href; },
  back: (d) => { location.hash = d.href; },
  expand: (d, el) => el.querySelector("p.small").classList.toggle("clamp"),
  "toggle-task": (d) => commit((s) => {
    const i = s.completedTasks.indexOf(d.id);
    if (i >= 0) { s.completedTasks.splice(i, 1); s.xp = Math.max(0, s.xp - XP.task); }
    else { s.completedTasks.push(d.id); gainXP(XP.task); markActive(); }
  }),
  "session-toggle": () => { session.running = !session.running; beep(0); render(); },
  "session-done": () => { sessionFinishSet(); render(); },
  "session-skip": () => { sessionAdvance(); render(); },
  "session-save": () => {
    if (session.saved) return;
    session.saved = true;
    const w = session.w, minutes = Math.max(1, Math.round((Date.now() - session.start) / 60000));
    commit((s) => { s.workouts.unshift({ id: crypto.randomUUID?.() || String(Date.now()), date: Date.now(), workoutID: w.id, name: w.name, minutes }); gainXP(XP.workout); markActive(); }, false);
    location.hash = "#/entreno";
  },
  step: (d, el) => {
    const input = el.closest("form").querySelector(`[name="${d.target}"]`);
    input.value = Math.max(0, (parseInt(input.value, 10) || 0) + Number(d.step));
  },
  "lesson-done": (d) => {
    const m = MODULES.find((x) => x.id === d.mid);
    if (!state.completedLessons.includes(d.lid)) commit((s) => { s.completedLessons.push(d.lid); gainXP(XP.lesson); markActive(); }, false);
    location.hash = `#/modulo/${m.id}`;
  },
  "scenario-pick": (d) => {
    const s = SCENARIOS.find((x) => x.id === scenarioPlay.id);
    const i = Number(d.i), score = s.options[i].score;
    scenarioPlay.selected = i;
    commit((st) => {
      const best = st.scenarioBest[s.id];
      markActive();
      if (best === undefined || score > best) {
        st.scenarioBest[s.id] = score;
        scenarioPlay.gained = Math.max(0, score - (best || 0)) * XP.scenarioPerPoint;
        gainXP(scenarioPlay.gained);
      }
    });
  },
  "scenario-retry": () => { scenarioPlay = null; render(); },
  "kim-level": (d) => { kim.hard = d.hard === "1"; render(); },
  "kim-start": () => { kimStart(); render(); },
  "kim-recall": () => { kim.stage = "recall"; render(); },
  "kim-pick": (d) => {
    const i = kim.picks.indexOf(d.e);
    if (i >= 0) kim.picks.splice(i, 1); else kim.picks.push(d.e);
    render();
  },
  "kim-check": () => kimFinish(),
  "kim-menu": () => { kim = { stage: "menu", hard: kim.hard }; render(); },
  "outing-check": (d) => { const i = Number(d.i); outingChecks.has(i) ? outingChecks.delete(i) : outingChecks.add(i); render(); },
  "outing-interval": (d) => { outingInterval = Number(d.v); render(); },
  "outing-start": () => {
    if ("Notification" in window && Notification.permission === "default") Notification.requestPermission();
    beep(0);
    outingAlerted = false;
    commit((s) => { s.outing = { started: Date.now(), interval: outingInterval, end: Date.now() + outingInterval * 60000 }; });
    if (state.profile.contactPhone) {
      location.href = smsLink(state.profile.contactPhone, `Salgo ahora. Te aviso cuando vuelva. Si no sabes nada de mí en ${outingInterval * 2} minutos, llámame.`);
    }
  },
  "outing-checkin": () => {
    outingAlerted = false;
    commit((s) => { s.outing.end = Date.now() + s.outing.interval * 60000; });
    toast("Check-in hecho");
  },
  "outing-finish": () => {
    outingChecks = new Set();
    commit((s) => { s.outing = null; }, false);
    location.hash = "#/bitacora-nueva/salida";
  },
  "journal-delete": (d) => { if (confirm("¿Borrar esta entrada?")) commit((s) => { s.journal = s.journal.filter((e) => e.id !== d.id); }); },
  mood: (d, el) => {
    el.parentElement.querySelectorAll("button").forEach((b) => b.classList.toggle("on", b === el));
    el.closest("form").querySelector('[name="mood"]').value = d.v;
  },
  metric: (d) => { metric = d.m; render(); },
  export: () => {
    const blob = new Blob([JSON.stringify(state, null, 2)], { type: "application/json" });
    const a = document.createElement("a");
    a.href = URL.createObjectURL(blob);
    a.download = `justiciero-${dayKey()}.json`;
    a.click();
    setTimeout(() => URL.revokeObjectURL(a.href), 1000);
  },
  reset: () => { if (confirm("¿Borrar todo tu progreso? No se puede deshacer.")) { state = defaultState(); save(); location.hash = "#/base"; render(); } },
  "onb-back": () => { onb.page--; renderOnboarding(); },
  "onb-next": () => {
    if (!onbCanContinue()) return;
    if (onb.page < 3) { onb.page++; renderOnboarding(); window.scrollTo(0, 0); return; }
    commit((s) => {
      Object.assign(s.profile, { alias: onb.alias.trim(), isAdult: onb.isAdult, contactName: onb.contactName.trim(), contactPhone: onb.contactPhone.trim(), startDate: Date.now(), onboarded: true });
    }, false);
    location.hash = "#/base";
    render();
  },
};

document.addEventListener("click", (e) => {
  const el = e.target.closest("[data-act]");
  if (!el || el.tagName === "INPUT" || el.tagName === "SELECT") return;
  const fn = ACTIONS[el.dataset.act];
  if (!fn) return;
  if (el.tagName === "BUTTON") e.preventDefault();
  fn(el.dataset, el);
});

document.addEventListener("input", (e) => {
  const key = e.target.dataset.onb;
  if (!key) return;
  onb[key] = e.target.type === "checkbox" ? e.target.checked : e.target.value;
  if (key === "isAdult") {
    $("#minor-note").innerHTML = onb.isAdult ? "" : callout("info", "Perfecto, puedes hacer el programa. Las partes de calle se adaptan: siempre de día o con un adulto, y el voluntariado a través de programas juveniles.");
  }
  updateOnbButton();
});

document.addEventListener("change", (e) => {
  const t = e.target;
  if (t.dataset.act === "journal-kind") {
    const k = JOURNAL_KINDS[t.value];
    const form = t.closest("form");
    form.querySelector('[name="notes"]').placeholder = k.prompt;
    form.querySelector('[name="title"]').placeholder = k.label;
  }
  if (t.dataset.act === "import" && t.files[0]) {
    t.files[0].text().then((text) => {
      const data = JSON.parse(text);
      if (!data.profile || !Array.isArray(data.completedTasks)) throw new Error("formato");
      if (!confirm("Esto sustituirá tu progreso actual por el de la copia. ¿Continuar?")) return;
      state = Object.assign(defaultState(), data);
      save();
      toast("Copia restaurada");
      render();
    }).catch(() => alert("El archivo no es una copia de seguridad válida de Justiciero."));
  }
});

document.addEventListener("submit", (e) => {
  const form = e.target;
  e.preventDefault();
  const f = new FormData(form);
  const num = (k) => Math.max(0, parseInt(f.get(k), 10) || 0);
  if (form.dataset.form === "test") {
    commit((s) => {
      s.tests.push({ id: String(Date.now()), date: Date.now(), pushups: num("pushups"), squats: num("squats"), plankSeconds: num("plank"), burpees: num("burpees"), run5kMinutes: f.get("hasRun") ? num("run") : null });
      gainXP(XP.test);
      markActive();
    }, false);
    history.length > 1 ? history.back() : (location.hash = "#/perfil");
  } else if (form.dataset.form === "journal") {
    const kind = f.get("kind");
    commit((s) => {
      s.journal.unshift({ id: String(Date.now()), date: Date.now(), kind, title: String(f.get("title")).trim() || JOURNAL_KINDS[kind].label, notes: String(f.get("notes")).trim(), mood: Number(f.get("mood")) || 3 });
      gainXP(XP.journal);
      markActive();
    }, false);
    location.hash = "#/bitacora";
  } else if (form.dataset.form === "profile") {
    commit((s) => {
      Object.assign(s.profile, { alias: String(f.get("alias")).trim() || s.profile.alias, isAdult: f.get("isAdult") === "on", contactName: String(f.get("contactName")).trim(), contactPhone: String(f.get("contactPhone")).trim() });
    });
    toast("Perfil guardado");
  }
});

window.addEventListener("hashchange", render);
document.addEventListener("visibilitychange", () => {
  if (document.visibilityState === "visible") {
    if (session) requestWakeLock();
    outingTick();
    if (location.hash === "#/salida") render();
  }
});

setInterval(() => {
  if (session && location.hash.startsWith("#/sesion")) sessionTick();
  if (kim.stage === "memorize" && location.hash === "#/kim") {
    kim.countdown--;
    if (kim.countdown <= 0) kim.stage = "recall";
    render();
  }
  outingTick();
}, 1000);

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => navigator.serviceWorker.register("sw.js").catch(() => {}));
}

render();
