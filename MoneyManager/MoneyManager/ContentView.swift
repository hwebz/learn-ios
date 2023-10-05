//
//  ContentView.swift
//  MoneyManager
//
//  Created by Personal on 05/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            Group {
                CardsScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                VStack {
                    Text("Statistic")
                }
                .tabItem {
                    Label("Statistic", systemImage: "table")
                }
                VStack {
                    Text("Wallet")
                }
                .tabItem {
                    Label("Wallet", systemImage: "dollarsign.square")
                }
                VStack {
                    Text("Profile")
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            }
            .toolbarBackground(.black, for: .tabBar)
        }
//        TabView(selection: $tabSelection) {
//            CardsScreen().tag(1)
//            VStack {
//                Text("Statistic")
//            }.tag(2)
//            VStack {
//                Text("Wallet")
//            }.tag(3)
//            VStack {
//                Text("Profile")
//            }.tag(4)
//        }
//        .overlay(alignment: .bottom) {
//            CustomTabView(tabSelection: $tabSelection)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
