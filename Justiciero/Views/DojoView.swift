import SwiftUI
import AVFoundation
import UIKit

// MARK: - Dojo

struct DojoView: View {
    @EnvironmentObject private var store: ProgressStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(Dojo.intro).foregroundStyle(Theme.muted)

                NavigationLink {
                    BeltView(belt: store.currentBelt)
                } label: {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            BeltBadge(belt: store.currentBelt)
                            VStack(alignment: .leading) {
                                Text("Entrenando: cinturón \(store.currentBelt.name.lowercased())").font(.headline)
                                Text(store.currentBelt.theme).font(.subheadline).foregroundStyle(Theme.muted)
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                        }
                        ProgressBar(value: Double(store.classesDone(store.currentBelt)) / Double(store.currentBelt.minClasses))
                        Text("\(min(store.classesDone(store.currentBelt), store.currentBelt.minClasses)) de \(store.currentBelt.minClasses) clases para poder examinarte")
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                    }
                    .foregroundStyle(.white)
                    .card(Theme.cardHighlight)
                }
                .buttonStyle(.plain)

                Callout(kind: .info, text: Dojo.honesty)

                SectionHeader(title: "Cinturones", icon: "medal.fill")
                ForEach(Belt.all) { belt in
                    let unlocked = store.isUnlocked(belt)
                    NavigationLink {
                        BeltView(belt: belt)
                    } label: {
                        HStack(spacing: 14) {
                            BeltBadge(belt: belt, locked: !unlocked)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Cinturón \(belt.name.lowercased())").font(.headline)
                                Text(belt.theme).font(.subheadline).foregroundStyle(Theme.muted)
                                HStack {
                                    Pill(text: "\(belt.minutes) min/clase", icon: "clock", color: Theme.info)
                                    if store.hasBelt(belt) {
                                        Pill(text: "Obtenido", icon: "checkmark.seal.fill", color: Theme.success)
                                    } else if !unlocked {
                                        Pill(text: "Bloqueado", icon: "lock.fill", color: Theme.muted)
                                    }
                                }
                            }
                            Spacer()
                            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                        }
                        .foregroundStyle(.white)
                        .card()
                        .opacity(unlocked ? 1 : 0.55)
                    }
                    .buttonStyle(.plain)
                }

                SectionHeader(title: "Monta tu dojo", icon: "house.fill")
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Dojo.setup, id: \.self) { item in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle.fill").foregroundStyle(Theme.accent)
                            Text(item).font(.subheadline)
                        }
                    }
                }
                .card()

                SectionHeader(title: "Reglas del dojo", icon: "exclamationmark.shield.fill")
                VStack(spacing: 8) {
                    ForEach(Dojo.safety, id: \.self) { Callout(kind: .warning, text: $0) }
                }

                NavigationLink {
                    TechniqueLibraryView()
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: "books.vertical.fill").font(.title2).foregroundStyle(Theme.accent)
                        VStack(alignment: .leading) {
                            Text("Biblioteca de técnicas").font(.headline)
                            Text("\(Technique.all.count) técnicas paso a paso").font(.subheadline).foregroundStyle(Theme.muted)
                        }
                        Spacer()
                        Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
                    }
                    .foregroundStyle(.white)
                    .card()
                }
                .buttonStyle(.plain)
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Dojo en casa")
    }
}

