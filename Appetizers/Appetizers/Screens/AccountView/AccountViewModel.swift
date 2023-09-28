//
//  AccountViewModel.swift
//  Appetizers
//
//  Created by Personal on 29/09/2023.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
   @Published var firstName: String = ""
   @Published var lastName: String = ""
   @Published var email: String = ""
   @Published var birthDate = Date()
   @Published var extraNapkins: Bool = true
   @Published var frequentRefill: Bool = false
    
    @Published var alertItem: AlertItem?
    
    var isValidForm: Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        guard email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        return true
    }
    
    func saveChanges() {
        guard isValidForm else { return }
        print("Changes have been saved successfully")
    }
}
