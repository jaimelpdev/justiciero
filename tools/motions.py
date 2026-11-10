#!/usr/bin/env python3
"""Genera Justiciero/Data/MotionData.swift: las animaciones de cada ejercicio.

Cada animación es una figura de 11 puntos vista de lado (mirando a la derecha) en un
lienzo de 100 × 100 (y hacia abajo, suelo en y = 92). Los fotogramas clave se describen
con posiciones de cadera, ángulo del tronco y extremidades (por ángulos o por el punto
al que llegan, con cinemática inversa). La app interpola entre fotogramas en bucle.

Ángulos: 0 = hacia abajo, 90 = hacia delante (derecha), 180 = hacia arriba, -90 = hacia atrás.

Uso:  python3 tools/motions.py
"""
import math
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "Justiciero" / "Data" / "MotionData.swift"

TORSO, NECK, UPPER, FORE, THIGH, SHIN = 27, 8, 14, 13, 18, 18
FLOOR = 92


def vec(angle, length):
    r = math.radians(angle)
    return (math.sin(r) * length, math.cos(r) * length)


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def limb(root, spec, l1, l2):
    """spec: ("a", ángulo1, ángulo2) o ("t", (x, y), lado) con lado = 1 o -1."""
    if spec[0] == "a":
        joint = add(root, vec(spec[1], l1))
        return joint, add(joint, vec(spec[2], l2))
    _, target, bend = spec
    dx, dy = target[0] - root[0], target[1] - root[1]
    d = max(abs(l1 - l2) + 0.01, min(l1 + l2 - 0.01, math.hypot(dx, dy)))
    base = math.atan2(dy, dx)
    a = math.acos((l1 * l1 + d * d - l2 * l2) / (2 * l1 * d))
    joint = (root[0] + l1 * math.cos(base + bend * a), root[1] + l1 * math.sin(base + bend * a))
    end = (root[0] + d * math.cos(base), root[1] + d * math.sin(base))
    return joint, end


def pose(hip, torso=180, na=("a", 0, 0), fa=("a", 0, 0), nl=("a", 0, 0), fl=("a", 0, 0), head=None):
    sh = add(hip, vec(torso, TORSO))
    hd = add(sh, vec(torso if head is None else head, NECK))
    ne, nh = limb(sh, na, UPPER, FORE)
    fe, fh = limb(sh, fa, UPPER, FORE)
    nk, nf = limb(hip, nl, THIGH, SHIN)
    fk, ff = limb(hip, fl, THIGH, SHIN)
    return [hd, sh, hip, ne, nh, fe, fh, nk, nf, fk, ff]


def grounded(points, x_index=None, x=None):
    """Baja la figura hasta que su punto más bajo toque el suelo (y la centra si se pide)."""
    lowest = max(max(p[1] for p in points[1:]), points[0][1] + 4)
    dy = FLOOR - lowest
    dx = 0 if x_index is None else x - points[x_index][0]
    return [(p[0] + dx, p[1] + dy) for p in points]


def flat(points):
    return [round(c, 1) for p in points for c in p]


# Índices: 0 cabeza, 1 hombro, 2 cadera, 3-4 codo/mano cerca, 5-6 codo/mano lejos,
# 7-8 rodilla/pie cerca, 9-10 rodilla/pie lejos.
H, SH, HIP, NE, NH, FE, FH, NK, NF, FK, FF = range(11)

KNEE_FWD, KNEE_BACK = -1, 1  # lado de la rodilla en la cinemática inversa
ELBOW_BACK, ELBOW_FWD = 1, -1


def stand(x=50, arms=(0, 0), farms=None, lean=180):
    farms = farms or (arms[0] - 6, arms[1] - 6)
    return grounded(pose((x, 56), lean, ("a", *arms), ("a", *farms), ("a", 2, 2), ("a", -4, -4)))


def squat(x=50, depth=1.0, arms=(90, 90)):
    hip_y = 56 + 22 * depth
    hip = (x - 12 * depth, hip_y)
    p = pose(hip, 180 - 40 * depth, ("a", *arms), ("a", arms[0] - 5, arms[1] - 5),
             ("t", (x + 2, FLOOR), KNEE_FWD), ("t", (x - 1, FLOOR), KNEE_FWD))
    return p


