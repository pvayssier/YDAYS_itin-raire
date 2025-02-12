import Foundation

class AuthSelectionViewModel: ObservableObject {
    @Published var navigateToLogin = false
    @Published var navigateToRegister = false
    
    enum AuthDestination {
        case login
        case register
    }
    
    func handleAuthDestination(destination: AuthDestination) {
        switch destination {
        case .login:
            navigateToLogin = true
        case .register:
            navigateToRegister = true
        }
    }
}

