import SwiftUI

struct AcademyView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    SectionHeader(title: "Entrenamiento mental", icon: "brain")
                    HStack(spacing: 12) {
                        NavigationLink {
                            ScenarioListView()
                        } label: {
                            AcademyTile(title: "Simulador", subtitle: "\(store.optimalScenarios)/\(Scenario.all.count) óptimos",
                                        icon: "theatermask.and.paintbrush.fill", color: Theme.accent)
                        }
                        NavigationLink {
                            KimGameView()
                        } label: {
                            AcademyTile(title: "Juego de Kim", subtitle: "Récord: \(store.state.kimBest) %",
                                        icon: "eye.circle.fill", color: Color.purple)
                        }
                    }
                    .buttonStyle(.plain)

                    NavigationLink {
                        CodeView()
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: "scroll.fill")
                                .font(.title2)
                                .foregroundStyle(Theme.accent)
                            VStack(alignment: .leading) {
                                Text("El Código del Vigilante").font(.headline)
                                Text("Las \(CodeRule.all.count) reglas que nunca rompes").font(.subheadline).foregroundStyle(Theme.muted)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                        }
                        .foregroundStyle(.white)
                        .card()
                    }
                    .buttonStyle(.plain)

                    SectionHeader(title: "Módulos", icon: "books.vertical.fill")
                    ForEach(SkillModule.all) { module in
                        NavigationLink {
                            ModuleView(module: module)
                        } label: {
                            ModuleRow(module: module, learned: store.learnedCount(in: module))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .screenBackground()
            .navigationTitle("Academia")
        }
    }
}

struct AcademyTile: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon).font(.largeTitle).foregroundStyle(color)
            Text(title).font(.headline).foregroundStyle(.white)
            Text(subtitle).font(.caption).foregroundStyle(Theme.muted)
        }
        .card()
    }
}

struct ModuleRow: View {
    let module: SkillModule
    let learned: Int

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: module.icon)
                .font(.title2)
                .foregroundStyle(module.color)
                .frame(width: 48, height: 48)
                .background(module.color.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 6) {
                Text(module.title).font(.headline)
                ProgressBar(value: Double(learned) / Double(max(module.lessons.count, 1)), color: module.color, height: 6)
                Text("\(learned)/\(module.lessons.count) lecciones")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card()
    }
}

struct ModuleView: View {
    @EnvironmentObject private var store: ProgressStore
    let module: SkillModule

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(module.intro).foregroundStyle(Theme.muted)
                ForEach(module.lessons) { lesson in
                    NavigationLink {
                        LessonView(lesson: lesson, color: module.color)
                    } label: {
                        HStack {
                            Image(systemName: store.isLearned(lesson) ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(store.isLearned(lesson) ? Theme.success : Theme.muted)
                            VStack(alignment: .leading) {
                                Text(lesson.title).font(.headline)
                                Text("\(lesson.minutes) min de lectura").font(.caption).foregroundStyle(Theme.muted)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                        }
                        .foregroundStyle(.white)
                        .card()
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(module.title)
    }
}

struct LessonView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss
    let lesson: Lesson
    let color: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                ForEach(Array(lesson.blocks.enumerated()), id: \.offset) { _, block in
                    LessonBlockView(block: block, color: color)
                }

                Button {
                    store.completeLesson(lesson)
                    dismiss()
                } label: {
                    Label(store.isLearned(lesson) ? "Aprendida" : "Marcar como aprendida (+\(XP.lesson) XP)",
                          systemImage: "checkmark")
                }
                .buttonStyle(PrimaryButtonStyle(color: store.isLearned(lesson) ? Theme.success : Theme.accent))
                .padding(.top, 12)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(lesson.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LessonBlockView: View {
    let block: LessonBlock
    let color: Color

    var body: some View {
        switch block {
        case .heading(let text):
            Text(text).font(.title3.bold()).padding(.top, 6)
        case .paragraph(let text):
            Text(md(text)).fixedSize(horizontal: false, vertical: true)
        case .bullets(let items):
            VStack(alignment: .leading, spacing: 10) {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Circle().fill(color).frame(width: 6, height: 6)
                        Text(md(item)).fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .steps(let items):
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1)")
                            .font(.subheadline.bold())
                            .foregroundStyle(.black)
                            .frame(width: 26, height: 26)
                            .background(color, in: Circle())
                        Text(md(item)).fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .tip(let text):
            Callout(kind: .tip, text: text)
        case .warning(let text):
            Callout(kind: .warning, text: text)
        case .danger(let text):
            Callout(kind: .danger, text: text)
        }
    }
}

// MARK: - Código

struct CodeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Batman tenía una sola regla. Tú tienes trece, porque la realidad es más complicada que un cómic. Léelas antes de cada salida.")
                    .foregroundStyle(Theme.muted)
                ForEach(CodeRule.all) { rule in
                    HStack(alignment: .top, spacing: 14) {
                        Text(String(format: "%02d", rule.number))
                            .font(.title2.weight(.heavy).monospacedDigit())
                            .foregroundStyle(Theme.accent)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(rule.title).font(.headline)
                            Text(rule.text).font(.subheadline).foregroundStyle(Theme.muted)
                        }
                    }
                    .card()
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("El Código")
    }
}

// MARK: - Simulador de escenarios

struct ScenarioListView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Situaciones reales. Elige qué harías. No hay trampa: lo que funciona en el cine casi nunca funciona en la calle.")
                    .foregroundStyle(Theme.muted)
                ForEach(Scenario.all) { scenario in
                    NavigationLink {
                        ScenarioPlayView(scenario: scenario)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: scenario.icon)
                                .font(.title2)
                                .foregroundStyle(Theme.accent)
                                .frame(width: 40)
                            Text(scenario.title).font(.headline)
                            Spacer()
                            scoreBadge(store.state.scenarioBest[scenario.id])
                        }
                        .foregroundStyle(.white)
                        .card()
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Simulador")
    }

