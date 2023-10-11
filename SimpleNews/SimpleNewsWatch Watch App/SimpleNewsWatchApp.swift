//
//  SimpleNewsWatchApp.swift
//  SimpleNewsWatch Watch App
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI
import WatchKit

@main
struct SimpleNewsWatch_Watch_AppApp: App {
    
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) private var extensionDelegate
    @StateObject private var bookmarkVM: ArticleBookmarkViewModel = ArticleBookmarkViewModel.shared
    @StateObject private var searchVM: ArticleSearchViewModel = ArticleSearchViewModel.shared
    @StateObject private var connectivityVM = WatchConnectivityViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(bookmarkVM)
            .environmentObject(searchVM)
            .environmentObject(connectivityVM)
        }
    }
}
