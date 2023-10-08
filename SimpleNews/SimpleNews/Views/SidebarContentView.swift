//
//  SidebarContentView.swift
//  SimpleNews
//
//  Created by Personal on 09/10/2023.
//

import SwiftUI

struct SidebarContentView: View {
    
    @State var selectedMenuItemId: MenuItem.ID? = MenuItem.category(.general).id
    
    var body: some View {
        NavigationView {
            List(selection: $selectedMenuItemId) {
                ForEach([MenuItem.saved, MenuItem.search]) {
                    navigationLinkForMenu($0)
                }
                
                Section {
                    ForEach(Category.menuItems) { category in
                        navigationLinkForMenu(category)
                    }
                    .navigationTitle("XCA News")
                } header: {
                    Text("Categories")
                }
            }
            .listStyle(.sidebar)
        }
    }
    
    private func navigationLinkForMenu(_ item: MenuItem) -> some View {
        NavigationLink(destination: viewForMenuItem(item: item), tag: item.id, selection: $selectedMenuItemId) {
            Label(item.text, systemImage: item.systemImage)
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(item: MenuItem) -> some View {
        switch item {
            case .search:
                SearchTabView()
            case .saved:
                BoookMarkTabView()
            case .category(let category):
                NewsTabView(category: category)
                // NOTE: If we change selectedMenuItemId manually, the detail view can't be rendered becasue it not detected the change
                // you need to define id for view here for it to realize what changes need to re-render List item selection
                    .id(category.id)
        }
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarContentView()
    }
}
