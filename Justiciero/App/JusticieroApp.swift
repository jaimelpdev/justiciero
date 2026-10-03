import SwiftUI

@main
struct JusticieroApp: App {
    @StateObject private var store = ProgressStore()

    var body: some Scene {
        WindowGroup {
            Group {
                if store.state.profile.onboarded {
                    RootView()
                } else {
                    OnboardingView()
                }
            }
            .environmentObject(store)
            .preferredColorScheme(.dark)
            .tint(Theme.accent)
        }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem { Label("Base", systemImage: "moon.stars.fill") }
            ProgramView()
                .tabItem { Label("Programa", systemImage: "map.fill") }
            TrainingView()
                .tabItem { Label("Entreno", systemImage: "figure.strengthtraining.traditional") }
            AcademyView()
                .tabItem { Label("Academia", systemImage: "book.closed.fill") }
            MoreView()
                .tabItem { Label("Más", systemImage: "ellipsis.circle.fill") }
        }
    }
}
