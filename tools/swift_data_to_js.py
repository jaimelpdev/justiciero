#!/usr/bin/env python3
"""Convierte el contenido de Justiciero/Data/*.swift en web/data.js.

El contenido (fases, entrenos, lecciones, escenarios...) vive en un solo sitio:
los ficheros Swift. Este script lo traduce a JavaScript para la versión web
(PWA), así ambas versiones no se desincronizan.

Uso:  python3 tools/swift_data_to_js.py
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "Justiciero" / "Data"
OUT = ROOT / "web" / "data.js"

# Tipos con argumentos etiquetados -> objetos JS.
OBJECT_TYPES = {"Phase", "Exercise", "Workout", "WorkoutBlock", "SkillModule", "Lesson",
                "Scenario", "ScenarioOption", "CodeRule", "GearItem", "Technique", "Belt", "DojoRound"}


def convert_literals(src: str) -> str:
    """Traduce literales Swift a JS respetando el contenido de las cadenas."""
    out = []
    stack = []
    i = 0
    n = len(src)
    while i < n:
        c = src[i]
        if c == '"':
            j = i + 1
            while src[j] != '"':
                j += 2 if src[j] == "\\" else 1
            out.append(src[i:j + 1])
            i = j + 1
            continue
        m = re.match(r"([A-Z]\w*)\(", src[i:])
        if m and (i == 0 or not (src[i - 1].isalnum() or src[i - 1] in "._")):
            name = m.group(1)
            if name in OBJECT_TYPES:
                out.append("{")
                stack.append("}")
            elif name == "ProgramTask":
                out.append("T(")
                stack.append(")")
            else:
                raise ValueError(f"Tipo desconocido: {name}")
            i += len(m.group(0))
            continue
        m = re.match(r"\.(\w+)\(", src[i:])
        if m and (i == 0 or not src[i - 1].isalnum()):
            out.append(f'B("{m.group(1)}", ')
            stack.append(")")
            i += len(m.group(0))
            continue
        m = re.match(r"\.([a-z]\w*)", src[i:])
        if m and (i == 0 or not (src[i - 1].isalnum() or src[i - 1] == ")")):
            out.append(f'"{m.group(1)}"')
            i += len(m.group(0))
            continue
        if c == "(":
            out.append("(")
            stack.append(")")
        elif c == ")":
            out.append(stack.pop())
        else:
            out.append(c)
        i += 1
    js = "".join(out)
    js = re.sub(r"\b(\d+)\.\.\.(\d+)\b", r"[\1, \2]", js)
    js = re.sub(r"\bnil\b", "null", js)
    js = js.replace("Exercises.", "")
    return js


def extract_statics(src: str) -> str:
    """`static let x: T = valor` / `static let x = valor` -> `const x = valor;`"""
    src = re.sub(r"^\s*//.*$", "", src, flags=re.M)
    src = re.sub(r"(?:private )?static let (\w+)(?::\s*\[\w+\])?\s*=", r"const \1 =", src)
    return src


def body_of(src: str, header: str) -> str:
    """Devuelve el contenido entre llaves del bloque `header {`."""
    start = src.index(header)
    i = src.index("{", start) + 1
    depth = 1
    j = i
    while depth:
        ch = src[j]
        if ch == '"':
            j += 1
            while src[j] != '"':
                j += 2 if src[j] == "\\" else 1
        elif ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
        j += 1
    return src[i:j - 1]


def module(src: str, header: str, export: str = "all") -> str:
    body = convert_literals(extract_statics(body_of(src, header)))
    # `all` se declara antes que las constantes que usa: se pospone su evaluación.
    body = re.sub(r"const all =", "const all = () =>", body)
    return f"(() => {{{body}\n  return {export}();\n}})()"


def main():
    program = (DATA / "ProgramData.swift").read_text()
    workouts = (DATA / "WorkoutData.swift").read_text()
    academy = (DATA / "AcademyData.swift").read_text()
    scenarios = (DATA / "ScenarioData.swift").read_text()
    dojo = (DATA / "DojoData.swift").read_text()

    tips_body = body_of(program, "enum DailyTips")
    tips = re.search(r"static let all: \[String\] = (\[.*?\])\n", tips_body, re.S).group(1)

    exercises = convert_literals(extract_statics(body_of(workouts, "enum Exercises")))

    parts = [
        "// Generado por tools/swift_data_to_js.py a partir de Justiciero/Data/*.swift. No editar a mano.",
        "const T = (id, week, category, title, detail) => ({ id, week, category, title, detail });",
        "const B = (type, value) => ({ type, value });",
        f"const PHASES = {module(program, 'extension Phase')};",
        f"const WORKOUTS = (() => {{{exercises}\n" + module(workouts, "extension Workout")[len("(() => {"):] + ";",
        f"const MODULES = {module(academy, 'extension SkillModule')};",
        f"const SCENARIOS = {module(scenarios, 'extension Scenario')};",
        f"const CODE_RULES = {module(scenarios, 'extension CodeRule')};",
        f"const GEAR = {module(scenarios, 'extension GearItem')};",
        f"const TIPS = {tips};",
        "const DOJO = (() => {" + convert_literals(extract_statics(body_of(dojo, "enum Dojo")))
        + "\n  return { intro, honesty, setup, numbering, safety };\n})();",
        f"const TECHNIQUES = {module(dojo, 'extension Technique')};",
        f"const BELTS = {module(dojo, 'extension Belt')};",
    ]
    OUT.parent.mkdir(exist_ok=True)
    OUT.write_text("\n\n".join(parts) + "\n")
    print(f"Escrito {OUT.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