    @ViewBuilder
    private func scoreBadge(_ score: Int?) -> some View {
        switch score {
        case 2: Pill(text: "Óptimo", icon: "star.fill", color: Theme.success)
        case 1: Pill(text: "Mejorable", color: Theme.accent)
        case 0: Pill(text: "Repetir", color: Theme.danger)
        default: Pill(text: "Nuevo", color: Theme.muted)
        }
    }
}

struct ScenarioPlayView: View {
    @EnvironmentObject private var store: ProgressStore
    let scenario: Scenario

    @State private var selected: ScenarioOption?
    @State private var gained = 0
    @State private var shuffled: [ScenarioOption] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: scenario.icon)
                    .font(.system(size: 44))
                    .foregroundStyle(Theme.accent)
                Text(scenario.situation)
                    .font(.title3)
                    .fixedSize(horizontal: false, vertical: true)

                SectionHeader(title: "¿Qué haces?", icon: "hand.point.up.left.fill")

                ForEach(shuffled) { option in
                    Button {
                        guard selected == nil else { return }
                        withAnimation {
                            selected = option
                            gained = store.recordScenario(scenario, score: option.score)
                        }
                    } label: {
                        Text(option.text)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.white)
                            .card(background(for: option))
                    }
                    .buttonStyle(.plain)
                }

                if let selected {
                    VStack(alignment: .leading, spacing: 12) {
                        Callout(kind: selected.score == 2 ? .tip : (selected.score == 1 ? .warning : .danger),
                                text: selected.feedback)
                        if selected.score < 2, let best = shuffled.first(where: { $0.score == 2 }) {
                            Callout(kind: .info, text: "**Mejor opción:** \(best.text)")
                        }
                        Text(md("**Lección:** \(scenario.lesson)"))
                            .card()
                        if gained > 0 {
                            Text("+\(gained) XP").font(.headline).foregroundStyle(Theme.accent)
                        }
                        Button("Intentar de nuevo") {
                            withAnimation {
                                self.selected = nil
                                gained = 0
                                shuffled = scenario.options.shuffled()
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(scenario.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if shuffled.isEmpty { shuffled = scenario.options.shuffled() }
        }
    }

    private func background(for option: ScenarioOption) -> Color {
        guard let selected else { return Theme.card }
        if option.score == 2 { return Theme.success.opacity(0.25) }
        if option == selected { return (option.score == 1 ? Theme.accent : Theme.danger).opacity(0.25) }
        return Theme.card
    }
}

// MARK: - Juego de Kim

struct KimGameView: View {
    @EnvironmentObject private var store: ProgressStore

    private static let pool = [
        "key.fill", "car.fill", "bicycle", "flashlight.on.fill", "phone.fill", "umbrella.fill",
        "bag.fill", "cup.and.saucer.fill", "book.fill", "eyeglasses", "scissors", "hammer.fill",
        "wrench.fill", "bell.fill", "clock.fill", "camera.fill", "headphones", "gamecontroller.fill",
        "lightbulb.fill", "leaf.fill", "flame.fill", "drop.fill", "moon.fill", "star.fill",
        "heart.fill", "house.fill", "airplane", "bus.fill", "map.fill", "flag.fill",
        "tag.fill", "creditcard.fill", "gift.fill", "pills.fill", "envelope.fill", "paperplane.fill",
        "pencil", "trash.fill", "lock.fill", "bolt.fill", "tshirt.fill", "guitars.fill",
    ]

    private enum Stage { case menu, memorize, recall, result }

    @State private var stage: Stage = .menu
    @State private var hard = false
    @State private var targets: Set<String> = []
    @State private var board: [String] = []
    @State private var picks: Set<String> = []
    @State private var countdown = 0
    @State private var percent = 0
    @State private var gained = 0

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var targetCount: Int { hard ? 12 : 8 }
    private var boardCount: Int { hard ? 24 : 16 }
    private var memorizeSeconds: Int { hard ? 20 : 25 }
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                switch stage {
                case .menu: menu
                case .memorize: memorize
                case .recall: recall
                case .result: result
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Juego de Kim")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(ticker) { _ in
            guard stage == .memorize else { return }
            if countdown > 1 {
                countdown -= 1
            } else {
                withAnimation { stage = .recall }
            }
        }
    }

    private var menu: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Un ejercicio clásico de entrenamiento de scouts, militares y policías para desarrollar la memoria visual.")
                .foregroundStyle(Theme.muted)
            Callout(kind: .info, text: "Verás varios objetos durante unos segundos. Después aparecerán mezclados con otros y tendrás que marcar solo los que viste.")
            Picker("Dificultad", selection: $hard) {
                Text("Normal (8 objetos)").tag(false)
                Text("Difícil (12 objetos)").tag(true)
            }
            .pickerStyle(.segmented)
            HStack {
                StatTile(value: "\(store.state.kimGames)", label: "Partidas", icon: "gamecontroller.fill", color: Theme.info)
                StatTile(value: "\(store.state.kimBest)%", label: "Récord", icon: "trophy.fill", color: Theme.accent)
            }
            Button("Empezar") { start() }
                .buttonStyle(PrimaryButtonStyle())
        }
    }

    private var memorize: some View {
        VStack(spacing: 20) {
            Text("Memoriza")
                .font(.title.bold())
            Text("\(countdown)")
                .font(.system(size: 54, weight: .bold, design: .rounded).monospacedDigit())
                .foregroundStyle(Theme.accent)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(Array(targets).sorted(), id: \.self) { symbol in
                    symbolCell(symbol, highlighted: false)
                }
            }
            Button("Ya lo tengo") { withAnimation { stage = .recall } }
                .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
        }
    }

    private var recall: some View {
        VStack(spacing: 20) {
            Text("¿Cuáles viste?")
                .font(.title.bold())
            Text("Marcados: \(picks.count) de \(targetCount)")
                .foregroundStyle(Theme.muted)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(board, id: \.self) { symbol in
                    Button {
                        if picks.contains(symbol) { picks.remove(symbol) } else { picks.insert(symbol) }
                    } label: {
                        symbolCell(symbol, highlighted: picks.contains(symbol))
                    }
                    .buttonStyle(.plain)
                }
            }
            Button("Comprobar") { finish() }
                .buttonStyle(PrimaryButtonStyle())
        }
    }

    private var result: some View {
        VStack(spacing: 20) {
            Text(verbatim: "\(percent) %")
                .font(.system(size: 72, weight: .bold, design: .rounded))
                .foregroundStyle(percent >= 80 ? Theme.success : Theme.accent)
            Text(percent >= 80 ? "Memoria de detective." : "Sigue practicando: mejora rápido con la repetición.")
                .foregroundStyle(Theme.muted)
            if gained > 0 { Text("+\(gained) XP").font(.headline).foregroundStyle(Theme.accent) }
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(board, id: \.self) { symbol in
                    let wasTarget = targets.contains(symbol)
                    let picked = picks.contains(symbol)
                    symbolCell(symbol, highlighted: false)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(wasTarget ? (picked ? Theme.success : Theme.accent) : (picked ? Theme.danger : Color.clear), lineWidth: 3)
                        )
                }
            }
            HStack(spacing: 16) {
                Label("Acierto", systemImage: "square.fill").foregroundStyle(Theme.success)
                Label("Olvidado", systemImage: "square.fill").foregroundStyle(Theme.accent)
                Label("Error", systemImage: "square.fill").foregroundStyle(Theme.danger)
            }
            .font(.caption)
            Button("Otra partida") { start() }
                .buttonStyle(PrimaryButtonStyle())
            Button("Menú") { stage = .menu }
        }
    }

    private func symbolCell(_ symbol: String, highlighted: Bool) -> some View {
        Image(systemName: symbol)
            .font(.title)
            .frame(maxWidth: .infinity, minHeight: 64)
            .foregroundStyle(highlighted ? Color.black : Color.white)
            .background(highlighted ? Theme.accent : Theme.card, in: RoundedRectangle(cornerRadius: 12))
    }

    private func start() {
        let shuffledPool = Self.pool.shuffled()
        let chosen = Array(shuffledPool.prefix(boardCount))
        targets = Set(chosen.prefix(targetCount))
        board = chosen.shuffled()
        picks = []
        countdown = memorizeSeconds
        gained = 0
        withAnimation { stage = .memorize }
    }

    private func finish() {
        let correct = picks.intersection(targets).count
        let wrong = picks.subtracting(targets).count
        let score = max(0, correct - wrong)
        percent = Int((Double(score) / Double(targetCount) * 100).rounded())
        gained = store.recordKim(percent: percent)
        withAnimation { stage = .result }
    }
}
