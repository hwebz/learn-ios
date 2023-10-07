//
//  ContentView.swift
//  ParallaxCarousel
//
//  Created by Personal on 07/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Explore")
                .tabItem {
                    Image(systemName: "safari")
                }
            
            Text("Heart")
                .tabItem {
                    Image(systemName: "heart")
                }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
