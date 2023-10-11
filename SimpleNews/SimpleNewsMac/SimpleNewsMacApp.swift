//
//  SimpleNewsMacApp.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

class AppDeletegate: NSObject, NSApplicationDelegate {
    func application(_ application: NSApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        if let urlString = userActivity.userInfo?[activityURLKey] as? String,
           let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
        return true
    }
}

@main
struct SimpleNewsMacApp: App {
    
    @NSApplicationDelegateAdaptor(AppDeletegate.self) private var appDelegate
    @StateObject private var bookmarkVM: ArticleBookmarkViewModel = ArticleBookmarkViewModel.shared
    @StateObject private var searchVM: ArticleSearchViewModel = ArticleSearchViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
                .environmentObject(searchVM)
        }
        .commands {
            SidebarCommands()
            NewsCommands()
        }
        
        Settings {
            SettingsView()
                .environmentObject(bookmarkVM)
                .environmentObject(searchVM)
        }
    }
}
