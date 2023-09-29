//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by Personal on 24/09/2023.
//

import SwiftUI

/// Cmd + Shift + A: Toggle light/dark mode on simulator
/// Cmd + K: Toggle keyboard on simulator
/// Control + I: Format selection code

@main
struct AppetizersApp: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)
        }
    }
}
