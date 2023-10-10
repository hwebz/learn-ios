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
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button {
                            toggleSidebar()
                        } label: {
                            Image(systemName: "sidebar.left")
                        }
                    }
                }
        }
        .frame(minWidth: 1000, minHeight: 386)
        .focusable()
        .touchBar {
            ScrollView(.horizontal) {
                HStack {
                    ForEach([MenuItem.saved] + Category.menuItems) { item in
                        Button {
                            selection.wrappedValue = item.id
                        } label: {
                            Label(item.text, systemImage: item.systemImage)
                        }
                    }
                }
            }
            .frame(width: 684)
            .touchBarItemPresence(.required("menus"))
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?
            .tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
