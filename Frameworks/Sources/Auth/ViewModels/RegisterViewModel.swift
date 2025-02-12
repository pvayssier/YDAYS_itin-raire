//
//  RegisterViewModel.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import Foundation
import Tools
import Models

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var confirmPassword = ""
    @Published var password = ""
    @Published var isAuthenticated = false
    @Published var isCredentialsValid = false
    @Published var errorMessage: String?
    @Published var currentStep: RegisterStep = .selectDisability
    @Published var disability: Disability = .motor
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    func validateCredentials() {
        let validations: [(Bool, String)] = [
            (email.isEmpty || password.isEmpty || confirmPassword.isEmpty, "Veuillez remplir tous les champs."),
            (!AuthValidator.isValidEmail(email), "Le format de l'email est invalide."),
            (!AuthValidator.isValidPassword(password), "Le mot de passe doit contenir au moins 8 caractères, une majuscule et un chiffre."),
            (password != confirmPassword, "Les mots de passe ne correspondent pas.")
        ]

        if let error = validations.first(where: { $0.0 })?.1 {
            setErrorMessage(error)
            return
        }

        isCredentialsValid = true
    }
    
    private func setErrorMessage(_ message: String) {
        errorMessage = message
    }
    
    func register() {
        isAuthenticated = true
    }
    
    
    enum RegisterStep {
        case selectDisability
        case personalInfo
        case credentials
        case recap
    }
    
    func nextStep() {
        switch currentStep {
        case .selectDisability:
            currentStep = .personalInfo
        case .personalInfo:
            currentStep = .credentials
        case .credentials:
            currentStep = .recap
        case .recap:
            break
        }
    }
}



