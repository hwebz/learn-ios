//
//  ContentView.swift
//  SimpleNewsTV
//
//  Created by Personal on 12/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("News")
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
                .tag("news")
            
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .tag("saved")
            
            SearchTabView()
                .tabItem {
                    Image(systemName: "newspaper")
                }
                .tag("search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
