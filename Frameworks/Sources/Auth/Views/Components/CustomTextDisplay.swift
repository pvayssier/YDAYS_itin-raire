//
//  CustomTextDisplay.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI

public struct CustomTextDisplay: View {
    
    var label: String
    var text: String

    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)

            ZStack(alignment: .trailing) {
                    Text(text)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
                        .textFieldStyle(.plain)
                        .frame(width: .infinity)
                }
        }.frame(width: .infinity)
    }
}

#Preview {
    CustomTextDisplay(label: "Copier le lien", text: "test@test.fr")
}




