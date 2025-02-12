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
        .padding()
        .frame(maxWidth: 130)
    }
}

#Preview {
    DisabilityIcon(title: "Handicap Moteur", icon: "car.fill")
}
