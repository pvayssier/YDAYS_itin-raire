//
//  PersonalInfoView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI

public struct PersonalInfoView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
        VStack {
            Spacer()
            
            CustomTextField(
                text : $viewModel.lastName,
                label: "Nom"
            ).padding(.bottom, 24)
            
            CustomTextField(text : $viewModel.firstName, label: "Prénom")
            
            Spacer()
            
            AuthButton(title: "Suivant") {
                viewModel.nextStep()
            }
        }
        .padding(.horizontal, 45)
    }
}

#Preview {
    PersonalInfoView(viewModel: RegisterViewModel())
}
