//
//  AuthSelectionView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI


public struct AuthSelectionView: View {
    @StateObject private var viewModel = AuthSelectionViewModel()
    
    public init() {}

       public var body: some View {
           NavigationStack {
               ZStack {
                   AuthBackgroundView()
                   
                   VStack(spacing: 40) {
                       AuthButton(title: "Se connecter") {
                           viewModel.handleAuthDestination(destination: .login)
                       }
                       
                       Divider()
                           .frame(maxWidth: 100, maxHeight: 2)
                           .background(Color("DarkBlue", bundle: .main))
                           .padding(.horizontal, 40)
                       
                       AuthButton(title: "S'inscrire") {
                           viewModel.handleAuthDestination(destination: .register)
                       }
                       
                   }
                   .padding(.horizontal, 45)
               }
          
               .navigationDestination(isPresented: $viewModel.navigateToLogin) {
                   LoginView()
               }
               .navigationDestination(isPresented: $viewModel.navigateToRegister) {
                   RegisterView()
               }
               .navigationBarHidden(true)
               .navigationBarBackButtonHidden(true)
           }
       }
}

#Preview {
    AuthSelectionView()
}