def front(x=50, arm=0, leg=4, hip_y=56, elbow=0):
    """Vista de frente: brazos y piernas simétricos (para jacks y similares)."""
    return pose((x, hip_y), 180, ("a", arm, arm + elbow), ("a", -arm, -arm - elbow),
                ("a", leg, leg), ("a", -leg, -leg))


MOTIONS = []


def motion(mid, seconds, exercises, frames, props=()):
    MOTIONS.append((mid, seconds, exercises, [flat(f) for f in frames], [round(v, 1) for v in props]))


CHAIR = (62, 74, 80, 74, 80, 74, 80, 92, 62, 74, 62, 92)
WALL_BAR = (20, 14, 80, 14)

# --- De pie ---
motion("jacks", 1.2, ["jacks"], [front(arm=8, leg=4), front(arm=160, leg=22, elbow=10)])
motion("squat", 2.4, ["squat", "squat-pause"], [stand(arms=(90, 90)), squat()])
motion("sit-stand", 2.6, ["sit-stand"], [stand(x=48, arms=(90, 90)), squat(x=48, depth=0.8)], props=(28, 72, 40, 72, 30, 72, 30, 92))
motion("squat-jump", 1.6, ["squat-jump"], [squat(depth=0.8, arms=(-30, -20)),
                                          [(p[0], p[1] - 14) for p in pose((50, 56), 180, ("a", 170, 175), ("a", 165, 170), ("a", 2, -4), ("a", -2, -6))],
                                          squat(depth=0.8, arms=(90, 90))])


def lunge(x=50, depth=1.0, back=True):
    hip = (x, 56 + 14 * depth)
    return pose(hip, 180, ("a", 4, 4), ("a", -4, -4),
                ("t", (x + 16, FLOOR), KNEE_FWD), ("t", (x - 22, FLOOR - 2), KNEE_FWD))


motion("lunge", 2.4, ["lunge", "lunge-back"], [stand(), grounded(lunge())])


def bulgarian(depth):
    hip = (46, 58 + 14 * depth)
    return pose(hip, 175, ("a", 4, 4), ("a", -4, -4), ("t", (60, FLOOR), KNEE_FWD), ("t", (24, 74), KNEE_FWD))


motion("bulgarian", 2.4, ["bulgarian"], [bulgarian(0), bulgarian(1)], props=(14, 74, 30, 74, 16, 74, 16, 92, 28, 74, 28, 92))


def pistol(depth):
    hip = (40 - 6 * depth, 56 + 18 * depth)
    return pose(hip, 180 - 35 * depth, ("a", 90, 90), ("a", 85, 85),
                ("t", (44, FLOOR), KNEE_FWD), ("a", 60 + 25 * depth, 70 + 20 * depth))


motion("pistol", 2.8, ["pistol-box"], [pistol(0), pistol(1)], props=(18, 72, 32, 72, 20, 72, 20, 92, 30, 72, 30, 92))


def step_up(up):
    if up:
        return pose((60, 40), 180, ("a", 10, 20), ("a", -10, -15), ("t", (64, 74), KNEE_FWD), ("a", 10, -20))
    return pose((44, 56), 180, ("a", -10, -15), ("a", 10, 20), ("t", (62, 74), KNEE_FWD), ("t", (40, FLOOR), KNEE_FWD))


motion("stepup", 2.4, ["stepup"], [step_up(False), step_up(True)], props=(54, 74, 80, 74, 54, 74, 54, 92, 80, 74, 80, 92))


def march(side):
    knee_up = ("a", 90, 0)
    down = ("a", 0, 0)
    return grounded(pose((50, 56), 180, ("a", -40 if side else 40, 60 if side else 120),
                         ("a", 40 if side else -40, 120 if side else 60),
                         knee_up if side else down, down if side else knee_up), H, 50 + 1.6)


motion("march", 1.0, ["march"], [march(True), march(False)])


def run(phase, speed=1.0):
    a = 35 * speed
    frames = [
        (("a", -a, 40), ("a", a, 110), ("a", 35 * speed, -5), ("a", -25 * speed, -70)),
        (("a", 0, 80), ("a", 0, 80), ("a", 0, -10), ("a", 10, -90)),
        (("a", a, 110), ("a", -a, 40), ("a", -25 * speed, -70), ("a", 35 * speed, -5)),
        (("a", 0, 80), ("a", 0, 80), ("a", 10, -90), ("a", 0, -10)),
    ][phase]
    return grounded(pose((50, 56), 172, frames[0], frames[1], frames[2], frames[3]), HIP, 50)


