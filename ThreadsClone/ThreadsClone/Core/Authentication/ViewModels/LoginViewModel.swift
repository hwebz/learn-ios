//
//  LoginViewModel.swift
//  ThreadsClone
//
//  Created by Personal on 29/11/2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func login() async throws {
        print("DEBUG: Signing in user here...")
        try await AuthService.shared.login(
            withEmail: email,
            password: password
        )
    }
}
