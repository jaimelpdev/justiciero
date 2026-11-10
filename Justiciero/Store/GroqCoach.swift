import Foundation
import Security

/// Guarda la clave de Groq en el llavero del iPhone (nunca en el código ni en el progreso exportado).
enum KeyStore {
    private static let service = "justiciero.groq"

    static func get() -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service,
                                    kSecReturnData as String: true, kSecMatchLimit as String: kSecMatchLimitOne]
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess, let data = item as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    static func set(_ key: String) {
        delete()
        let item: [String: Any] = [kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service,
                                   kSecValueData as String: Data(key.utf8),
                                   kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly]
        SecItemAdd(item as CFDictionary, nil)
    }

    static func delete() {
        SecItemDelete([kSecClass as String: kSecClassGenericPassword, kSecAttrService as String: service] as CFDictionary)
    }
}

/// Sesión adaptada por el entrenador IA (solo con ejercicios de la biblioteca).
struct AISession: Codable {
    var title: String
    var notes: String
    var blocks: [AIBlock]
}

struct AIBlock: Codable {
    var id: String
    var sets: Int
    var reps: String?
    var seconds: Int?
    var rest: Int
}

/// Entrenador con IA a través de la API de Groq (compatible con OpenAI).
/// La misma lógica está en web/app.js (busca «GroqCoach»).
enum GroqCoach {
    static let defaultModel = "llama-3.3-70b-versatile"
    private static let base = "https://api.groq.com/openai/v1"

    static let impactIDs: Set<String> = ["jacks", "burpee", "skaters", "squat-jump", "sprawl", "precision"]
    static let barIDs: Set<String> = ["hang", "pullup-negative", "pullup-assisted", "pullup"]

    enum CoachError: LocalizedError {
        case http(Int, String)
        case invalid(String)

        var errorDescription: String? {
            switch self {
            case .http(401, _): "La clave de Groq no es válida. Revísala en Más › Entrenador IA."
            case .http(429, _): "Has llegado al límite de uso de Groq. Prueba en un rato."
            case .http(let code, let body): "Groq ha respondido con un error (\(code)). \(body.prefix(160))"
            case .invalid(let reason): "La respuesta de la IA no era válida: \(reason). Prueba otra vez."
            }
        }
    }

    struct Request: Hashable {
        let label: String
        let prompt: String
    }

    static let requests: [Request] = [
        Request(label: "Estoy cansado", prompt: "Hoy estoy cansado o he dormido mal: baja el volumen y la intensidad, pero que siga siendo útil."),
        Request(label: "Poco tiempo", prompt: "Hoy solo tengo unos 15 minutos: haz una versión corta e intensa."),
        Request(label: "Más caña", prompt: "Hoy me siento fuerte: sube un poco el reto sin cambiar el tipo de sesión."),
        Request(label: "Sorpréndeme", prompt: "Cámbiame los ejercicios por otros que trabajen lo mismo, para no aburrirme."),
    ]

    private static func prompt(workout: Workout, answers: PlanAnswers, request: String) -> [[String: String]] {
        let library = Exercises.library
            .filter { !(answers.lowImpact && impactIDs.contains($0.id)) && (answers.pullupBar || !barIDs.contains($0.id)) }
            .map { "\($0.id): \($0.name)" }
            .joined(separator: "\n")
        let session = workout.blocks.map { b in
            "- \(b.exercise.id) (\(b.exercise.name)): \(b.sets) series de \(b.reps.map { "\($0) repeticiones" } ?? "\(b.seconds ?? 0) s"), descanso \(b.rest) s"
        }.joined(separator: "\n")
        let system = """
        Eres un entrenador personal prudente que adapta sesiones de entrenamiento en casa con el peso corporal. \
        Respondes SOLO con JSON válido con esta forma: \
        {"title": "nombre corto de la sesión", "notes": "1 a 3 frases en español explicando el cambio", \
        "blocks": [{"id": "id del ejercicio", "sets": 3, "reps": "10" o null, "seconds": 30 o null, "rest": 60}]}. \
        Reglas: usa únicamente ids de la lista de ejercicios disponibles; cada bloque lleva reps (texto, puede ser "8/lado") o seconds, nunca los dos; \
        empieza con "mobility" de 60 a 120 segundos; entre 4 y 9 bloques; sets entre 1 y 6; rest entre 10 y 120. \
        Si la persona menciona dolor o una molestia, evita cargar esa zona y en notes recomiéndale parar si duele y consultar a un profesional si persiste. \
        No inventes ejercicios, no des consejos médicos y escribe en español de España.
        """
        let user = """
        Perfil: nivel \(PlanAnswers.levelNames[answers.level].lowercased()), objetivo \(answers.goal.label.lowercased()), \
        \(answers.lowImpact ? "sin saltos ni impacto" : "puede saltar"), \(answers.pullupBar ? "tiene barra de dominadas" : "sin barra de dominadas").
        Sesión de hoy (\(workout.name), unos \(workout.minutes) minutos):
        \(session)
        Petición: \(request)
        Ejercicios disponibles (id: nombre):
        \(library)
        """
        return [["role": "system", "content": system], ["role": "user", "content": user]]
    }