motion("run", 0.8, ["jog", "strides", "jog-warm"], [run(i) for i in range(4)])


def walk(phase):
    frames = [
        (("a", -20, -10), ("a", 20, 30), ("a", 22, 18), ("a", -18, -22)),
        (("a", 0, 5), ("a", 0, 5), ("a", 0, 0), ("a", 5, -30)),
        (("a", 20, 30), ("a", -20, -10), ("a", -18, -22), ("a", 22, 18)),
        (("a", 0, 5), ("a", 0, 5), ("a", 5, -30), ("a", 0, 0)),
    ][phase]
    return grounded(pose((50, 56), 180, *frames), HIP, 50)


motion("walk", 1.2, ["walk", "balance"], [walk(i) for i in range(4)])


def guard(jab=None, duck=0.0, x=50):
    near = ("a", 30, 165) if jab != "near" else ("a", 95, 92)
    far = ("a", 20, 160) if jab != "far" else ("a", 92, 90)
    hip = (x, 58 + 6 * duck)
    return pose(hip, 172 - 14 * duck, near, far, ("t", (x + 10, FLOOR), KNEE_FWD), ("t", (x - 12, FLOOR), KNEE_FWD), head=172 - 20 * duck)


motion("shadow", 1.4, ["shadow"], [guard(), guard("near"), guard(), guard("far")])
motion("slips", 1.6, ["slips"], [guard(), guard(duck=1.0), guard(), guard(duck=0.6, x=46)])


def knee_strike(up):
    if up:
        return pose((50, 58), 172, ("a", 60, 10), ("a", 55, 5), ("t", (46, FLOOR), KNEE_FWD), ("a", 110, 0))
    return pose((50, 58), 172, ("a", 120, 150), ("a", 115, 145), ("t", (58, FLOOR), KNEE_FWD), ("t", (40, FLOOR), KNEE_FWD))


motion("knees", 1.2, ["knees"], [knee_strike(False), knee_strike(True)])


def skater(side):
    s = 1 if side else -1
    return grounded(pose((50 + 12 * s, 60), 180 - 10 * s, ("a", 60 * s, 80 * s), ("a", -30 * s, -20 * s),
                         ("a", 8 * s, 0), ("a", -25 * s, -50 * s)), HIP, 50 + 12 * s)


motion("skaters", 1.2, ["skaters"], [skater(True), skater(False)])


def broad_jump(stage):
    if stage == 0:
        return squat(x=34, depth=0.7, arms=(-40, -30))
    if stage == 1:
        return [(p[0], p[1] - 10) for p in pose((52, 56), 165, ("a", 150, 160), ("a", 145, 155), ("a", 40, -10), ("a", 30, -20))]
    return squat(x=70, depth=0.7, arms=(90, 90))


motion("precision", 1.8, ["precision"], [broad_jump(0), broad_jump(1), broad_jump(2), stand(x=70)])
motion("breath", 8.0, ["breath"], [stand(arms=(10, 10)), stand(arms=(40, 60))])
motion("mobility", 2.4, ["mobility"], [stand(arms=(a, a), farms=(a + 180, a + 180)) for a in (0, 90, 180, 270)])

# --- Bisagra y estiramientos ---


def rdl(depth):
    hip = (50, 56)
    return pose(hip, 180 - 85 * depth, ("a", 0, 0), ("a", 0, 0), ("t", (52, FLOOR), KNEE_FWD), ("a", -80 * depth, -80 * depth - 5 * (1 - depth)))


motion("rdl", 2.6, ["rdl-single"], [grounded(rdl(0), NF, 52), grounded(rdl(1), NF, 52)])


def hip_stretch(push):
    hip = (46 + 4 * push, 70)
    return pose(hip, 180, ("a", 0, 0), ("a", 0, 0), ("t", (66, FLOOR), KNEE_FWD), ("t", (20, FLOOR), KNEE_BACK))


motion("hip", 3.0, ["hip"], [hip_stretch(0), hip_stretch(1)])


