//
//  LoginViewModel.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import Foundation
import Tools

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    func login() {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Veuillez remplir tous les champs."
            return
        }
        
        if !AuthValidator.isValidEmail(email) {
            errorMessage = "Le format de l'email est invalide."
            return
        }
        
        isAuthenticated = true
    }
}
