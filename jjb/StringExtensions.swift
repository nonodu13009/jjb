import Foundation

extension String {
    
    /// Capitalise correctement les noms composés (ex: "jean-michel" -> "Jean-Michel")
    var capitalizedCompoundName: String {
        return self.components(separatedBy: .whitespaces)
            .map { word in
                // Gérer les noms avec tirets (ex: Jean-Michel, Marie-Claire)
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
    
    /// Capitalise correctement les noms de famille (ex: "de la roche" -> "De La Roche")
    var capitalizedFamilyName: String {
        let lowercaseWords = ["de", "la", "le", "du", "des", "von", "van", "di", "da"]
        
        return self.components(separatedBy: .whitespaces)
            .map { word in
                let lowercasedWord = word.lowercased()
                if lowercaseWords.contains(lowercasedWord) {
                    // Garder en minuscules pour les prépositions/articles
                    return lowercasedWord
                } else {
                    // Capitaliser normalement
                    return word.prefix(1).uppercased() + word.dropFirst().lowercased()
                }
            }
            .joined(separator: " ")
    }
    
    /// Formate un nom complet (prénom + nom de famille)
    var formattedFullName: String {
        let components = self.components(separatedBy: .whitespaces)
        guard components.count >= 2 else { return self.capitalizedCompoundName }
        
        let firstName = components[0].capitalizedCompoundName
        let lastName = components.dropFirst().joined(separator: " ").capitalizedFamilyName
        
        return "\(firstName) \(lastName)"
    }
    
    /// Vérifie si le nom est valide (au moins 2 caractères, pas de caractères spéciaux)
    var isValidName: Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= 2 else { return false }
        
        // Autoriser les lettres, espaces, tirets et apostrophes
        let allowedCharacters = CharacterSet.letters.union(.whitespaces).union(CharacterSet(charactersIn: "-'"))
        return trimmed.rangeOfCharacter(from: allowedCharacters.inverted) == nil
    }
    
    /// Nettoie et formate un nom pour l'affichage
    var cleanedAndFormattedName: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalizedCompoundName
    }
}