def hamstring(fold):
    hip = (34, 88)
    return pose(hip, 180 - 70 * fold, ("a", 90, 90), ("a", 88, 88), ("a", 90, 90), ("a", 92, 92))


motion("hamstring", 4.0, ["hamstring"], [hamstring(0.2), hamstring(1)])

# --- Suelo: empuje ---


def line_body(anchor, height, length, anchor_left=True):
    """Punto a `length` del ancla, a `height` sobre el suelo, hacia la derecha."""
    dy = (FLOOR - height) - anchor[1]
    dx = math.sqrt(max(1.0, length * length - dy * dy))
    return (anchor[0] + dx, FLOOR - height)


def straight(shoulder, feet, arms=None, fa=None, head=None):
    """Cuerpo recto de los pies a los hombros."""
    dx, dy = feet[0] - shoulder[0], feet[1] - shoulder[1]
    d = math.hypot(dx, dy)
    hip = (shoulder[0] + dx / d * TORSO, shoulder[1] + dy / d * TORSO)
    torso = math.degrees(math.atan2(shoulder[0] - hip[0], shoulder[1] - hip[1]))
    hand = (shoulder[0] + 2, FLOOR)
    arms = arms or ("t", hand, ELBOW_BACK)
    fa = fa or ("t", (hand[0] - 1, hand[1]), ELBOW_BACK)
    leg = ("t", feet, KNEE_FWD)
    return pose(hip, torso, arms, fa, leg, ("t", (feet[0] + 0.5, feet[1]), KNEE_FWD), head=head)


FEET = (12, FLOOR)
HIGH = line_body(FEET, 27, TORSO + THIGH + SHIN)


def plank_line(height=27, hands=None):
    sh = line_body(FEET, height, TORSO + THIGH + SHIN)
    hand = (HIGH[0] + 2, FLOOR) if hands is None else hands
    return straight(sh, FEET, ("t", hand, ELBOW_BACK), ("t", (hand[0] - 1, hand[1]), ELBOW_BACK))


def knee_plank(height):
    knee = (34, FLOOR - 2)
    sh = line_body(knee, height, TORSO + THIGH)
    hand = (line_body(knee, 27, TORSO + THIGH)[0] + 2, FLOOR)
    dx, dy = knee[0] - sh[0], knee[1] - sh[1]
    d = math.hypot(dx, dy)
    hip = (sh[0] + dx / d * TORSO, sh[1] + dy / d * TORSO)
    torso = math.degrees(math.atan2(sh[0] - hip[0], sh[1] - hip[1]))
    p = pose(hip, torso, ("t", hand, ELBOW_BACK), ("t", (hand[0] - 1, FLOOR), ELBOW_BACK), ("t", knee, KNEE_FWD), ("t", knee, KNEE_FWD))
    p[NK] = knee
    p[FK] = knee
    p[NF] = add(knee, vec(-120, SHIN))
    p[FF] = add(knee, vec(-124, SHIN))
    return p


motion("pushup", 2.0, ["pushup", "pushup-diamond", "pushup-archer"], [plank_line(27), plank_line(9)])
motion("pushup-knee", 2.0, ["pushup-knee"], [knee_plank(27), knee_plank(9)])

TABLE_Y = 62


def incline(low):
    feet = (16, FLOOR)
    hand = (74, TABLE_Y)
    sh = line_body(feet, FLOOR - TABLE_Y + 24 - 14 * low, TORSO + THIGH + SHIN)
    return straight(sh, feet, ("t", hand, ELBOW_BACK), ("t", (73, TABLE_Y), ELBOW_BACK))


motion("pushup-incline", 2.0, ["pushup-incline"], [incline(0), incline(1)], props=(66, 62, 92, 62, 88, 62, 88, 92))


def decline(low):
    feet = (16, 72)
    sh = line_body(feet, 27 - 17 * low, TORSO + THIGH + SHIN)
    hand = (line_body(feet, 27, TORSO + THIGH + SHIN)[0] + 2, FLOOR)
    return straight(sh, feet, ("t", hand, ELBOW_BACK), ("t", (hand[0] - 1, FLOOR), ELBOW_BACK))


motion("pushup-decline", 2.0, ["pushup-decline"], [decline(0), decline(1)], props=(4, 72, 22, 72, 6, 72, 6, 92, 20, 72, 20, 92))


