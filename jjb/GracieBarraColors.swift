import SwiftUI

// Couleurs officielles Gracie Barra
extension Color {
    // Couleur principale dorée
    static let gracieBarraGold = Color(red: 0.8, green: 0.6, blue: 0.2)
    
    // Variantes de la couleur dorée
    static let gracieBarraGoldLight = Color(red: 0.9, green: 0.7, blue: 0.3)
    static let gracieBarraGoldDark = Color(red: 0.7, green: 0.5, blue: 0.15)
    
    // Couleurs de fond sombres
    static let gracieBarraBackground = Color(red: 0.1, green: 0.1, blue: 0.15)
    static let gracieBarraBackgroundDark = Color(red: 0.05, green: 0.05, blue: 0.1)
    
    // Couleurs d'accent
    static let gracieBarraAccent = Color(red: 0.8, green: 0.6, blue: 0.2)
    static let gracieBarraSecondary = Color(red: 0.6, green: 0.4, blue: 0.1)
    
    // Couleurs d'état
    static let gracieBarraSuccess = Color(red: 0.2, green: 0.7, blue: 0.4)
    static let gracieBarraError = Color(red: 0.9, green: 0.4, blue: 0.4)
    static let gracieBarraWarning = Color(red: 0.9, green: 0.7, blue: 0.3)
    
    // Couleurs de texte
    static let gracieBarraTextPrimary = Color.white
    static let gracieBarraTextSecondary = Color.white.opacity(0.8)
    static let gracieBarraTextTertiary = Color.white.opacity(0.6)
}

// Gradients Gracie Barra
extension LinearGradient {
    static let gracieBarraBackground = LinearGradient(
        gradient: Gradient(colors: [
            .gracieBarraBackground,
            .gracieBarraBackgroundDark
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let gracieBarraGold = LinearGradient(
        gradient: Gradient(colors: [
            .gracieBarraGold,
            .gracieBarraGoldLight
        ]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let gracieBarraAvatar = LinearGradient(
        gradient: Gradient(colors: [
            .gracieBarraGold,
            .gracieBarraGoldLight
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