struct BeltBadge: View {
    let belt: Belt
    var locked = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(belt.color)
                .frame(width: 46, height: 16)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.white.opacity(0.25), lineWidth: 1))
            if locked {
                Image(systemName: "lock.fill").font(.caption2).foregroundStyle(Color.black.opacity(0.6))
            }
        }
        .frame(width: 52, height: 52)
        .background(Theme.cardHighlight, in: RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Cinturón

struct BeltView: View {
    @EnvironmentObject private var store: ProgressStore
    let belt: Belt
    @State private var training = false

    private var techniques: [Technique] {
        belt.techniques.compactMap { id in Technique.all.first { $0.id == id } }
    }

    var body: some View {
        let unlocked = store.isUnlocked(belt)
        let done = store.classesDone(belt)
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 14) {
                    BeltBadge(belt: belt, locked: !unlocked)
                    VStack(alignment: .leading) {
                        Text(belt.theme).font(.title2.bold())
                        Text(belt.goal).font(.subheadline).foregroundStyle(Theme.muted)
                    }
                }

                if !unlocked {
                    Callout(kind: .warning, text: "Obtén el cinturón anterior para entrenar este. Puedes leer sus técnicas para saber lo que viene.")
                }
                if store.hasBelt(belt) {
                    Callout(kind: .tip, text: "Cinturón obtenido. Puedes seguir haciendo esta clase para repasar.")
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Clases").font(.headline)
                        Spacer()
                        Text("\(done) / \(belt.minClasses)").font(.headline.monospacedDigit())
                    }
                    ProgressBar(value: Double(done) / Double(belt.minClasses), color: done >= belt.minClasses ? Theme.success : Theme.accent)
                    Text("Recomendado: 3 clases por semana, con un día de descanso entre ellas.")
                        .font(.caption)
                        .foregroundStyle(Theme.muted)
                }
                .card()

                Button {
                    training = true
                } label: {
                    Label("Empezar clase (\(belt.minutes) min)", systemImage: "play.fill")
                }
                .buttonStyle(PrimaryButtonStyle(color: unlocked ? Theme.accent : Theme.muted))
                .disabled(!unlocked)

                SectionHeader(title: "Estructura de la clase", icon: "list.bullet.rectangle")
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(belt.rounds.enumerated()), id: \.offset) { index, round in
                        HStack(spacing: 12) {
                            Image(systemName: round.kind.icon).foregroundStyle(Theme.accent).frame(width: 24)
                            VStack(alignment: .leading) {
                                Text(round.title).font(.subheadline.bold())
                                Text(round.repeats > 1 ? "\(round.repeats) × \(roundTime(round.seconds))" : roundTime(round.seconds))
                                    .font(.caption)
                                    .foregroundStyle(Theme.muted)
                            }
                            Spacer()
                            if !round.calls.isEmpty {
                                Pill(text: "Entrenador", icon: "speaker.wave.2.fill", color: Theme.info)
                            }
                        }
                        .padding(.vertical, 8)
                        if index < belt.rounds.count - 1 { Divider() }
                    }
                }
                .card()

                if !techniques.isEmpty {
                    SectionHeader(title: "Técnicas de este cinturón", icon: "figure.martial.arts")
                    ForEach(techniques) { technique in
                        NavigationLink {
                            TechniqueView(technique: technique)
                        } label: {
                            TechniqueRow(technique: technique)
                        }
                        .buttonStyle(.plain)
                    }
                }

                SectionHeader(title: "Examen", icon: "checkmark.seal.fill")
                Text("Grábate con el móvil y compara con los pasos de cada técnica. Marca cada punto solo cuando lo cumplas de verdad: aquí el único que puede hacerse trampas eres tú.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                VStack(spacing: 0) {
                    ForEach(Array(belt.exam.enumerated()), id: \.offset) { index, item in
                        Button {
                            store.toggleExam(belt, index)
                        } label: {
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: store.isExamChecked(belt, index) ? "checkmark.square.fill" : "square")
                                    .foregroundStyle(store.isExamChecked(belt, index) ? Theme.success : Theme.muted)
                                    .font(.title3)
                                Text(item).multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            .foregroundStyle(.white)
                        }
                        .buttonStyle(.plain)
                        .disabled(!unlocked || store.hasBelt(belt))
                        if index < belt.exam.count - 1 { Divider() }
                    }
                }
                .card()

                if !store.hasBelt(belt) {
                    Button {
                        withAnimation { store.earn(belt) }
                    } label: {
                        Label("Obtener cinturón \(belt.name.lowercased()) (+\(XP.belt) XP)", systemImage: "medal.fill")
                    }
                    .buttonStyle(PrimaryButtonStyle(color: store.canEarn(belt) ? Theme.success : Theme.muted))
                    .disabled(!store.canEarn(belt))
                    if !store.canEarn(belt) && unlocked {
                        Text("Necesitas \(belt.minClasses) clases y todos los puntos del examen.")
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Cinturón \(belt.name.lowercased())")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $training) {
            DojoClassView(belt: belt)
        }
    }

    private func roundTime(_ seconds: Int) -> String {
        seconds % 60 == 0 ? "\(seconds / 60) min" : String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
}

// MARK: - Técnicas

struct TechniqueRow: View {
    let technique: Technique

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: technique.kind.icon)
                .font(.title2)
                .foregroundStyle(Theme.accent)
                .frame(width: 36)
            VStack(alignment: .leading, spacing: 2) {
                Text(technique.name).font(.headline)
                Text(technique.kind.label).font(.caption).foregroundStyle(Theme.muted)
            }
            Spacer()
            if technique.partner != nil {
                Image(systemName: "person.2.fill").foregroundStyle(Theme.info).font(.caption)
            }
            Image(systemName: "chevron.right").foregroundStyle(Theme.muted)
        }
        .foregroundStyle(.white)
        .card()
    }
}

