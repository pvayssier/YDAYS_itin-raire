//
//  AuthButton.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI

public struct AuthButton: View {
    var title: String
    var action: () -> Void

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 233, maxHeight: 47)
                .background(Color("DarkBlue", bundle: .main))
                .cornerRadius(30)
        }
    }
}

#Preview {
    AuthButton(title: "Se connecter") {
        print("Bouton cliqué !")
    }
}
