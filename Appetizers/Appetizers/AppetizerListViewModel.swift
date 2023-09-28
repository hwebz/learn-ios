//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Personal on 28/09/2023.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    @Published var alertItem: AlertItem?
    
    // Enable App Transport Security Settings / Allow Arbitrary Loads = true to call API from unknown domain
    func getAppetizers() {
        NetworkManager.shared.getAppetizers { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let appetizers):
                    self.appetizers = appetizers
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    }
                }
            }
        }
    }
}
