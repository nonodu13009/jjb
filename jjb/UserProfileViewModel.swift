import SwiftUI
import FirebaseFirestore
import FirebaseAuth

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isEditing = false
    
    private let db = Firestore.firestore()
    
    init() {
        loadUserProfile()
    }
    
    // Charger le profil utilisateur depuis Firestore
    func loadUserProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        errorMessage = nil
        
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Erreur lors du chargement: \(error.localizedDescription)"
                    return
                }
                
                if let document = document, let profile = UserProfile.fromFirestore(document) {
                    self?.userProfile = profile
                } else {
                    // Créer un profil par défaut si aucun n'existe
                    self?.createDefaultProfile(userId: userId)
                }
            }
        }
    }
    
    // Créer un profil par défaut
    private func createDefaultProfile(userId: String) {
        guard let user = Auth.auth().currentUser else { return }
        
        let profile = UserProfile(
            id: userId,
            firstName: user.displayName ?? "",
            lastName: "",
            displayName: user.displayName ?? "",
            email: user.email ?? ""
        )
        
        saveUserProfile(profile)
    }
    
    // Sauvegarder le profil utilisateur
    func saveUserProfile(_ profile: UserProfile) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        errorMessage = nil
        
        db.collection("users").document(userId).setData(profile.firestoreData, merge: true) { [weak self] error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Erreur lors de la sauvegarde: \(error.localizedDescription)"
                } else {
                    self?.userProfile = profile
                    self?.isEditing = false
                }
            }
        }
    }
    
    // Mettre à jour le profil
    func updateProfile(
        firstName: String,
        lastName: String,
        gender: Gender,
        birthDate: Date?,
        weight: Double?,
        jjbGrade: JJBGrade
    ) {
        guard var profile = userProfile else { return }
        
        profile.firstName = firstName
        profile.lastName = lastName
        profile.gender = gender
        profile.birthDate = birthDate
        profile.weight = weight
        profile.jjbGrade = jjbGrade
        profile.updatedAt = Date()
        
        saveUserProfile(profile)
    }
    
    // Mettre à jour le nom d'affichage Firebase Auth
    func updateDisplayName(_ displayName: String) {
        guard let user = Auth.auth().currentUser else { return }
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        
        changeRequest.commitChanges { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Erreur lors de la mise à jour du nom: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Formater le poids pour l'affichage
    func formatWeight(_ weight: Double?) -> String {
        guard let weight = weight else { return "Non renseigné" }
        return "\(Int(weight)) kg"
    }
    
    // Formater la date de naissance pour l'affichage
    func formatBirthDate(_ date: Date?) -> String {
        guard let date = date else { return "Non renseignée" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: date)
    }
    
    // Calculer l'âge
    func calculateAge(from birthDate: Date?) -> Int? {
        guard let birthDate = birthDate else { return nil }
        return Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year
    }
    
    // Valider les données du profil
    func validateProfile(
        firstName: String,
        lastName: String,
        weight: Double?
    ) -> Bool {
        guard !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Le prénom et le nom sont obligatoires"
            return false
        }
        
        if let weight = weight {
            guard weight > 0 && weight <= 500 else {
                errorMessage = "Le poids doit être entre 0.1 et 500 kg"
                return false
            }
        }
        
        return true
    }
}