    /// Adapta la sesión. Devuelve la sesión validada y el modelo usado (por si hubo que cambiarlo).
    static func adapt(workout: Workout, answers: PlanAnswers, request: String, key: String, model: String) async throws -> (AISession, String) {
        do {
            return (try await call(workout: workout, answers: answers, request: request, key: key, model: model), model)
        } catch CoachError.http(let code, let body) where (code == 400 || code == 404) && body.contains("model") {
            // El modelo ya no existe: elige otro de los disponibles y reintenta una vez.
            let fallback = try await pickModel(key: key)
            return (try await call(workout: workout, answers: answers, request: request, key: key, model: fallback), fallback)
        }
    }

    private static func call(workout: Workout, answers: PlanAnswers, request: String, key: String, model: String) async throws -> AISession {
        var req = URLRequest(url: URL(string: "\(base)/chat/completions")!)
        req.httpMethod = "POST"
        req.timeoutInterval = 40
        req.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["model": model, "temperature": 0.6, "response_format": ["type": "json_object"],
                                   "messages": prompt(workout: workout, answers: answers, request: request)]
        req.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, response) = try await URLSession.shared.data(for: req)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard status == 200 else { throw CoachError.http(status, String(data: data, encoding: .utf8) ?? "") }
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let message = choices.first?["message"] as? [String: Any],
              let content = message["content"] as? String,
              let parsed = try JSONSerialization.jsonObject(with: Data(content.utf8)) as? [String: Any]
        else { throw CoachError.invalid("formato desconocido") }
        return try validate(parsed, answers: answers)
    }

    static func pickModel(key: String) async throws -> String {
        var req = URLRequest(url: URL(string: "\(base)/models")!)
        req.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: req)
        let status = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard status == 200 else { throw CoachError.http(status, String(data: data, encoding: .utf8) ?? "") }
        let ids = ((try JSONSerialization.jsonObject(with: data) as? [String: Any])?["data"] as? [[String: Any]] ?? [])
            .compactMap { $0["id"] as? String }
            .filter { id in !["whisper", "tts", "guard", "prompt", "playai", "orpheus"].contains { id.lowercased().contains($0) } }
        for preferred in ["llama-3.3-70b", "gpt-oss-120b", "llama-4", "qwen", "llama"] {
            if let id = ids.first(where: { $0.lowercased().contains(preferred) }) { return id }
        }
        guard let first = ids.first else { throw CoachError.invalid("no hay modelos de texto disponibles") }
        return first
    }

    /// Comprueba que la IA solo usa ejercicios de la biblioteca y cifras razonables.
    static func validate(_ json: [String: Any], answers: PlanAnswers) throws -> AISession {
        let known = Set(Exercises.library.map(\.id))
        guard let raw = json["blocks"] as? [[String: Any]] else { throw CoachError.invalid("faltan los bloques") }
        var blocks: [AIBlock] = []
        for item in raw.prefix(12) {
            guard let id = item["id"] as? String, known.contains(id),
                  !(answers.lowImpact && impactIDs.contains(id)), answers.pullupBar || !barIDs.contains(id) else { continue }
            let sets = min(6, max(1, (item["sets"] as? NSNumber)?.intValue ?? 1))
            let rest = min(180, max(0, (item["rest"] as? NSNumber)?.intValue ?? 30))
            var reps: String?
            if let text = item["reps"] as? String, !text.trimmingCharacters(in: .whitespaces).isEmpty { reps = String(text.prefix(15)) }
            if let number = item["reps"] as? NSNumber { reps = number.stringValue }
            let seconds = (item["seconds"] as? NSNumber).map { min(3600, max(5, $0.intValue)) }
            guard reps != nil || seconds != nil else { continue }
            blocks.append(AIBlock(id: id, sets: sets, reps: seconds == nil ? reps : nil, seconds: seconds, rest: rest))
        }
        if blocks.first?.id != "mobility" { blocks.insert(AIBlock(id: "mobility", sets: 1, reps: nil, seconds: 90, rest: 10), at: 0) }
        guard blocks.count >= 3 else { throw CoachError.invalid("muy pocos ejercicios válidos") }
        let title = String(((json["title"] as? String) ?? "Sesión adaptada").prefix(60))
        let notes = String(((json["notes"] as? String) ?? "").prefix(500))
        return AISession(title: title, notes: notes, blocks: blocks)
    }

    static func workout(_ ai: AISession, day: Int, focus: String) -> Workout {
        let byID = Dictionary(uniqueKeysWithValues: Exercises.library.map { ($0.id, $0) })
        let blocks = ai.blocks.compactMap { b in
            byID[b.id].map { WorkoutBlock(exercise: $0, sets: b.sets, reps: b.reps, seconds: b.seconds, rest: b.rest) }
        }
        return Workout(id: "plan-ai-\(day)", name: "\(ai.title) · IA", focus: focus, place: "Casa", minPhase: 0,
                       minutes: PlanEngine.estimate(blocks), notes: ai.notes.isEmpty ? nil : ai.notes, blocks: blocks)
    }
}
