//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Personal on 28/09/2023.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    @Published var appetizers: [Appetizer] = []
    
    // Enable App Transport Security Settings / Allow Arbitrary Loads = true to call API from unknown domain
    func getAppetizers() {
        NetworkManager.shared.getAppetizers { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let appetizers):
                    self.appetizers = appetizers
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
