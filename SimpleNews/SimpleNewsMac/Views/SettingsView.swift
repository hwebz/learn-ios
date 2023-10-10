//
//  SettingsView.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralSettings()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
        }
        .frame(width: 400, height: 100, alignment: .center)
    }
    
    private struct GeneralSettings: View {
        @EnvironmentObject var searchVM: ArticleSearchViewModel
        @EnvironmentObject var bookmarkVM: ArticleBookmarkViewModel
        
        var body: some View {
            Form {
                VStack {
                    HStack {
                        Text("Search history data")
                            .frame(width: 150, alignment: .trailing)
                        
                        Button("Clear All") {
                            searchVM.removeAllHistory()
                        }
                    }
                    
                    HStack {
                        Text("Saved bookmarks data")
                            .frame(width: 150, alignment: .trailing)
                        
                        Button("Clear All") {
                            bookmarkVM.removeAllHistory()
                        }
                    }
                }
            }
            .fixedSize()
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
