import SwiftUI

struct JournalView: View {
    @EnvironmentObject private var store: ProgressStore
    @State private var showingEditor = false
    @State private var filter: JournalKind?

    private var entries: [JournalEntry] {
        guard let filter else { return store.state.journal }
        return store.state.journal.filter { $0.kind == filter }
    }

    var body: some View {
        List {
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        filterChip(nil, label: "Todo", icon: "tray.full.fill")
                        ForEach(JournalKind.allCases) { kind in
                            filterChip(kind, label: kind.label, icon: kind.icon)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }

            if entries.isEmpty {
                Text("Aún no hay entradas. La bitácora es tu memoria: observaciones, salidas, reflexiones y puntos seguros de tu barrio.")
                    .foregroundStyle(Theme.muted)
                    .listRowBackground(Theme.card)
            }

            ForEach(entries) { entry in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Label(entry.kind.label, systemImage: entry.kind.icon)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Theme.accent)
                        Spacer()
                        Text(entry.date, format: .dateTime.day().month().year().hour().minute())
                            .font(.caption)
                            .foregroundStyle(Theme.muted)
                    }
                    Text(entry.title).font(.headline)
                    if !entry.notes.isEmpty {
                        Text(entry.notes).font(.subheadline).foregroundStyle(Theme.muted)
                    }
                    Text(String(repeating: "★", count: entry.mood) + String(repeating: "☆", count: 5 - entry.mood))
                        .font(.caption)
                        .foregroundStyle(Theme.accent)
                }
                .padding(.vertical, 4)
                .listRowBackground(Theme.card)
            }
            .onDelete { offsets in
                let ids = offsets.map { entries[$0].id }
                let indices = IndexSet(store.state.journal.indices.filter { ids.contains(store.state.journal[$0].id) })
                store.deleteJournal(at: indices)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Theme.bg.ignoresSafeArea())
        .navigationTitle("Bitácora")
        .toolbar {
            Button {
                showingEditor = true
            } label: {
                Image(systemName: "square.and.pencil")
            }
        }
        .sheet(isPresented: $showingEditor) {
            JournalEditor(initialKind: filter ?? .reflexion)
        }
    }

    private func filterChip(_ kind: JournalKind?, label: String, icon: String) -> some View {
        let selected = filter == kind
        return Button {
            filter = kind
        } label: {
            Label(label, systemImage: icon)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundStyle(selected ? Color.black : Color.white)
                .background(selected ? Theme.accent : Theme.card, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

struct JournalEditor: View {
    @EnvironmentObject private var store: ProgressStore
    @Environment(\.dismiss) private var dismiss

    @State private var kind: JournalKind
    @State private var title: String
    @State private var notes = ""
    @State private var mood = 3

    init(initialKind: JournalKind, initialTitle: String = "") {
        _kind = State(initialValue: initialKind)
        _title = State(initialValue: initialTitle)
    }

    private var prompt: String {
        switch kind {
        case .entrenamiento: "¿Qué has entrenado? ¿Cómo te has sentido? ¿Alguna molestia?"
        case .salida: "Ruta, duración, qué has observado, qué harías distinto."
        case .observacion: "Describe de arriba abajo: edad aprox., altura, complexión, ropa, calzado, rasgo distintivo. Sin nombres ni datos que identifiquen a nadie."
        case .estudio: "¿Qué has aprendido hoy? Explícalo con tus palabras."
        case .voluntariado: "¿Qué servicio has hecho? ¿Qué has aprendido de tus compañeros?"
        case .reflexion: "¿Por qué haces esto? ¿Cómo te sientes? ¿Qué te preocupa?"
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Tipo", selection: $kind) {
                    ForEach(JournalKind.allCases) { kind in
                        Label(kind.label, systemImage: kind.icon).tag(kind)
                    }
                }
                TextField("Título", text: $title)
                Section {
                    TextField(prompt, text: $notes, axis: .vertical)
                        .lineLimit(6...16)
                }
                Section("¿Cómo te has sentido?") {
                    Picker("Ánimo", selection: $mood) {
                        ForEach(1...5, id: \.self) { value in
                            Text(String(repeating: "★", count: value)).tag(value)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Nueva entrada")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        store.addJournal(JournalEntry(kind: kind,
                                                      title: title.isEmpty ? kind.label : title,
                                                      notes: notes,
                                                      mood: mood))
                        dismiss()
                    }
                }
            }
        }
    }
}
