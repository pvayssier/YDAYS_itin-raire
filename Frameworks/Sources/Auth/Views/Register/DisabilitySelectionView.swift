//
//  DisabilitySelectionView.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import SwiftUI

public struct DisabilitySelectionView: View {
    @ObservedObject var viewModel: RegisterViewModel

    public var body: some View {
        VStack {
            Spacer()
            
            Text("HANDICAP")
                .font(.system(size: 32))
                .foregroundColor(Color("DarkBlue", bundle: .main))
                .padding(.bottom, 54)
            
            HStack{
                ForEach(RegisterViewModel.Disability.allCases, id: \.self) { disability in
                    Button(action: {
                        viewModel.disability = disability
                    }) {
                        DisabilityIcon(title: disability.rawValue, icon: getIcon(for: disability))
                    }
                    .border(viewModel.disability == disability ? Color("DarkBlue", bundle: .main) : Color.clear, width: 2)
                    .cornerRadius(15)
                }
            }
            
            Spacer()

            AuthButton(title: "Suivant") {
                viewModel.nextStep()
            }
            
        }.padding(.horizontal, 24)
    }
    
    private func getIcon(for disability: RegisterViewModel.Disability) -> String {
            switch disability {
            case .motor:
                return "car.fill"
            case .visual:
                return "eye.fill"
            case .hearing:
                return "ear.fill"
            }
        }
}

#Preview {
    DisabilitySelectionView(viewModel: RegisterViewModel())
}

