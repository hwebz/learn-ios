//
//  Category.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sport
    case science
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
    
    var systemImage: String {
        switch self {
            case .general:
                return "newspaper"
            case .business:
                return "building.2"
            case .technology:
                return "desktopcomputer"
            case .entertainment:
                return "tv"
            case .sport:
                return "sportscourt"
            case .science:
                return "wave.3.right"
            case .health:
                return "cross"
                
        }
    }
    
    var sortIndex: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