def pike(low, elevated=False):
    feet = (22, FLOOR) if not elevated else (20, 72)
    hip = (44, 50) if not elevated else (44, 44)
    torso = 52 - 18 * low
    hands = (68, FLOOR)
    return pose(hip, torso, ("t", hands, ELBOW_BACK), ("t", (67, FLOOR), ELBOW_BACK),
                ("t", feet, KNEE_FWD), ("t", (feet[0] + 1, feet[1]), KNEE_FWD), head=torso - 10)


motion("pike", 2.2, ["pike"], [pike(0), pike(1)])
motion("pike-elevated", 2.2, ["pike-elevated"], [pike(0, True), pike(1, True)], props=(10, 72, 30, 72, 12, 72, 12, 92, 28, 72, 28, 92))


def dips(low):
    hip = (38, 74 + 10 * low)
    return pose(hip, 180, ("t", (31, 72), ELBOW_BACK), ("t", (30, 72), ELBOW_BACK),
                ("t", (72, FLOOR), KNEE_BACK), ("t", (71, FLOOR), KNEE_BACK))


motion("dips", 2.0, ["dips"], [dips(0), dips(1)], props=(14, 72, 32, 72, 16, 72, 16, 92, 30, 72, 30, 92))

# --- Suelo: core ---


def forearm_plank(shift=0.0):
    sh = line_body(FEET, 15 + shift, TORSO + THIGH + SHIN)
    return straight(sh, FEET, ("a", 0, 90), ("a", -2, 88))


motion("plank", 4.0, ["plank", "hollow"], [forearm_plank(0), forearm_plank(1.5)])


def plank_tap(side):
    p = plank_line(27)
    if side is not None:
        e, h = limb(p[SH], ("t", (p[SH][0] - 3, p[SH][1] + 2), ELBOW_FWD), UPPER, FORE)
        if side:
            p[NE], p[NH] = e, h
        else:
            p[FE], p[FH] = e, h
    return p


motion("plank-taps", 1.6, ["plank-taps"], [plank_tap(None), plank_tap(True), plank_tap(None), plank_tap(False)])


def side_plank(up):
    """Vista de frente: apoyado en el antebrazo, cuerpo en diagonal."""
    sh = line_body(FEET, 15, TORSO + THIGH + SHIN)
    p = straight(sh, FEET, ("a", 0, 90), ("a", 180, 180))
    p[HIP] = (p[HIP][0], p[HIP][1] - 3 * up + 2)
    return p


motion("sideplank", 3.0, ["sideplank"], [side_plank(0), side_plank(1)])


def climber(side):
    p = plank_line(27)
    if side is not None:
        k, f = limb(p[HIP], ("t", (p[SH][0] - 14, FLOOR - 2), KNEE_FWD), THIGH, SHIN)
        if side:
            p[NK], p[NF] = k, f
        else:
            p[FK], p[FF] = k, f
    return p


motion("climbers", 0.8, ["climbers"], [climber(True), climber(False)])


def lying(hip_x=50, legs=("a", -90, -90), fl=None, arms=("a", 90, 90), fa=None, lift=0.0, torso=90):
    fl = fl or legs
    fa = fa or arms
    p = pose((hip_x, FLOOR - 3 - lift), torso, arms, fa, legs, fl)
    return p


def bridge(up, single=False):
    hip = (46, 86 - 16 * up)
    sh = (70, 88)
    torso = math.degrees(math.atan2(sh[0] - hip[0], sh[1] - hip[1]))
    far = ("t", (28, FLOOR), KNEE_BACK) if not single else ("a", -70 - 10 * up, -70 - 10 * up)
    return pose(hip, torso, ("a", -70, -90), ("a", -72, -92), ("t", (28, FLOOR), KNEE_BACK), far)


motion("bridge", 2.4, ["bridge"], [bridge(0), bridge(1)])
motion("bridge-single", 2.4, ["bridge-single"], [bridge(0, True), bridge(1, True)])


def leg_raise(up):
    a = -90 - 85 * up
    return lying(46, ("a", a, a), ("a", a + 2, a + 2), ("a", -85, -90), torso=90)


motion("legraise", 2.6, ["legraise"], [leg_raise(0.05), leg_raise(1)])


