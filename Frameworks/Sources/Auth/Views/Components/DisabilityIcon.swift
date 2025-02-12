//
//  DisabilityIcon.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI

public struct DisabilityIcon: View {
    var title: String
    var icon: String

    public var body: some View {
        VStack (spacing: 8){
            Image(systemName: icon)
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .font(.system(size: 38))
            
            Text(title)
                .font(.headline)
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .multilineTextAlignment(.center)
        }
        .frame(height: 150)
    }
}

#Preview {
    HStack {
           DisabilityIcon(title: "Handicap Moteur", icon: "figure.roll")
           DisabilityIcon(title: "Malvoyant", icon: "eye.fill")
           DisabilityIcon(title: "Malentendant", icon: "ear.fill")
       }
    .padding(.horizontal, 24)
}
