//
//  RegisterView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI
import Map

public struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()

    public init() {}

    public var body: some View {
        NavigationStack {
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
                    switch viewModel.currentStep {
                    case .selectDisability:
                        DisabilitySelectionView(viewModel: viewModel)
                    case .personalInfo:
                        PersonalInfoView(viewModel: viewModel)
                    case .credentials:
                        CredentialsView(viewModel: viewModel)
                    case .recap:
                        RecapView(viewModel: viewModel)
                    }
                }
                .navigationBarHidden(true)
                .navigationDestination(isPresented: $viewModel.isRegistered) {
                    MapView()
                }
            }
        }
    }
}
#Preview {
    RegisterView()
}

