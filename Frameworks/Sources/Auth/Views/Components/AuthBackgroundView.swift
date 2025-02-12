//
//  AuthBackgroundView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//


import SwiftUI

public struct AuthBackgroundView: View {
    public init() {}

    public var body: some View {
        Color(UIColor(red: 1.0, green: 0.97, blue: 0.94, alpha: 1.0))
            .edgesIgnoringSafeArea(.all)
            .overlay(
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: 400, height: 300)
                    .offset(x: -100, y: -400)
            )
    }
}

// MARK: - Preview
#Preview {
    AuthBackgroundView()
}
