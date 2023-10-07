//
//  SimpleNewsApp.swift
//  SimpleNews
//
//  Created by Personal on 07/10/2023.
//

import SwiftUI

@main
struct SimpleNewsApp: App {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
