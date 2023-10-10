//
//  SimpleNewsWatchApp.swift
//  SimpleNewsWatch Watch App
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

@main
struct SimpleNewsWatch_Watch_AppApp: App {
    
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
