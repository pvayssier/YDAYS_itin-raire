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
        VStack (alignment: HorizontalAlignment.leading, spacing: 6){
            Text(label)

            Text(text)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .foregroundColor(Color("Beige", bundle: .main))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 2)
            
        }
    }
}

#Preview {
    CustomTextDisplay(label: "Nom Prénom", text: "John Doe")
}




