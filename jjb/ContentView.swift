//
//  ContentView.swift
//  jjb
//
//  Created by Jean-Michel Nogaro on 13/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(authViewModel)
            } else {
                AuthView()
                    .environmentObject(authViewModel)
            }
        }
        .onAppear {
            // L'état d'authentification est automatiquement géré par AuthViewModel
        }
    }
}

#Preview {
    ContentView()
}
