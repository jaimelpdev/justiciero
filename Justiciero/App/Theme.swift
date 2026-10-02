import SwiftUI

enum Theme {
    static let bg = Color(red: 0.04, green: 0.05, blue: 0.07)
    static let card = Color(red: 0.10, green: 0.11, blue: 0.14)
    static let cardHighlight = Color(red: 0.14, green: 0.15, blue: 0.19)
    static let accent = Color(red: 1.0, green: 0.80, blue: 0.0)
    static let danger = Color(red: 0.92, green: 0.28, blue: 0.28)
    static let success = Color(red: 0.30, green: 0.80, blue: 0.45)
    static let info = Color(red: 0.35, green: 0.62, blue: 1.0)
    static let muted = Color.white.opacity(0.6)
}

struct CardModifier: ViewModifier {
    var color: Color = Theme.card

    func body(content: Content) -> some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

extension View {
    func card(_ color: Color = Theme.card) -> some View {
        modifier(CardModifier(color: color))
    }

    /// Fondo oscuro estándar para pantallas con ScrollView.
    func screenBackground() -> some View {
        background(Theme.bg.ignoresSafeArea())
    }
}

/// Renderiza texto con **negritas** y *cursivas* markdown sin interpretar `%` como formato.
func md(_ string: String) -> AttributedString {
    (try? AttributedString(markdown: string)) ?? AttributedString(string)
}

struct SectionHeader: View {
    let title: String
    var icon: String? = nil

    var body: some View {
        HStack(spacing: 8) {
            if let icon {
                Image(systemName: icon).foregroundStyle(Theme.accent)
            }
            Text(title.uppercased())
                .font(.caption.weight(.bold))
                .tracking(1.2)
                .foregroundStyle(Theme.muted)
            Spacer()
        }
        .padding(.top, 8)
    }
}

struct ProgressBar: View {
    let value: Double
    var color: Color = Theme.accent
    var height: CGFloat = 8

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.1))
                Capsule().fill(color)
                    .frame(width: max(0, min(1, value)) * geo.size.width)
            }
        }
        .frame(height: height)
    }
}

struct Pill: View {
    let text: String
    var icon: String? = nil
    var color: Color = Theme.accent

    var body: some View {
        HStack(spacing: 4) {
            if let icon { Image(systemName: icon) }
            Text(text)
        }
        .font(.caption2.weight(.semibold))
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(color)
        .background(color.opacity(0.15), in: Capsule())
    }
}

struct Callout: View {
    enum Kind { case warning, tip, danger, info }
    let kind: Kind
    let text: String

    private var color: Color {
        switch kind {
        case .warning: Theme.accent
        case .tip: Theme.success
        case .danger: Theme.danger
        case .info: Theme.info
        }
    }

    private var icon: String {
        switch kind {
        case .warning: "exclamationmark.triangle.fill"
        case .tip: "lightbulb.fill"
        case .danger: "xmark.octagon.fill"
        case .info: "info.circle.fill"
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.title3)
            Text(md(text))
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(color.opacity(0.4), lineWidth: 1)
        )
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var color: Color = Theme.accent

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.black)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(color.opacity(configuration.isPressed ? 0.7 : 1), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}
