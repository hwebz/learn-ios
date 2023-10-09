//
//  Alert.swift
//  GoogleAuth
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let loginError = AlertItem(
        title: Text("Login Error"),
        message: Text("Invalid data. Please try again"),
        dismissButton: .default(Text("OK"))
    )
    static let signupError = AlertItem(
        title: Text("Signup Error"),
        message: Text("Invalid daa. Please try again"),
        dismissButton: .default(Text("OK"))
    )
    
    static func generateAlert(title: String, message: String, action: (() -> Void)? = {}) -> AlertItem {
        return AlertItem(
            title: Text(title),
            message: Text(message),
            dismissButton: .default(Text("OK"), action: action)
        )
    }
}
