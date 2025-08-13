import Foundation
import FirebaseFirestore

struct UserProfile: Codable, Identifiable {
    let id: String
    var firstName: String
    var lastName: String
    var displayName: String
    var email: String
    var gender: Gender
    var birthDate: Date?
    var weight: Double?
    var jjbGrade: JJBGrade
    var createdAt: Date
    var updatedAt: Date
    
    init(id: String, firstName: String, lastName: String, displayName: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.displayName = displayName
        self.email = email
        self.gender = .notSpecified
        self.birthDate = nil
        self.weight = nil
        self.jjbGrade = JJBGrade.white
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    var age: Int? {
        guard let birthDate = birthDate else { return nil }
        return Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year
    }
    
    var weightFormatted: String {
        guard let weight = weight else { return "Non renseigné" }
        return "\(Int(weight)) kg"
    }
    
    var birthDateFormatted: String {
        guard let birthDate = birthDate else { return "Non renseignée" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: birthDate)
    }
}

// Enum pour le genre
enum Gender: String, CaseIterable, Codable {
    case male = "male"
    case female = "female"
    case notSpecified = "not_specified"
    
    var displayName: String {
        switch self {
        case .male: return "Homme"
        case .female: return "Femme"
        case .notSpecified: return "Non spécifié"
        }
    }
    
    var icon: String {
        switch self {
        case .male: return "person.fill"
        case .female: return "person.fill"
        case .notSpecified: return "person"
        }
    }
    
    var color: String {
        switch self {
        case .male: return "blue"
        case .female: return "pink"
        case .notSpecified: return "gray"
        }
    }
}

// Enum pour les grades JJB
enum JJBGrade: String, CaseIterable, Codable {
    case white = "white"
    case blue = "blue"
    case purple = "purple"
    case brown = "brown"
    case black = "black"
    
    var displayName: String {
        switch self {
        case .white: return "Blanche"
        case .blue: return "Bleue"
        case .purple: return "Violette"
        case .brown: return "Marron"
        case .black: return "Noire"
        }
    }
    
    var color: String {
        switch self {
        case .white: return "white"
        case .blue: return "blue"
        case .purple: return "purple"
        case .brown: return "brown"
        case .black: return "black"
        }
    }
    
    var maxStripes: Int {
        switch self {
        case .white: return 4
        case .blue: return 4
        case .purple: return 4
        case .brown: return 4
        case .black: return 6
        }
    }
    
    var description: String {
        switch self {
        case .white: return "Débutant"
        case .blue: return "Intermédiaire"
        case .purple: return "Avancé"
        case .brown: return "Expert"
        case .black: return "Maître"
        }
    }
}

// Extension pour la conversion Firestore
extension UserProfile {
    var firestoreData: [String: Any] {
        var data: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "displayName": displayName,
            "email": email,
            "gender": gender.rawValue,
            "jjbGrade": jjbGrade.rawValue,
            "updatedAt": FieldValue.serverTimestamp()
        ]
        
        if let birthDate = birthDate {
            data["birthDate"] = birthDate
        }
        
        if let weight = weight {
            data["weight"] = weight
        }
        
        return data
    }
    
    static func fromFirestore(_ document: DocumentSnapshot) -> UserProfile? {
        guard let data = document.data() else { return nil }
        
        let id = document.documentID
        let firstName = data["firstName"] as? String ?? ""
        let lastName = data["lastName"] as? String ?? ""
        let displayName = data["displayName"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let genderRaw = data["gender"] as? String ?? "not_specified"
        let gender = Gender(rawValue: genderRaw) ?? .notSpecified
        let jjbGradeRaw = data["jjbGrade"] as? String ?? "white"
        let jjbGrade = JJBGrade(rawValue: jjbGradeRaw) ?? .white
        
        let birthDate = data["birthDate"] as? Timestamp
        let weight = data["weight"] as? Double
        
        let createdAt = (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
        let updatedAt = (data["updatedAt"] as? Timestamp)?.dateValue() ?? Date()
        
        var profile = UserProfile(id: id, firstName: firstName, lastName: lastName, displayName: displayName, email: email)
        profile.gender = gender
        profile.birthDate = birthDate?.dateValue()
        profile.weight = weight
        profile.jjbGrade = jjbGrade
        profile.createdAt = createdAt
        profile.updatedAt = updatedAt
        
        return profile
    }
}
