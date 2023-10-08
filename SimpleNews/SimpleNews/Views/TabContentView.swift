//
//  TabContentView.swift
//  SimpleNews
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct TabContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                NewsTabView()
            }
            .tabItem {
                Label("News", systemImage: "newspaper")
            }
            
            NavigationView {
                SearchTabView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            NavigationView {
                BoookMarkTabView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark")
            }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
