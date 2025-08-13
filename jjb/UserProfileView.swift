import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 35) {
                        // En-tête avec avatar et informations
                        VStack(spacing: 25) {
                            // Avatar avec style Gracie Barra
                            ZStack {
                                Circle()
                                    .fill(LinearGradient.gracieBarraAvatar)
                                    .frame(width: 120, height: 120)
                                    .shadow(color: Color.gracieBarraGold.opacity(0.4), radius: 25)
                                
                                Text(String(authViewModel.user?.displayName?.prefix(1) ?? "U").uppercased())
                                    .font(.system(size: 50, weight: .black, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .accessibilityLabel("Avatar utilisateur")
                            
                            VStack(spacing: 12) {
                                Text(authViewModel.user?.displayName ?? "Membre Gracie Barra")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .accessibilityLabel("Nom d'utilisateur")
                                
                                Text(authViewModel.user?.email ?? "")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.2))
                                    .accessibilityLabel("Email utilisateur")
                                
                                // Badge de membre
                                HStack(spacing: 8) {
                                    Image(systemName: "shield.fill")
                                        .font(.caption)
                                        .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.2))
                                    
                                    Text("MEMBRE ACTIF")
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                        .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.2))
                                        .tracking(1)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.gracieBarraGold.opacity(0.2))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gracieBarraGold.opacity(0.4), lineWidth: 1)
                                        )
                                )
                            }
                        }
                        
                        // Informations du compte avec style Gracie Barra
                        VStack(spacing: 18) {
                            Text("INFORMATIONS DU COMPTE")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                                .padding(.bottom, 10)
                            
                            GracieBarraInfoRow(title: "ID Membre", value: authViewModel.user?.uid ?? "N/A", icon: "person.circle.fill")
                            GracieBarraInfoRow(title: "Membre depuis", value: formatDate(authViewModel.user?.metadata.creationDate), icon: "calendar.circle.fill")
                            GracieBarraInfoRow(title: "Dernière connexion", value: formatDate(authViewModel.user?.metadata.lastSignInDate), icon: "clock.circle.fill")
                        }
                        .padding(.horizontal, 25)
                        
                        Spacer(minLength: 40)
                        
                        // Bouton de déconnexion Gracie Barra
                        Button(action: {
                            authViewModel.signOut()
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .font(.title2)
                                Text("Se déconnecter")
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color(red: 0.7, green: 0.3, blue: 0.3))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 28)
                                            .stroke(Color(red: 0.8, green: 0.4, blue: 0.4).opacity(0.6), lineWidth: 1)
                                    )
                            )
                            .shadow(color: Color(red: 0.7, green: 0.3, blue: 0.3).opacity(0.4), radius: 15, x: 0, y: 8)
                        }
                        .padding(.horizontal, 30)
                        .accessibilityLabel("Se déconnecter")
                        
                        // Footer Gracie Barra
                        VStack(spacing: 15) {
                            Text("OSS!")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                                .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.2))
                                .tracking(3)
                            
                            Text("JIU-JITSU FOR EVERYONE")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                                .tracking(1)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                    }
                    .padding(.top, 30)
                }
            }
            .navigationTitle("Mon Profil")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gracieBarraBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: date)
    }
}

struct GracieBarraInfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color(red: 0.8, green: 0.6, blue: 0.2))
                .frame(width: 28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                
                Text(value)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
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
                        .stroke(Color(red: 0.8, green: 0.6, blue: 0.2).opacity(0.2), lineWidth: 1)
                )
        )
    }
}

#Preview {
    UserProfileView()
        .environmentObject(AuthViewModel())
}
