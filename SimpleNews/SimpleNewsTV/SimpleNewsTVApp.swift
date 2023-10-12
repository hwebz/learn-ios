//
//  SimpleNewsTVApp.swift
//  SimpleNewsTV
//
//  Created by Personal on 12/10/2023.
//

import SwiftUI

@main
struct SimpleNewsTVApp: App {
    
    @StateObject private var bookmarkVM: ArticleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(bookmarkVM)
            }
        }
    }
}
