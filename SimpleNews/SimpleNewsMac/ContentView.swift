//
//  ContentView.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @SceneStorage("item_selection") private var selectedMenuItemId: MenuItem.ID?
    private var selection: Binding<MenuItem.ID?> {
        Binding {
            selectedMenuItemId ?? MenuItem.category(.general).id
        } set: { newValue in
            if let newValue = newValue {
                selectedMenuItemId = newValue
            }
        }
    }
    
    var body: some View {
        NavigationView {
            SidebarListView(selection: selection)
        }
        .frame(minWidth: 1000, minHeight: 386)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
