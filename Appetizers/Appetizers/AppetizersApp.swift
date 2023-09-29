//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by Personal on 24/09/2023.
//

import SwiftUI

@main
struct AppetizersApp: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)
        }
    }
}
