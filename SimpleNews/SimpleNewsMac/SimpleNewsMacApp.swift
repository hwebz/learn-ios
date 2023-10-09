//
//  SimpleNewsMacApp.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

@main
struct SimpleNewsMacApp: App {
    
    @StateObject private var bookmarkVM: ArticleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
        }
        .commands {
            SidebarCommands()
            NewsCommands()
        }
    }
}
