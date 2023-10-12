//
//  Category+Intent.swift
//  SimpleNews
//
//  Created by Personal on 12/10/2023.
//

import Foundation

extension Category {
    init(_ categoryIntentParam: CategoryIntentParam) {
        switch categoryIntentParam {
            case .general: self = .general
            case .business: self = .business
            case .entertainment: self = .entertainment
            case .technology: self = .technology
            case .sport: self = .sport
            case .science: self = .science
            case .health: self = .health
            case .unknown: self = .general
        }
    }
}