struct TechniqueLibraryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Callout(kind: .info, text: Dojo.numbering)
                ForEach(TechniqueKind.allCases, id: \.self) { kind in
                    let items = Technique.all.filter { $0.kind == kind }
                    if !items.isEmpty {
                        SectionHeader(title: kind.label, icon: kind.icon)
                        ForEach(items) { technique in
                            NavigationLink {
                                TechniqueView(technique: technique)
                            } label: {
                                TechniqueRow(technique: technique)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle("Técnicas")
    }
}

struct TechniqueView: View {
    let technique: Technique

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Pill(text: technique.kind.label, icon: technique.kind.icon)
                Text(technique.summary).font(.title3)

                SectionHeader(title: "Paso a paso", icon: "list.number")
                LessonBlockView(block: .steps(technique.steps), color: Theme.accent)

                SectionHeader(title: "Errores típicos", icon: "xmark.circle.fill")
                LessonBlockView(block: .bullets(technique.errors), color: Theme.danger)

                SectionHeader(title: "Ejercicio en solitario", icon: "figure.martial.arts")
                Text(technique.drill).card()

                if let partner = technique.partner {
                    SectionHeader(title: "Con compañero (opcional)", icon: "person.2.fill")
                    Callout(kind: .info, text: partner)
                    Callout(kind: .warning, text: "Velocidad al 30 %, sin golpes a la cabeza y con una palabra acordada para parar al instante.")
                }

                Callout(kind: .tip, text: "Grábate con el móvil desde un lateral y compara con cada paso. Es la forma más fiable de corregirte sin instructor.")
            }
            .padding()
        }
        .screenBackground()
        .navigationTitle(technique.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Clase guiada

/// Convierte "1-2, paso atrás" en algo que la voz sintetizada lea bien.
func spokenCall(_ text: String) -> String {
    let words = ["1": "uno", "2": "dos", "3": "tres", "4": "cuatro", "5": "cinco", "6": "seis"]
    var result = ""
    for ch in text {
        let s = String(ch)
        if let word = words[s] {
            result += word
        } else if s == "-" {
            result += ", "
        } else {
            result += s
        }
    }
    return result
}

final class Coach {
    private let synth = AVSpeechSynthesizer()
    var enabled = true

    init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.duckOthers])
    }

    func say(_ text: String) {
        guard enabled else { return }
        let utterance = AVSpeechUtterance(string: spokenCall(text))
        utterance.voice = AVSpeechSynthesisVoice(language: "es-ES")
        utterance.rate = 0.55
        synth.stopSpeaking(at: .immediate)
        synth.speak(utterance)
    }
}

