//
//  ContentView.swift
//  SwipeMenu
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color.orange
            Swipe()
        }
        .ignoresSafeArea()
        .frame(width: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
