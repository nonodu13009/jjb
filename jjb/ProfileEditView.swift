import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var profileViewModel: UserProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var selectedGender: Gender = .notSpecified
    @State private var selectedDay: Int = 1
    @State private var selectedMonth: Int = 1
    @State private var selectedYear: Int = 2000
    @State private var weight: String = ""
    @State private var selectedGrade: JJBGrade = .white
    @State private var selectedStripes: Int = 0
    
    private let days = Array(1...31)
    private let months = Array(1...12)
    private let years = Array(1900...Calendar.current.component(.year, from: Date()))
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arrière-plan avec dégradé Gracie Barra
                LinearGradient.gracieBarraBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // En-tête
                        VStack(spacing: 15) {
                            Text("MODIFIER MON PROFIL")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .tracking(1)
                            
                            Text("Mettez à jour vos informations personnelles")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(Color.gracieBarraGold)
                                .multilineTextAlignment(.center)
                        }
                        
                        // Formulaire
                        VStack(spacing: 20) {
                            // Genre
                            VStack(alignment: .leading, spacing: 12) {
                                Text("GENRE")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(1)
                                
                                HStack(spacing: 15) {
                                    ForEach(Gender.allCases, id: \.self) { gender in
                                        GenderButton(
                                            gender: gender,
                                            isSelected: selectedGender == gender,
                                            action: { selectedGender = gender }
                                        )
                                    }
                                }
                            }
                            
                            // Prénom et Nom
                            HStack(spacing: 15) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("PRÉNOM")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                        .tracking(1)
                                    
                                    TextField("Prénom", text: $firstName)
                                        .textFieldStyle(GracieBarraTextFieldStyle())
                                        .autocapitalization(.words)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("NOM")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                        .tracking(1)
                                    
                                    TextField("Nom", text: $lastName)
                                        .textFieldStyle(GracieBarraTextFieldStyle())
                                        .autocapitalization(.words)
                                }
                            }
                            
                            // Date de naissance
                            VStack(alignment: .leading, spacing: 12) {
                                Text("DATE DE NAISSANCE")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(1)
                                
                                HStack(spacing: 15) {
                                    // Jour
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("JOUR")
                                            .font(.system(size: 12, weight: .medium, design: .rounded))
                                            .foregroundColor(.white.opacity(0.8))
                                        
                                        Picker("Jour", selection: $selectedDay) {
                                            ForEach(days, id: \.self) { day in
                                                Text("\(day)").tag(day)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.1))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                                                )
                                        )
                                    }
                                    
                                    // Mois
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("MOIS")
                                            .font(.system(size: 12, weight: .medium, design: .rounded))
                                            .foregroundColor(.white.opacity(0.8))
                                        
                                        Picker("Mois", selection: $selectedMonth) {
                                            ForEach(months, id: \.self) { month in
                                                Text("\(month)").tag(month)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.1))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                                                )
                                        )
                                    }
                                    
                                    // Année
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("ANNÉE")
                                            .font(.system(size: 12, weight: .medium, design: .rounded))
                                            .foregroundColor(.white.opacity(0.8))
                                        
                                        Picker("Année", selection: $selectedYear) {
                                            ForEach(years, id: \.self) { year in
                                                Text("\(year)").tag(year)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.1))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                                                )
                                        )
                                    }
                                }
                            }
                            
                            // Poids
                            VStack(alignment: .leading, spacing: 12) {
                                Text("POIDS (KG)")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(1)
                                
                                WeightSelector(weight: $weight)
                            }
                            
                            // Grade JJB
                            VStack(alignment: .leading, spacing: 15) {
                                Text("GRADE JJB")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .tracking(1)
                                
                                // Sélection de la ceinture
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("CEINTURE")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    HStack(spacing: 12) {
                                        ForEach(JJBGrade.allCases, id: \.self) { grade in
                                            BeltButton(
                                                grade: grade,
                                                isSelected: selectedGrade == grade,
                                                action: {
                                                    selectedGrade = grade
                                                    selectedStripes = 0
                                                }
                                            )
                                        }
                                    }
                                }
                                
                                // Sélection des barrettes
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("BARRETTES")
                                        .font(.system(size: 14, weight: .medium, design: .rounded))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    HStack(spacing: 8) {
                                        ForEach(0...selectedGrade.maxStripes, id: \.self) { stripe in
                                            StripeButton(
                                                stripe: stripe,
                                                isSelected: selectedStripes == stripe,
                                                action: { selectedStripes = stripe }
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Spacer(minLength: 40)
                        
                        // Boutons d'action
                        VStack(spacing: 15) {
                            // Bouton de sauvegarde
                            Button(action: saveProfile) {
                                HStack(spacing: 12) {
                                    if profileViewModel.isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .scaleEffect(0.9)
                                    } else {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.title2)
                                    }
                                    
                                    Text("Sauvegarder")
                                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(LinearGradient.gracieBarraGold)
                                .cornerRadius(28)
                                .shadow(color: Color.gracieBarraGold.opacity(0.4), radius: 15, x: 0, y: 8)
                            }
                            .disabled(profileViewModel.isLoading)
                            
                            // Bouton d'annulation
                            Button(action: { dismiss() }) {
                                Text("Annuler")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.gracieBarraGold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gracieBarraGold, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Modifier le profil")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.gracieBarraBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Terminé") {
                        dismiss()
                    }
                    .foregroundColor(Color.gracieBarraGold)
                }
            }
        }
        .onAppear {
            loadCurrentProfile()
        }
    }
    
    private func loadCurrentProfile() {
        guard let profile = profileViewModel.userProfile else { return }
        
        firstName = profile.firstName
        lastName = profile.lastName
        selectedGender = profile.gender
        
        if let birthDate = profile.birthDate {
            let calendar = Calendar.current
            selectedDay = calendar.component(.day, from: birthDate)
            selectedMonth = calendar.component(.month, from: birthDate)
            selectedYear = calendar.component(.year, from: birthDate)
        }
        
        if let weight = profile.weight {
            // Formater le poids avec ou sans décimales
            if weight.truncatingRemainder(dividingBy: 1) == 0 {
                self.weight = String(Int(weight))
            } else {
                self.weight = String(format: "%.1f", weight)
            }
        } else {
            self.weight = ""
        }
        
        selectedGrade = profile.jjbGrade
        // Note: Les barrettes ne sont pas encore stockées dans le modèle
    }
    
    private func saveProfile() {
        // Validation
        guard profileViewModel.validateProfile(
            firstName: firstName,
            lastName: lastName,
            weight: weight.isEmpty ? nil : Double(weight)
        ) else { return }
        
        // Création de la date de naissance
        var birthDate: Date?
        if selectedDay > 0 && selectedMonth > 0 && selectedYear > 0 {
            var components = DateComponents()
            components.day = selectedDay
            components.month = selectedMonth
            components.year = selectedYear
            birthDate = Calendar.current.date(from: components)
        }
        
        // Conversion du poids
        let weightValue = weight.isEmpty ? nil : Double(weight)
        
        // Mise à jour du profil
        profileViewModel.updateProfile(
            firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
            lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines),
            gender: selectedGender,
            birthDate: birthDate,
            weight: weightValue,
            jjbGrade: selectedGrade
        )
        
        // Mise à jour du nom d'affichage
        let displayName = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        profileViewModel.updateDisplayName(displayName)
        
        dismiss()
    }
}

