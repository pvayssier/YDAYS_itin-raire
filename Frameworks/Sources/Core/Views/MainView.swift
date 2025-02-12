//
//  SwiftUIView.swift
//  Frameworks
//
//  Created by Paul Vayssier on 27/11/2024.
//

import SwiftUI
import Auth

public struct MainView: View {
    public init() {}

    public var body: some View {
        AuthSelectionView()
    }
}

#Preview {
    AuthSelectionView()
}
