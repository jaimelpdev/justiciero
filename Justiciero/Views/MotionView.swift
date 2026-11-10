import SwiftUI

extension MotionData {
    static let byExercise: [String: Motion] = {
        var map: [String: Motion] = [:]
        for motion in all {
            for exercise in motion.exercises { map[exercise] = motion }
        }
        return map
    }()
}

extension Exercise {
    var motion: Motion? { MotionData.byExercise[id] }

    /// Búsqueda de vídeos de la técnica en YouTube.
    var videoURL: URL? {
        var components = URLComponents(string: "https://www.youtube.com/results")
        components?.queryItems = [URLQueryItem(name: "search_query", value: "\(name) ejercicio técnica correcta")]
        return components?.url
    }
}

/// Figura animada que hace el ejercicio en bucle.
struct MotionView: View {
    let motion: Motion

    var body: some View {
        TimelineView(.animation) { context in
            Canvas { gc, size in
                let points = pose(at: context.date)
                let scale = min(size.width, size.height) / 100
                let dx = (size.width - 100 * scale) / 2
                let dy = (size.height - 100 * scale) / 2
                func pt(_ x: Double, _ y: Double) -> CGPoint { CGPoint(x: dx + x * scale, y: dy + y * scale) }
                func line(_ a: CGPoint, _ b: CGPoint, _ color: Color, _ width: Double) {
                    var path = Path()
                    path.move(to: a)
                    path.addLine(to: b)
                    gc.stroke(path, with: .color(color), style: StrokeStyle(lineWidth: width * scale, lineCap: .round, lineJoin: .round))
                }
                line(pt(2, 93), pt(98, 93), .white.opacity(0.2), 1)
                var i = 0
                while i + 3 < motion.props.count {
                    line(pt(motion.props[i], motion.props[i + 1]), pt(motion.props[i + 2], motion.props[i + 3]), .gray, 2.5)
                    i += 4
                }
                let p = stride(from: 0, to: 22, by: 2).map { pt(points[$0], points[$0 + 1]) }
                let far = Color.white.opacity(0.45)
                line(p[1], p[5], far, 3.2); line(p[5], p[6], far, 3.2)
                line(p[2], p[9], far, 3.6); line(p[9], p[10], far, 3.6)
                line(p[1], p[2], .white, 4.2)
                line(p[2], p[7], .white, 3.6); line(p[7], p[8], .white, 3.6)
                line(p[1], p[3], .white, 3.2); line(p[3], p[4], .white, 3.2)
                let r = 5 * scale
                gc.fill(Path(ellipseIn: CGRect(x: p[0].x - r, y: p[0].y - r, width: 2 * r, height: 2 * r)), with: .color(Theme.accent))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .accessibilityLabel("Animación del ejercicio")
    }

    /// Interpola entre fotogramas con aceleración suave, en bucle.
    private func pose(at date: Date) -> [Double] {
        let frames = motion.frames
        guard frames.count > 1 else { return frames.first ?? Array(repeating: 50, count: 22) }
        let segment = motion.seconds / Double(frames.count)
        let t = date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: motion.seconds) / segment
        let index = Int(t) % frames.count
        let raw = t - Double(Int(t))
        let k = raw * raw * (3 - 2 * raw)
        let a = frames[index], b = frames[(index + 1) % frames.count]
        return zip(a, b).map { $0 + ($1 - $0) * k }
    }
}

/// Animación del ejercicio o, si no la tiene, su icono.
struct ExerciseDemo: View {
    let exercise: Exercise

    var body: some View {
        if let motion = exercise.motion {
            MotionView(motion: motion)
                .background(Theme.cardHighlight, in: RoundedRectangle(cornerRadius: 14))
        } else {
            Image(systemName: exercise.icon)
                .font(.system(size: 40))
                .foregroundStyle(Theme.accent)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .background(Theme.cardHighlight, in: RoundedRectangle(cornerRadius: 14))
        }
    }
}
