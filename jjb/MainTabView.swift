import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Accueil
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Accueil")
                }
                .tag(0)
            
            // Entraînement
            TrainingView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "figure.martial.arts" : "figure.martial.arts")
                    Text("Entraînement")
                }
                .tag(1)
            
            // Progression
            ProgressionView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "chart.line.uptrend.xyaxis.fill" : "chart.line.uptrend.xyaxis")
                    Text("Progression")
                }
                .tag(2)
            
            // Règles
            RulesView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "book.closed.fill" : "book.closed")
                    Text("Règles")
                }
                .tag(3)
            
            // Profil
            UserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                    Text("Profil")
                }
                .tag(4)
        }
        .accentColor(Color.gracieBarraGold)
        .onAppear {
            // Configuration de l'apparence des onglets
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.gracieBarraBackground)
            
            // Couleur des onglets non sélectionnés
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.white.opacity(0.6))
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color.white.opacity(0.6))
            ]
            
            // Couleur des onglets sélectionnés
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.gracieBarraGold)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color.gracieBarraGold)
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthViewModel())
}
