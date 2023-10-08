//
//  ContentView.swift
//  SimpleNews
//
//  Created by Personal on 07/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        
        switch horizontalSizeClass {
            case .regular:
                SidebarContentView()
            default:
                TabContentView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
