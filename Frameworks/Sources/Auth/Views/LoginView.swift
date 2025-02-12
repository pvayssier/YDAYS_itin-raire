//
//  LoginView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import Map

public struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var navigationPath: [String] = []
    
    public init() {}

    public var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color(UIColor(red: 1.0, green: 0.97, blue: 0.94, alpha: 1.0))
                    .edgesIgnoringSafeArea(.all)
                    .overlay(
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 400, height: 300)
                            .offset(x: -100, y: -400)
                    )
                
                VStack {
                    Spacer()
                    
                    CustomTextField(text: $viewModel.email, label: "Email").padding(.bottom, 24)
                    CustomTextField(text: $viewModel.password, label : "Mot de passe", isSecureField: true)
                    
                    Spacer()
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage).foregroundColor(.red)
                    }
                    
                    
                    AuthButton(title: "Se connecter") {
                        viewModel.login()
                        if viewModel.isAuthenticated {
                            navigationPath.append("Home")
                        }
                    }
                    
                    
                    
                   
                }
                .padding(.horizontal, 45)
                .navigationBarHidden(true)
                .navigationDestination(for: String.self) { value in
                    if value == "Home" {
                        MapView()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
