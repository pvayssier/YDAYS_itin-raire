//
//  GetDisabilityIcon.swift
//  Frameworks
//
//  Created by Marie Lise Renzema on 12/02/2025.
//

import Models

public func getDisabilityIcon(for disability: Disability) -> String {
        switch disability {
        case .motor:
            return "figure.roll"
        case .visual:
            return "eye.fill"
        case .hearing:
            return "ear.fill"
        }
    }
