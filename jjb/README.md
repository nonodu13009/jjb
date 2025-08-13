# 🥋 Gracie Barra - Application Mobile

[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-orange.svg)](https://developer.apple.com/xcode/swiftui/)
[![Firebase](https://img.shields.io/badge/Firebase-10.0+-yellow.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Application mobile officielle du club Gracie Barra pour la gestion des membres et l'authentification.

## ✨ Fonctionnalités

- 🔐 **Authentification sécurisée** avec Firebase
- 👤 **Gestion des profils** utilisateurs
- 🎨 **Design moderne** avec identité visuelle Gracie Barra
- 📱 **Interface accessible** (VoiceOver, Dynamic Type)
- 🔄 **Mode offline** avec synchronisation automatique
- 🛡️ **Sécurité** propriétaire-uniquement

## 🚀 Installation

### Prérequis
- Xcode 15.0+
- iOS 15.0+
- Compte Firebase

### 1. Cloner le dépôt
```bash
git clone https://github.com/nonodu13009/jjb.git
cd jjb
```

### 2. Installer les dépendances Firebase
- Ouvrir `jjb.xcodeproj` dans Xcode
- File → Add Package Dependencies
- Ajouter : `https://github.com/firebase/firebase-ios-sdk`
- Sélectionner les packages nécessaires

### 3. Configuration Firebase
- Télécharger `GoogleService-Info.plist` depuis Firebase Console
- Ajouter le fichier au projet Xcode
- Configurer les règles de sécurité (voir `firebase.config.md`)

### 4. Build et Run
```bash
# Ouvrir dans Xcode
open jjb.xcodeproj

# Ou build en ligne de commande
xcodebuild -project jjb.xcodeproj -scheme jjb -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 🏗️ Architecture

```
jjb/
├── jjbApp.swift              # Point d'entrée avec configuration Firebase
├── ContentView.swift         # Gestion de l'état d'authentification
├── AuthView.swift            # Interface de connexion/inscription
├── UserProfileView.swift     # Profil utilisateur connecté
├── AuthViewModel.swift       # Logique d'authentification
├── GracieBarraColors.swift   # Système de couleurs cohérent
├── firestore.rules          # Règles de sécurité Firestore
├── storage.rules            # Règles de sécurité Storage
└── firebase.config.md       # Guide de configuration Firebase
```

## 🎨 Design System

### Couleurs officielles Gracie Barra
- **Gracie Barra Gold** : #CC9933 (couleur principale)
- **Background sombre** : Thème martial professionnel
- **Accents dorés** : Éléments interactifs et badges

### Typographie
- **Police arrondie** : Design moderne et accessible
- **Tracking** : Espacement des lettres pour la lisibilité
- **Hiérarchie claire** : Titres, sous-titres et corps de texte

## 🔧 Configuration Firebase

### Services activés
- ✅ **Authentication** : Email/Password
- ✅ **Firestore** : Base de données NoSQL
- ✅ **Storage** : Stockage de fichiers
- ✅ **Crashlytics** : Suivi des erreurs
- ✅ **Analytics** : Statistiques d'usage

### Règles de sécurité
- **Firestore** : Accès propriétaire-uniquement
- **Storage** : Dossiers par utilisateur
- **Validation** : Côté client et serveur

## 📱 Captures d'écran

*Captures d'écran à ajouter*

## 🧪 Tests

### Test d'authentification
1. Créer un compte test
2. Se connecter/déconnecter
3. Vérifier la persistance de session

### Test des règles de sécurité
1. Vérifier l'isolation des données utilisateurs
2. Tester la création/modification de documents
3. Valider le mode offline

## 🚀 Déploiement

### TestFlight
```bash
# Archive pour TestFlight
xcodebuild -project jjb.xcodeproj -scheme jjb -configuration Release archive -archivePath jjb.xcarchive
```

### App Store
- Configurer les certificats de distribution
- Créer un build de production
- Soumettre via App Store Connect

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 👥 Équipe

- **Jean-Michel Nogaro** - Développeur principal
- **Gracie Barra** - Club de Jiu-Jitsu Brésilien

## 📞 Support

- **Issues** : [GitHub Issues](https://github.com/nonodu13009/jjb/issues)
- **Documentation** : [Wiki](https://github.com/nonodu13009/jjb/wiki)
- **Email** : [Votre email]

---

**OSS! JIU-JITSU FOR EVERYONE** 🥋

*Développé avec ❤️ pour la communauté Gracie Barra*
