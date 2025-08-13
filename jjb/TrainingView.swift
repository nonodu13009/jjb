import SwiftUI

struct TrainingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // En-tête avec icône d'entraînement
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(Color.gracieBarraGold.opacity(0.2))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "figure.martial.arts")
                                            .font(.system(size: 50, weight: .medium))
                                            .foregroundColor(Color.gracieBarraGold)
                                    )
                            }
                            
                            VStack(spacing: 8) {
                                Text("ENTRAÎNEMENT")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(2)
                                
                                Text("Développez vos compétences")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.gracieBarraGold)
                                    .tracking(1)
                            }
                        }
                        
                        // Section des types d'entraînement
                        VStack(spacing: 20) {
                            Text("TYPES D'ENTRAÎNEMENT")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            VStack(spacing: 15) {
                                TrainingTypeCard(
                                    title: "Technique",
                                    description: "Apprentissage des mouvements",
                                    icon: "figure.martial.arts",
                                    color: Color.gracieBarraGold
                                )
                                
                                TrainingTypeCard(
                                    title: "Combat",
                                    description: "Sparring et compétition",
                                    icon: "figure.wrestling",
                                    color: Color.gracieBarraGold.opacity(0.8)
                                )
                                
                                TrainingTypeCard(
                                    title: "Conditionnement",
                                    description: "Force et endurance",
                                    icon: "figure.strengthtraining.traditional",
                                    color: Color.gracieBarraGold.opacity(0.6)
                                )
                            }
                        }
                        
                        // Placeholder pour contenu futur
                        VStack(spacing: 15) {
                            Text("FONCTIONNALITÉS À VENIR")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(Color.gracieBarraGold)
                                .tracking(1)
                            
                            Text("• Planning des cours\n• Réservations\n• Suivi des entraînements\n• Vidéos techniques")
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
            .navigationTitle("Entraînement")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gracieBarraBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct TrainingTypeCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(color.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    TrainingView()
}
