import SwiftUI

struct AuthView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var isSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var displayName = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                .ignoresSafeArea()
                
                VStack(spacing: 35) {
                    // Logo et titre Gracie Barra
                    VStack(spacing: 25) {
                        // Logo placeholder (vous pourrez ajouter le vrai logo Gracie Barra)
                        ZStack {
                            Circle()
                                .fill(Color.gracieBarraGold)
                                .frame(width: 140, height: 140)
                                .shadow(color: Color.gracieBarraGold.opacity(0.3), radius: 20)
                            
                            Text("GB")
                                .font(.system(size: 60, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                        }
                        .accessibilityLabel("Logo Gracie Barra")
                        
                        VStack(spacing: 8) {
                            Text("GRACIE BARRA")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(2)
                            
                            Text("JIU-JITSU BRASILEIRO")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(Color.gracieBarraGold)
                                .tracking(1)
                        }
                    }
                    
                    // Formulaire avec style Gracie Barra
                    VStack(spacing: 22) {
                        if isSignUp {
                            CustomTextField(
                                text: $displayName,
                                placeholder: "Nom d'utilisateur",
                                icon: "person.fill"
                            )
                        }
                        
                        CustomTextField(
                            text: $email,
                            placeholder: "Email",
                            icon: "envelope.fill",
                            keyboardType: .emailAddress
                        )
                        
                        CustomSecureField(
                            text: $password,
                            placeholder: "Mot de passe",
                            icon: "lock.fill"
                        )
                        
                        // Bouton d'action Gracie Barra
                        Button(action: {
                            Task {
                                if isSignUp {
                                    await authViewModel.signUp(email: email, password: password, displayName: displayName)
                                } else {
                                    await authViewModel.signIn(email: email, password: password)
                                }
                            }
                        }) {
                            HStack(spacing: 12) {
                                if authViewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.9)
                                } else {
                                    Image(systemName: isSignUp ? "person.badge.plus" : "person.fill")
                                        .font(.title2)
                                }
                                
                                Text(isSignUp ? "Créer mon compte" : "Me connecter")
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(LinearGradient.gracieBarraGold)
                            .cornerRadius(28)
                            .shadow(color: Color.gracieBarraGold.opacity(0.4), radius: 15, x: 0, y: 8)
                        }
                        .disabled(authViewModel.isLoading || email.isEmpty || password.isEmpty || (isSignUp && displayName.isEmpty))
                        .accessibilityLabel(isSignUp ? "Créer mon compte" : "Me connecter")
                        
                        // Message d'erreur
                        if let errorMessage = authViewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(Color(red: 0.9, green: 0.4, blue: 0.4))
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .accessibilityLabel("Message d'erreur: \(errorMessage)")
                        }
                    }
                    .padding(.horizontal, 35)
                    
                    // Basculer entre connexion et inscription
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            isSignUp.toggle()
                            authViewModel.errorMessage = nil
                        }
                    }) {
                        Text(isSignUp ? "Déjà membre ? Se connecter" : "Nouveau membre ? S'inscrire")
                            .foregroundColor(Color.gracieBarraGold)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .underline()
                    }
                    .accessibilityLabel(isSignUp ? "Basculer vers la connexion" : "Basculer vers l'inscription")
                    
                    Spacer()
                    
                    // Footer Gracie Barra
                    Text("JIU-JITSU FOR EVERYONE")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .tracking(1)
                        .padding(.bottom, 20)
                }
                .padding(.top, 60)
            }
            .navigationBarHidden(true)
        }
        .environmentObject(authViewModel)
    }
}

// Composants personnalisés avec style Gracie Barra
struct CustomTextField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(Color.gracieBarraGold)
                .frame(width: 24)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.leading, 0)
                }
                
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.words)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .accentColor(Color.gracieBarraGold)
                    .onChange(of: text) { newValue in
                        // Capitaliser chaque mot du prénom composé
                        if icon == "person.fill" {
                            text = capitalizeCompoundName(newValue)
                        }
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                )
        )
        .accessibilityLabel(placeholder)
    }
    
    // Fonction pour capitaliser les prénoms composés
    private func capitalizeCompoundName(_ name: String) -> String {
        return name.components(separatedBy: .whitespaces)
            .map { word in
                // Gérer les prénoms avec tirets (ex: Jean-Michel)
                if word.contains("-") {
                    return word.components(separatedBy: "-")
                        .map { part in
                            part.prefix(1).uppercased() + part.dropFirst().lowercased()
                        }
                        .joined(separator: "-")
                } else {
                    // Capitaliser le premier caractère, minuscules pour le reste
                    return word.prefix(1).uppercased() + word.dropFirst().lowercased()
                }
            }
            .joined(separator: " ")
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String
    let icon: String
    @State private var isPasswordVisible = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(Color.gracieBarraGold)
                .frame(width: 24)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.leading, 0)
                }
                
                if isPasswordVisible {
                    TextField("", text: $text)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .accentColor(Color.gracieBarraGold)
                } else {
                    SecureField("", text: $text)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.white)
                        .accentColor(Color.gracieBarraGold)
                }
            }
            
            // Bouton pour révéler/masquer le mot de passe
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPasswordVisible.toggle()
                }
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .font(.title3)
                    .foregroundColor(Color.gracieBarraGold)
                    .frame(width: 24)
            }
            .accessibilityLabel(isPasswordVisible ? "Masquer le mot de passe" : "Révéler le mot de passe")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                )
        )
        .accessibilityLabel(placeholder)
    }
}

#Preview {
    AuthView()
}
