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
        VStack (spacing : 30){
            Spacer()
            
            Text("RÉCAPITULATIF")
                .font(.system(size: 32))
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .padding(.bottom, 54)
            
            CustomTextDisplay(label: "Nom Prénom", text: viewModel.lastName + " " + viewModel.firstName)
            CustomTextDisplay(label: "Handicap", text: viewModel.disability.rawValue)
            CustomTextDisplay(label: "Email", text: viewModel.email)
            
            Spacer()
            
            AuthButton(title: "S'inscrire") {
                viewModel.register()
            }
        }
        .padding(.horizontal, 45)
    }
}

#Preview {
    RecapView(viewModel: RegisterViewModel())
}








