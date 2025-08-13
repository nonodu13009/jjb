import SwiftUI

struct RulesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 30) {
                        // En-tête avec icône de règles
                        VStack(spacing: 20) {
                            ZStack {
                                Circle()
                                    .fill(Color.gracieBarraGold.opacity(0.2))
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image(systemName: "book.closed.fill")
                                            .font(.system(size: 50, weight: .medium))
                                            .foregroundColor(Color.gracieBarraGold)
                                    )
                            }
                            
                            VStack(spacing: 8) {
                                Text("RÈGLES")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(2)
                                
                                Text("Respect et discipline")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.gracieBarraGold)
                                    .tracking(1)
                            }
                        }
                        
                        // Section des règles principales
                        VStack(spacing: 20) {
                            Text("RÈGLES DU CLUB")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            VStack(spacing: 15) {
                                RuleCard(
                                    title: "Respect",
                                    description: "Respectez tous les membres et instructeurs",
                                    icon: "heart.fill",
                                    color: Color.gracieBarraGold
                                )
                                
                                RuleCard(
                                    title: "Ponctualité",
                                    description: "Arrivez à l'heure pour tous les cours",
                                    icon: "clock.fill",
                                    color: Color.gracieBarraGold.opacity(0.8)
                                )
                                
                                RuleCard(
                                    title: "Hygiène",
                                    description: "Maintenez une hygiène impeccable",
                                    icon: "sparkles",
                                    color: Color.gracieBarraGold.opacity(0.6)
                                )
                                
                                RuleCard(
                                    title: "Discipline",
                                    description: "Suivez les instructions des professeurs",
                                    icon: "shield.fill",
                                    color: Color.gracieBarraGold.opacity(0.4)
                                )
                            }
                        }
                        
                        // Section des valeurs Gracie Barra
                        VStack(spacing: 20) {
                            Text("VALEURS GRACIE BARRA")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            VStack(spacing: 15) {
                                ValueCard(
                                    value: "Humilité",
                                    description: "Rester humble dans l'apprentissage",
                                    color: Color.gracieBarraGold
                                )
                                
                                ValueCard(
                                    value: "Persévérance",
                                    description: "Continuer malgré les difficultés",
                                    color: Color.gracieBarraGold.opacity(0.8)
                                )
                                
                                ValueCard(
                                    value: "Excellence",
                                    description: "Toujours viser le meilleur",
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
                            
                            Text("• Règlement complet\n• Code de conduite\n• Procédures disciplinaires\n• FAQ des règles")
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
            .navigationTitle("Règles")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gracieBarraBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct RuleCard: View {
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

struct ValueCard: View {
    let value: String
    let description: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(color)
                .tracking(1)
            
            Text(description)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    RulesView()
}
