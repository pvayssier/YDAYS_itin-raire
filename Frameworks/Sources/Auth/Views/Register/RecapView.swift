//
//  RecapView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI

public struct RecapView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
        VStack {
            
            Spacer()
            
            Text("RÉCAPITULATIF")
                .font(.system(size: 32))
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .padding(.bottom, 54)
            
            CustomTextDisplay(label: "Handicap", text: viewModel.disability.rawValue)
            CustomTextDisplay(label: "Nom", text: viewModel.lastName)
            CustomTextDisplay(label: "Prénom", text: viewModel.firstName)
            CustomTextDisplay(label: "Email", text: viewModel.email)
            
            
            Spacer()
            
            AuthButton(title: "Suivant") {
                viewModel.register()
                
            }
        }.padding(.horizontal, 24)
    }
}

#Preview {
    RecapView(viewModel: RegisterViewModel())
}








