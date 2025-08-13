import SwiftUI
import FirebaseAuth

struct UserProfileView: View {
    @StateObject private var profileViewModel = UserProfileViewModel()
    @State private var showingEditProfile = false
    
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
                                
                                if let profile = profileViewModel.userProfile {
                                    Text(String(profile.firstName.prefix(1)).uppercased())
                                        .font(.system(size: 50, weight: .black, design: .rounded))
                                        .foregroundColor(.white)
                                } else {
                                    Text("U")
                                        .font(.system(size: 50, weight: .black, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            }
                            .accessibilityLabel("Avatar utilisateur")
                            
                            VStack(spacing: 12) {
                                if let profile = profileViewModel.userProfile {
                                    Text(profile.fullName)
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                        .accessibilityLabel("Nom complet")
                                    
                                    Text(profile.email)
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(Color.gracieBarraGold)
                                        .accessibilityLabel("Email utilisateur")
                                    
                                    // Badge de membre avec grade
                                    HStack(spacing: 8) {
                                        Image(systemName: "shield.fill")
                                            .font(.caption)
                                            .foregroundColor(Color.gracieBarraGold)
                                        
                                        Text("\(profile.jjbGrade.displayName) - \(profile.jjbGrade.description)")
                                            .font(.system(size: 12, weight: .bold, design: .rounded))
                                            .foregroundColor(Color.gracieBarraGold)
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
                                } else {
                                    Text("Membre Gracie Barra")
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("Chargement...")
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(Color.gracieBarraGold)
                                }
                            }
                        }
                        
                        // Informations détaillées du profil
                        if let profile = profileViewModel.userProfile {
                            VStack(spacing: 18) {
                                Text("INFORMATIONS PERSONNELLES")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(1)
                                    .padding(.bottom, 10)
                                
                                ProfileInfoRow(title: "Genre", value: profile.gender.displayName, icon: "person.circle.fill")
                                ProfileInfoRow(title: "Âge", value: profile.age.map { "\($0) ans" } ?? "Non renseigné", icon: "calendar.circle.fill")
                                ProfileInfoRow(title: "Poids", value: profile.weightFormatted, icon: "scalemass.fill")
                                ProfileInfoRow(title: "Grade JJB", value: "\(profile.jjbGrade.displayName) - \(profile.jjbGrade.description)", icon: "medal.fill")
                            }
                            .padding(.horizontal, 25)
                        }
                        
                        // Informations du compte
                        VStack(spacing: 18) {
                            Text("INFORMATIONS DU COMPTE")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                                .padding(.bottom, 10)
                            
                            if let profile = profileViewModel.userProfile {
                                ProfileInfoRow(title: "ID Membre", value: profile.id, icon: "person.circle.fill")
                                ProfileInfoRow(title: "Membre depuis", value: profile.birthDateFormatted, icon: "calendar.circle.fill")
                                ProfileInfoRow(title: "Dernière MAJ", value: profileViewModel.formatBirthDate(profile.updatedAt), icon: "clock.circle.fill")
                            }
                        }
                        .padding(.horizontal, 25)
                        
                        Spacer(minLength: 40)
                        
                        // Boutons d'action
                        VStack(spacing: 15) {
                            // Bouton d'édition du profil
                            Button(action: { showingEditProfile = true }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "pencil.circle.fill")
                                        .font(.title2)
                                    Text("Modifier mon profil")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(LinearGradient.gracieBarraGold)
                                .cornerRadius(28)
                                .shadow(color: Color.gracieBarraGold.opacity(0.4), radius: 15, x: 0, y: 8)
                            }
                            .accessibilityLabel("Modifier mon profil")
                            
                            // Bouton de déconnexion
                            Button(action: {
                                // Déconnexion via AuthViewModel
                                if let authViewModel = try? AuthViewModel() {
                                    authViewModel.signOut()
                                }
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
                            .accessibilityLabel("Se déconnecter")
                        }
                        .padding(.horizontal, 30)
                        
                        // Footer Gracie Barra
                        VStack(spacing: 15) {
                            Text("OSS!")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                                .foregroundColor(Color.gracieBarraGold)
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
            .sheet(isPresented: $showingEditProfile) {
                ProfileEditView()
                    .environmentObject(profileViewModel)
            }
        }
        .onAppear {
            profileViewModel.loadUserProfile()
        }
    }
}

struct ProfileInfoRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color.gracieBarraGold)
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
                        .stroke(Color.gracieBarraGold.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

#Preview {
    UserProfileView()
}
