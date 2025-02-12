//
//  RegisterViewModel.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import Foundation
import Tools

class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var confirmPassword = ""
    @Published var password = ""
    @Published var isRegistered = false
    @Published var isCredentialsValid = false
    @Published var errorMessage: String?
    @Published var currentStep: RegisterStep = .selectDisability
    @Published var disability: Disability = Disability.motor
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    func validateCredentials() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Veuillez remplir tous les champs."
            return
        }
        
        if !AuthValidator.isValidEmail(email) {
            errorMessage = "Le format de l'email est invalide."
            return
        }
        
        if !AuthValidator.isValidPassword(password) {
            errorMessage = "Le mot de passe doit contenir au moins 8 caractères, une majuscule et un chiffre."
            return
        }
        
        if (password != confirmPassword){
            errorMessage = "Les mots de passe ne correspondent pas."
            return
        }

        
        
        isCredentialsValid = true
    }
    
    func register() {
        isRegistered = true
    }
    
    
    enum RegisterStep {
        case selectDisability
        case personalInfo
        case credentials
        case recap
    }
    
    enum Disability: String, CaseIterable {
        case motor = "Handicap Moteur"
        case visual = "Malvoyant"
        case hearing = "Malentendant"
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



