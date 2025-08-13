# 🔥 Configuration Firebase - Gracie Barra

## 📱 Configuration iOS

### 1. GoogleService-Info.plist
✅ **Déjà configuré** dans votre projet

### 2. Packages Firebase installés
✅ **FirebaseCore** - Service de base
✅ **FirebaseAuth** - Authentification
✅ **FirebaseFirestore** - Base de données
✅ **FirebaseStorage** - Stockage fichiers
✅ **FirebaseCrashlytics** - Suivi erreurs
✅ **FirebaseInstallations** - Gestion installations
✅ **FirebaseAnalyticsCore** - Analytics de base

## 🌐 Configuration Firebase Console

### 1. Activer l'Authentification
- Aller dans **Authentication** > **Sign-in method**
- Activer **Email/Password**
- Configurer les paramètres de sécurité :
  - **Password strength** : Medium (minimum 6 caractères)
  - **Email verification** : Optionnel pour commencer

### 2. Configurer Firestore Database
- Aller dans **Firestore Database**
- Créer une base de données en **mode production**
- Choisir la **région** la plus proche (ex: europe-west1)
- **Règles de sécurité** : Utiliser le fichier `firestore.rules`

### 3. Configurer Storage
- Aller dans **Storage**
- Créer un bucket de stockage
- **Règles de sécurité** : Utiliser le fichier `storage.rules`

### 4. Configurer Crashlytics
- Aller dans **Crashlytics**
- Activer la collecte automatique des crashs
- Configurer les alertes par email

## 🔒 Règles de sécurité

### Firestore Rules (`firestore.rules`)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Règles pour la collection users
    match /users/{userId} {
      // Seul l'utilisateur propriétaire peut lire et modifier ses données
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      // Validation des données
      allow create: if request.auth != null 
        && request.auth.uid == userId
        && request.resource.data.email is string
        && request.resource.data.displayName is string
        && request.resource.data.createdAt is timestamp
        && request.resource.data.updatedAt is timestamp;
        
      allow update: if request.auth != null 
        && request.auth.uid == userId
        && request.resource.data.email is string
        && request.resource.data.displayName is string
        && request.resource.data.updatedAt is timestamp;
    }
    
    // Règles pour d'autres collections (à étendre selon vos besoins)
    match /{document=**} {
      // Par défaut, refuser l'accès
      allow read, write: if false;
    }
  }
}
```

### Storage Rules (`storage.rules`)
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Dossiers par utilisateur
    match /avatars/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /documents/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Par défaut, refuser l'accès
    match /{allPaths=**} {
      allow read, write: if false;
    }
  }
}
```

## 📊 Index Firestore

### Index nécessaires
```javascript
// Collection: users
// Champs: email (Ascending)
// Champs: displayName (Ascending)
// Champs: createdAt (Descending)
```

## 🚀 Déploiement

### 1. Déployer les règles Firestore
```bash
firebase deploy --only firestore:rules
```

### 2. Déployer les règles Storage
```bash
firebase deploy --only storage
```

### 3. Vérifier la configuration
- Tester l'authentification
- Vérifier la création de documents
- Tester les règles de sécurité

## 🔧 Variables d'environnement

### iOS Info.plist
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>firebase</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

## 📱 Test de la configuration

### 1. Test d'authentification
- Créer un compte test
- Se connecter/déconnecter
- Vérifier la persistance

### 2. Test des règles
- Vérifier qu'un utilisateur ne peut pas accéder aux données d'un autre
- Tester la création/modification de documents

### 3. Test du mode offline
- Vérifier que Firestore fonctionne hors ligne
- Tester la synchronisation au retour en ligne

## 🚨 Problèmes courants

### 1. Erreur "Missing or insufficient permissions"
- Vérifier les règles Firestore
- S'assurer que l'utilisateur est authentifié

### 2. Erreur "Network error"
- Vérifier la connectivité internet
- Vérifier la configuration des règles

### 3. Erreur "Invalid document path"
- Vérifier la structure des collections
- S'assurer que les chemins sont corrects

---

**Configuration terminée ! Votre app Gracie Barra est prête à utiliser Firebase ! 🥋**
