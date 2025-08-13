import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // En-tête avec logo et titre
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(Color.gracieBarraGold)
                                    .frame(width: 120, height: 120)
                                    .shadow(color: Color.gracieBarraGold.opacity(0.3), radius: 20)
                                
                                Text("GB")
                                    .font(.system(size: 50, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            
                            VStack(spacing: 8) {
                                Text("GRACIE BARRA")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(2)
                                
                                Text("JIU-JITSU BRASILEIRO")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.gracieBarraGold)
                                    .tracking(1)
                            }
                        }
                        
                        // Section d'accueil
                        VStack(spacing: 20) {
                            Text("BIENVENUE")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            Text("Découvrez le Jiu-Jitsu Brésilien avec Gracie Barra")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                        }
                        
                        // Placeholder pour contenu futur
                        VStack(spacing: 15) {
                            Text("FONCTIONNALITÉS À VENIR")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.gracieBarraGold)
                                .tracking(1)
                            
                            Text("• Planning des cours\n• Réservations\n• Événements\n• Actualités du club")
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 25)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.08))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.gracieBarraGold.opacity(0.2), lineWidth: 1)
                                )
                        )
                        
                        Spacer(minLength: 40)
                    }
                    .padding(.top, 30)
                }
            }
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gracieBarraBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView()
}