// Composants personnalisés
struct GenderButton: View {
    let gender: Gender
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: gender.icon)
                    .font(.title2)
                    .foregroundColor(isSelected ? Color.gracieBarraGold : .white.opacity(0.6))
                
                Text(gender.displayName)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(isSelected ? Color.gracieBarraGold : .white.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.gracieBarraGold.opacity(0.2) : Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? Color.gracieBarraGold : Color.clear, lineWidth: 2)
                    )
            )
        }
    }
}

struct BeltButton: View {
    let grade: JJBGrade
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(grade.color))
                    .frame(width: 40, height: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.gracieBarraGold : Color.clear, lineWidth: 2)
                    )
                
                Text(grade.displayName)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(isSelected ? Color.gracieBarraGold : .white.opacity(0.8))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.gracieBarraGold.opacity(0.2) : Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? Color.gracieBarraGold : Color.clear, lineWidth: 2)
                    )
            )
        }
    }
}

struct StripeButton: View {
    let stripe: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                if stripe == 0 {
                    Text("0")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(isSelected ? Color.gracieBarraGold : .white.opacity(0.6))
                } else {
                    HStack(spacing: 2) {
                        ForEach(0..<stripe, id: \.self) { _ in
                            Rectangle()
                                .fill(isSelected ? Color.gracieBarraGold : .white.opacity(0.6))
                                .frame(width: 8, height: 3)
                                .cornerRadius(1.5)
                        }
                    }
                }
                
                Text("\(stripe)")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(isSelected ? Color.gracieBarraGold : .white.opacity(0.6))
            }
            .frame(width: 40, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.gracieBarraGold.opacity(0.2) : Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.gracieBarraGold : Color.clear, lineWidth: 2)
                    )
            )
        }
    }
}

struct GracieBarraTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .foregroundColor(.white)
            .accentColor(Color.gracieBarraGold)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                    )
            )
    }
}

struct WeightSelector: View {
    @Binding var weight: String
    
    var body: some View {
        VStack(spacing: 15) {
            // Affichage du poids actuel
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Text(weight.isEmpty ? "0" : weight)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("kg")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color.gracieBarraGold)
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gracieBarraGold.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Boutons de réglage
            VStack(spacing: 12) {
                // Boutons +10, +1, +0.1
                HStack(spacing: 12) {
                    WeightButton(title: "+10", action: { adjustWeight(10) })
                    WeightButton(title: "+1", action: { adjustWeight(1) })
                    WeightButton(title: "+0.1", action: { adjustWeight(0.1) })
                }
                
                // Boutons -10, -1, -0.1
                HStack(spacing: 12) {
                    WeightButton(title: "-10", action: { adjustWeight(-10) })
                    WeightButton(title: "-1", action: { adjustWeight(-1) })
                    WeightButton(title: "-0.1", action: { adjustWeight(-0.1) })
                }
            }
            
            // Bouton de réinitialisation
            Button(action: resetWeight) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .font(.caption)
                    Text("Réinitialiser")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                }
                .foregroundColor(Color.gracieBarraGold)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gracieBarraGold.opacity(0.4), lineWidth: 1)
                )
            }
        }
    }
    
    private func adjustWeight(_ adjustment: Double) {
        let currentWeight = Double(weight) ?? 0.0
        let newWeight = currentWeight + adjustment
        
        // Limiter le poids entre 0 et 500 kg
        let clampedWeight = max(0, min(500, newWeight))
        
        // Formater le poids (afficher les décimales seulement si nécessaire)
        if clampedWeight.truncatingRemainder(dividingBy: 1) == 0 {
            weight = String(Int(clampedWeight))
        } else {
            weight = String(format: "%.1f", clampedWeight)
        }
    }
    
    private func resetWeight() {
        weight = ""
    }
}

struct WeightButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gracieBarraGold.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gracieBarraGold, lineWidth: 1.5)
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProfileEditView()
        .environmentObject(UserProfileViewModel())
}
