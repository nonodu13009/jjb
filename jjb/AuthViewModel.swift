import SwiftUI
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        setupAuthStateListener()
    }
    
    private func setupAuthStateListener() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.user = user
                self?.isAuthenticated = user != nil
            }
        }
    }
    
    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            user = result.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func signUp(email: String, password: String, displayName: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // Formater correctement le nom d'affichage
            let formattedDisplayName = displayName.cleanedAndFormattedName
            
            // Mettre à jour le display name
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = formattedDisplayName
            try await changeRequest.commitChanges()
            
            // Créer le profil utilisateur dans Firestore
            try await createUserProfile(userId: result.user.uid, email: email, displayName: formattedDisplayName)
            
            user = result.user
            isAuthenticated = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func createUserProfile(userId: String, email: String, displayName: String) async throws {
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "email": email,
            "displayName": displayName,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        try await db.collection("users").document(userId).setData(userData)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