def deadbug(side):
    up_leg = ("a", -170, -90)
    up_arm = ("a", 180, 180)
    ext_leg = ("a", -100, -95)
    ext_arm = ("a", 100, 95)
    if side is None:
        return lying(46, up_leg, up_leg, up_arm, up_arm)
    return lying(46, ext_leg if side else up_leg, up_leg if side else ext_leg, up_arm if side else ext_arm, ext_arm if side else up_arm)


motion("deadbug", 2.4, ["deadbug"], [deadbug(None), deadbug(True), deadbug(None), deadbug(False)])


def quadruped(side=None, crawl=0):
    hip = (34 + crawl, 66)
    p = pose(hip, 90, ("a", 0, 0), ("a", 0, 0), ("a", 0, -90), ("a", 0, -90))
    p = grounded(p)
    if side is not None:
        arm = limb(p[SH], ("a", 100, 100), UPPER, FORE)
        leg = limb(p[HIP], ("a", -90, -90), THIGH, SHIN)
        if side:
            p[NE], p[NH] = arm
            p[FK], p[FF] = leg
        else:
            p[FE], p[FH] = arm
            p[NK], p[NF] = leg
    return p


motion("birddog", 3.0, ["birddog"], [quadruped(), quadruped(True), quadruped(), quadruped(False)])


def bear(phase):
    s_ = 1 if phase else -1
    hip = (36 + 2 * s_, 62)
    p = pose(hip, 92, ("a", 6 * s_, 0), ("a", -6 * s_, 0), ("a", 20 + 10 * s_, -60), ("a", 20 - 10 * s_, -60))
    return grounded(p, HIP, 36 + 2 * s_)


motion("quad", 1.6, ["quad"], [bear(0), bear(1)])


def superman(up):
    p = pose((34, FLOOR - 3), 90 + 6 * up, ("a", 90 + 12 * up, 90 + 14 * up), ("a", 88 + 12 * up, 88 + 14 * up),
             ("a", -90 + 8 * up, -90 + 12 * up), ("a", -92 + 8 * up, -92 + 12 * up), head=90 + 10 * up)
    return grounded(p, HIP, 34)


motion("superman", 2.4, ["superman"], [superman(0), superman(1)])

# --- Tirón ---


def towel_row(pull):
    feet = (72, FLOOR)
    lean = 24 - 16 * pull
    sh = (feet[0] - math.sin(math.radians(lean)) * 63, feet[1] - math.cos(math.radians(lean)) * 63)
    hand = (76, 44)
    return straight(sh, feet, ("t", hand, ELBOW_BACK), ("t", (76, 45), ELBOW_BACK))


motion("towel-row", 2.2, ["row-towel", "row-towel-one"], [towel_row(0), towel_row(1)], props=(90, 20, 90, 92, 76, 44, 90, 44))

ROW_Y = 52


def inverted_row(pull, feet_up=False):
    feet = (12, FLOOR) if not feet_up else (12, 74)
    sh = line_body(feet, 13 + 17 * pull, TORSO + THIGH + SHIN) if not feet_up else line_body(feet, 18 + 16 * pull, TORSO + THIGH + SHIN)
    return straight(sh, feet, ("t", (sh[0] + 3, ROW_Y), ELBOW_BACK), ("t", (sh[0] + 2, ROW_Y), ELBOW_BACK))


motion("row", 2.2, ["row"], [inverted_row(0), inverted_row(1)], props=(50, 52, 96, 52, 92, 52, 92, 92))
motion("row-feet", 2.2, ["row-feet"], [inverted_row(0, True), inverted_row(1, True)], props=(50, 52, 96, 52, 92, 52, 92, 92, 2, 74, 20, 74, 4, 74, 4, 92, 18, 74, 18, 92))


def pullup(up):
    hand = (50, 14)
    sh = (50, 41 - 22 * up)
    hip = (sh[0] - 2, sh[1] + TORSO)
    torso = math.degrees(math.atan2(sh[0] - hip[0], sh[1] - hip[1]))
    return pose(hip, torso, ("t", (53, 14), ELBOW_FWD), ("t", (47, 14), ELBOW_BACK), ("a", 10, -20), ("a", 5, -30))


motion("pullup", 2.6, ["pullup", "pullup-negative", "pullup-assisted"], [pullup(0), pullup(1)], props=WALL_BAR)
motion("hang", 4.0, ["hang"], [pullup(0), pullup(0.08)], props=WALL_BAR)

