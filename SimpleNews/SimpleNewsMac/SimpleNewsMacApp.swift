//
//  SimpleNewsMacApp.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI
import WidgetKit

class AppDeletegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func application(_ application: NSApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        
        
        if let urlString = userActivity.userInfo?[activityURLKey] as? String,
           let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
        return true
    }
    
    // Open link from Widget on web browser
    func application(_ application: NSApplication, open urls: [URL]) {
        if let url = urls.first {
            NSWorkspace.shared.open(url)
        }
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
        .handlesExternalEvents(matching: [])
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.newItem) {}
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
