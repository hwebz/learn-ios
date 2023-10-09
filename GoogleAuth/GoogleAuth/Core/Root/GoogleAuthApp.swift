//
//  GoogleAuthApp.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI
import Firebase

@main
struct GoogleAuthApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        // Initialize firebase configuration
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
