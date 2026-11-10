import SwiftUI

// MARK: - Adaptar la sesión de hoy

struct CoachSection: View {
    @EnvironmentObject private var store: ProgressStore
    @AppStorage("groq.model") private var model = GroqCoach.defaultModel
    let workout: Workout
    let onAdapted: (Workout) -> Void

    @State private var hasKey = false
    @State private var custom = ""
    @State private var loading = false
    @State private var error: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Entrenador IA", systemImage: "sparkles").font(.headline).foregroundStyle(Theme.accent)
            if !hasKey {
                Text("Añade tu clave de Groq y podrás adaptar la sesión de hoy a cómo te encuentras.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                NavigationLink {
                    CoachSettingsView()
                } label: {
                    Label("Configurar el entrenador IA", systemImage: "key.fill").frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle(color: Theme.cardHighlight))
            } else {
                Text("¿Cómo estás hoy? La IA ajusta la sesión usando solo ejercicios de la app.")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                    ForEach(GroqCoach.requests, id: \.label) { request in
                        Button(request.label) { adapt(request.prompt) }
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Theme.cardHighlight, in: RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(.white)
                    }
                }
                .disabled(loading)
                HStack {
                    TextField("O cuéntale qué te pasa…", text: $custom)
                        .textFieldStyle(.roundedBorder)
                    Button("Adaptar") { adapt(custom) }
                        .disabled(custom.trimmingCharacters(in: .whitespaces).isEmpty || loading)
                }
                if loading {
                    ProgressView("Pensando tu sesión…").frame(maxWidth: .infinity)
                }
                if let error {
                    Text(error).font(.caption).foregroundStyle(Theme.danger)
                }
                if workout.id.hasPrefix("plan-ai-") {
                    Button("Volver a la sesión original") {
                        store.clearAISession()
                        if let original = store.originalPlanSession() { onAdapted(original) }
                    }
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                }
            }
        }
        .card(Theme.cardHighlight.opacity(0.6))
        .onAppear { hasKey = KeyStore.get() != nil }
    }

    private func adapt(_ request: String) {
        guard let key = KeyStore.get(), let answers = store.state.trainingPlan,
              let original = store.originalPlanSession() else { return }
        loading = true
        error = nil
        Task {
            do {
                let (session, used) = try await GroqCoach.adapt(workout: original, answers: answers, request: request, key: key, model: model)
                await MainActor.run {
                    store.setAISession(session)
                    model = used
                    custom = ""
                    loading = false
                    if let adapted = store.planSession() { onAdapted(adapted) }
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                    loading = false
                }
            }
        }
    }
}

// MARK: - Ajustes del entrenador IA

struct CoachSettingsView: View {
    @AppStorage("groq.model") private var model = GroqCoach.defaultModel
    @State private var key = ""
    @State private var saved = false
    @State private var status: String?
    @State private var testing = false

    var body: some View {
        Form {
            Section {
                SecureField("gsk_…", text: $key)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Button(saved ? "Clave guardada ✓" : "Guardar clave") {
                    KeyStore.set(key.trimmingCharacters(in: .whitespacesAndNewlines))
                    key = ""
                    saved = true
                }
                .disabled(key.trimmingCharacters(in: .whitespaces).isEmpty)
                if saved {
                    Button("Probar conexión") { test() }.disabled(testing)
                    Button("Borrar clave", role: .destructive) {
                        KeyStore.delete()
                        saved = false
                        status = nil
                    }
                }
                if let status { Text(status).font(.caption) }
            } header: {
                Text("Clave de Groq")
            } footer: {
                Text("Pega tu clave de API de Groq (la puedes reutilizar de otro proyecto o crear una gratis en console.groq.com/keys). Se guarda solo en el llavero de este iPhone: no se sube a GitHub ni sale en la copia de seguridad. Al adaptar una sesión se envía a Groq tu sesión de hoy, tu nivel y lo que escribas; nada más.")
            }
            Section {
                TextField("Modelo", text: $model)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            } header: {
                Text("Modelo")
            } footer: {
                Text("Si el modelo deja de existir, la app elige otro disponible automáticamente.")
            }
            Section {
                Link("Abrir la consola de Groq", destination: URL(string: "https://console.groq.com/keys")!)
            }
        }
        .navigationTitle("Entrenador IA")
        .onAppear { saved = KeyStore.get() != nil }
    }

    private func test() {
        guard let key = KeyStore.get() else { return }
        testing = true
        Task {
            do {
                let available = try await GroqCoach.pickModel(key: key)
                await MainActor.run { status = "Conexión correcta. Modelo disponible: \(available)"; testing = false }
            } catch {
                await MainActor.run { status = error.localizedDescription; testing = false }
            }
        }
    }
}