# --- Combinados y caídas ---


def plank_high():
    return plank_line(27)


def crouch(x=56):
    hip = (x - 10, 76)
    return pose(hip, 120, ("t", (x + 12, FLOOR), ELBOW_BACK), ("t", (x + 11, FLOOR), ELBOW_BACK), ("t", (x, FLOOR), KNEE_FWD), ("t", (x - 1, FLOOR), KNEE_FWD))


jump = [(p[0], p[1] - 8) for p in pose((56, 56), 180, ("a", 170, 175), ("a", 165, 170), ("a", 2, -4), ("a", -2, -6))]
motion("burpee", 3.0, ["burpee"], [stand(x=56), crouch(), plank_high(), crouch(), jump])


def sprawl_down():
    p = plank_line(22)
    p[HIP] = (p[HIP][0], p[HIP][1] + 6)
    return p


motion("sprawl", 1.6, ["sprawl"], [guard(x=56), crouch(), sprawl_down(), crouch()])


def back_fall(stage):
    if stage == 0:
        return squat(depth=1.0, arms=(90, 90))
    if stage == 1:
        return pose((44, 86), -160, ("a", 60, 70), ("a", 55, 65), ("a", 120, 40), ("a", 115, 35), head=-130)
    return pose((52, 87), -95, ("a", -40, -40), ("a", -45, -45), ("a", 150, 120), ("a", 145, 115), head=-60)


motion("ukemi-back", 2.4, ["ukemi-back"], [back_fall(0), back_fall(1), back_fall(2), back_fall(1)])


def side_fall(stage):
    if stage == 0:
        return squat(depth=1.0, arms=(90, 90))
    if stage == 1:
        return pose((46, 84), -150, ("a", 30, 60), ("a", -60, -60), ("a", 110, 30), ("a", 60, 0), head=-120)
    return pose((52, 87), -95, ("a", -10, 30), ("a", -60, -60), ("a", 150, 120), ("a", 130, 100), head=-70)


motion("ukemi-side", 2.4, ["ukemi-side"], [side_fall(0), side_fall(1), side_fall(2), side_fall(1)])


def roll(stage):
    if stage == 0:
        return crouch(40)
    if stage == 1:
        return pose((46, 68), 58, ("t", (76, FLOOR), ELBOW_BACK), ("t", (75, FLOOR), ELBOW_BACK),
                    ("t", (44, FLOOR), KNEE_FWD), ("t", (43, FLOOR), KNEE_FWD), head=20)
    if stage == 2:
        return grounded(pose((58, 82), -100, ("a", 120, 60), ("a", 115, 55), ("a", 160, 60), ("a", 155, 55), head=-60), HIP, 58)
    return squat(x=72, depth=0.9, arms=(90, 90))


motion("roll", 2.6, ["roll"], [roll(0), roll(1), roll(2), roll(3), stand(x=72)])


def emit():
    seen = {}
    for mid, _, exercises, frames, _ in MOTIONS:
        for f in frames:
            assert len(f) == 22, mid
        for e in exercises:
            assert e not in seen, f"{e} en {seen[e]} y {mid}"
            seen[e] = mid
    lines = [
        "import Foundation",
        "",
        "// Generado por tools/motions.py. No editar a mano.",
        "",
        "/// Animaciones de los ejercicios: fotogramas clave de una figura de 11 puntos (vista lateral).",
        "enum MotionData {",
        "    static let all: [Motion] = [",
    ]
    for mid, seconds, exercises, frames, props in MOTIONS:
        ex = ", ".join(f'"{e}"' for e in exercises)
        fr = ",\n".join("            [" + ", ".join(f"{v:g}" for v in f) + "]" for f in frames)
        pr = ", ".join(f"{v:g}" for v in props)
        lines.append(f'        Motion(id: "{mid}", seconds: {seconds}, exercises: [{ex}], props: [{pr}], frames: [\n{fr},\n        ]),')
    lines += ["    ]", "}", ""]
    OUT.write_text("\n".join(lines))
    print(f"Escrito {OUT.relative_to(ROOT)}: {len(MOTIONS)} animaciones para {len(seen)} ejercicios")


if __name__ == "__main__":
    emit()
