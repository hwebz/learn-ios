//
//  ContentView.swift
//  AppStore
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { return self }
}

struct MainView: View {
    @State private var searchText = ""
    @State private var selectedApp: String? = nil
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            List {
                Label("Discover", systemImage: "star")
                    .onTapGesture {
                        selectedApp = "Discover"
                    }
                Label("Arcade", systemImage: "gamecontroller")
                    .onTapGesture {
                        selectedApp = "Arcade"
                    }
                Label("Create", systemImage: "paintbrush")
                    .onTapGesture {
                        selectedApp = "Create"
                    }
                Label("Categories", systemImage: "square.grid.3x3.square")
                    .onTapGesture {
                        selectedApp = "Categories"
                    }
                Label("Favorites", systemImage: "heart")
                    .onTapGesture {
                        selectedApp = "Favorites"
                    }
                Label("Updates", systemImage: "square.and.arrow.down")
                    .onTapGesture {
                        selectedApp = "Updates"
                    }
            }.searchable(text: $searchText)
            .onSubmit(of: .search) {
                selectedApp = "Search Results"
            }
            
            ScrollView {
                Color.clear
                
                Image("banner")
                    .resizable()
                    .padding(.horizontal)
                    .scaledToFill()
                
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(0..<20) { index in
                        VStack(alignment: .leading) {
                            Image("thumb")
                                .resizable()
                                .scaledToFit()
                            Label("Youtube", systemImage: "")
                                .font(.system(size: 18))
                        }
                        .onTapGesture {
                            selectedApp = "Application"
                        }
                    }
                }
                .padding()
            }
        }.sheet(item: $selectedApp) { app in
            AppDetailsView(selectedApp: $selectedApp, appName: app)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