struct DojoClassView: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss
    @AppStorage("dojo.voice") private var voice = true

    let belt: Belt

    private struct Segment {
        let round: DojoRound
        let rep: Int
        let isRest: Bool
        let seconds: Int
        let restLabel: String
    }

    @State private var coach = Coach()
    @State private var index = 0
    @State private var remaining = 0
    @State private var running = false
    @State private var finished = false
    @State private var call = ""
    @State private var sinceCall = 0
    @State private var startDate = Date.now

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var segments: [Segment] {
        var result: [Segment] = []
        for (r, round) in belt.rounds.enumerated() {
            for rep in 0..<round.repeats {
                result.append(Segment(round: round, rep: rep, isRest: false, seconds: round.seconds, restLabel: ""))
                if rep < round.repeats - 1 && round.rest > 0 {
                    result.append(Segment(round: round, rep: rep, isRest: true, seconds: round.rest, restLabel: "Siguiente: \(round.title) \(rep + 2)/\(round.repeats)"))
                } else if rep == round.repeats - 1 && r < belt.rounds.count - 1 {
                    let next = belt.rounds[r + 1]
                    result.append(Segment(round: next, rep: 0, isRest: true, seconds: 15, restLabel: "Siguiente: \(next.title)"))
                }
            }
        }
        return result
    }

    var body: some View {
        let segs = segments
        let seg = segs[min(index, segs.count - 1)]
        NavigationStack {
            VStack(spacing: 20) {
                ProgressBar(value: Double(index) / Double(segs.count))
                    .padding(.horizontal)
                Spacer()
                if finished {
                    finishedView
                } else if seg.isRest {
                    VStack(spacing: 14) {
                        Text("DESCANSO").font(.caption.weight(.bold)).tracking(1.5).foregroundStyle(Theme.info)
                        Text(timeString(remaining))
                            .font(.system(size: 80, weight: .bold, design: .rounded).monospacedDigit())
                        Text(seg.restLabel).font(.headline).multilineTextAlignment(.center)
                        Text(seg.round.cue).font(.subheadline).foregroundStyle(Theme.muted).multilineTextAlignment(.center).padding(.horizontal)
                    }
                } else {
                    VStack(spacing: 14) {
                        Label(seg.round.kind.label.uppercased(), systemImage: seg.round.kind.icon)
                            .font(.caption.weight(.bold))
                            .foregroundStyle(Theme.accent)
                        Text(seg.round.title + (seg.round.repeats > 1 ? " \(seg.rep + 1)/\(seg.round.repeats)" : ""))
                            .font(.title2.bold())
                            .multilineTextAlignment(.center)
                        Text(timeString(remaining))
                            .font(.system(size: 72, weight: .bold, design: .rounded).monospacedDigit())
                        if !seg.round.calls.isEmpty {
                            Text(call.isEmpty ? "¡Prepárate!" : call)
                                .font(.system(size: 44, weight: .heavy, design: .rounded))
                                .foregroundStyle(Theme.accent)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                                .frame(minHeight: 110)
                                .padding(.horizontal)
                                .id(call)
                                .transition(.scale.combined(with: .opacity))
                        }
                        Text(seg.round.cue)
                            .font(.subheadline)
                            .foregroundStyle(Theme.muted)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                }
                Spacer()
                if !finished {
                    HStack(spacing: 12) {
                        Button(running ? "Pausar" : (index == 0 && remaining == segs[0].seconds ? "Empezar" : "Seguir")) {
                            running.toggle()
                            if running && index == 0 && remaining == segs[0].seconds { announce(segs[0]) }
                        }
                        .buttonStyle(PrimaryButtonStyle(color: running ? Theme.cardHighlight : Theme.accent))
                        Button("Saltar") { advance() }
                            .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
                            .frame(width: 110)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.bg.ignoresSafeArea())
            .navigationTitle("Cinturón \(belt.name.lowercased())")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Salir") { dismiss() }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        voice.toggle()
                        coach.enabled = voice
                    } label: {
                        Image(systemName: voice ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    }
                }
            }
        }
        .onAppear {
            coach.enabled = voice
            remaining = segs[0].seconds
            startDate = .now
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear { UIApplication.shared.isIdleTimerDisabled = false }
        .onReceive(ticker) { _ in tick() }
    }

    private var finishedView: some View {
        VStack(spacing: 16) {
            Image(systemName: "figure.martial.arts")
                .font(.system(size: 80))
                .foregroundStyle(Theme.success)
            Text("Clase completada").font(.largeTitle.bold())
            Text("Saluda al dojo, bebe agua y estira. La constancia es la técnica más difícil.")
                .foregroundStyle(Theme.muted)
                .multilineTextAlignment(.center)
            Button("Registrar clase (+\(XP.dojoClass) XP)") {
                store.logDojoClass(belt)
                dismiss()
            }
            .buttonStyle(PrimaryButtonStyle(color: Theme.success))
            .padding(.horizontal, 40)
        }
        .padding()
    }

    private func tick() {
        guard running, !finished else { return }
        let segs = segments
        let seg = segs[index]
        remaining -= 1
        if !seg.isRest {
            if remaining == 10 && seg.seconds > 30 { coach.say("Diez segundos") }
            if !seg.round.calls.isEmpty && remaining > 1 {
                sinceCall += 1
                if sinceCall >= seg.round.pace { nextCall(seg.round) }
            }
        }
        if remaining <= 0 { advance() }
    }

    private func nextCall(_ round: DojoRound) {
        sinceCall = 0
        let options = round.calls.count > 1 ? round.calls.filter { $0 != call } : round.calls
        withAnimation(.snappy) { call = options.randomElement() ?? "" }
        coach.say(call)
    }

    private func advance() {
        let segs = segments
        guard index + 1 < segs.count else {
            finished = true
            running = false
            coach.say("Clase terminada. Buen trabajo.")
            return
        }
        index += 1
        remaining = segs[index].seconds
        call = ""
        sinceCall = 0
        if running { announce(segs[index]) }
    }

    private func announce(_ seg: Segment) {
        if seg.isRest {
            coach.say("Descanso")
        } else {
            coach.say(seg.round.title)
            sinceCall = seg.round.calls.isEmpty ? 0 : seg.round.pace - 2
        }
    }

    private func timeString(_ seconds: Int) -> String {
        String(format: "%d:%02d", max(0, seconds) / 60, max(0, seconds) % 60)
    }
}
