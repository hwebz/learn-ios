//
//  ContentView.swift
//  AppStore
//
//  Created by Personal on 04/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            List {
                Label("Discover", systemImage: "star")
                    .onTapGesture {
                        print("Discover")
                    }
                Label("Arcade", systemImage: "gamecontroller")
                Label("Create", systemImage: "paintbrush")
                Label("Categories", systemImage: "square.grid.3x3.square")
                Label("Favorites", systemImage: "heart")
                Label("Updates", systemImage: "square.and.arrow.down")
            }.searchable(text: $searchText)
            .onSubmit(of: .search) {
                print(searchText)
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
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
