import SwiftUI

struct ProgressionView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // En-tête avec icône de progression
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(Color.gracieBarraGold.opacity(0.2))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "chart.line.uptrend.xyaxis")
                                            .font(.system(size: 50, weight: .medium))
                                            .foregroundColor(Color.gracieBarraGold)
                                    )
                            }
                            
                            VStack(spacing: 8) {
                                Text("PROGRESSION")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(2)
                                
                                Text("Suivez votre évolution")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.gracieBarraGold)
                                    .tracking(1)
                            }
                        }
                        
                        // Section des ceintures
                        VStack(spacing: 20) {
                            Text("SYSTÈME DE CEINTURES")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            VStack(spacing: 15) {
                                BeltCard(
                                    belt: "Blanche",
                                    description: "Débutant",
                                    color: .white,
                                    isCurrent: true
                                )
                                
                                BeltCard(
                                    belt: "Bleue",
                                    description: "Intermédiaire",
                                    color: .blue,
                                    isCurrent: false
                                )
                                
                                BeltCard(
                                    belt: "Violette",
                                    description: "Avancé",
                                    color: .purple,
                                    isCurrent: false
                                )
                                
                                BeltCard(
                                    belt: "Marron",
                                    description: "Expert",
                                    color: Color(red: 0.6, green: 0.4, blue: 0.2),
                                    isCurrent: false
                                )
                                
                                BeltCard(
                                    belt: "Noire",
                                    description: "Maître",
                                    color: .black,
                                    isCurrent: false
                                )
                            }
                        }
                        
                        // Placeholder pour contenu futur
                        VStack(spacing: 15) {
                            Text("FONCTIONNALITÉS À VENIR")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.gracieBarraGold)
                                .tracking(1)
                            
                            Text("• Suivi des techniques\n• Tests de passage\n• Historique des grades\n• Objectifs personnels")
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
            .navigationTitle("Progression")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gracieBarraBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct BeltCard: View {
    let belt: String
    let description: String
    let color: Color
    let isCurrent: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            // Représentation de la ceinture
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 60, height: 12)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gracieBarraGold, lineWidth: isCurrent ? 2 : 0)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(belt)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            if isCurrent {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(Color.gracieBarraGold)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isCurrent ? Color.gracieBarraGold.opacity(0.5) : Color.clear, lineWidth: 1)
                )
        )
    }
}

#Preview {
    ProgressionView()
}
