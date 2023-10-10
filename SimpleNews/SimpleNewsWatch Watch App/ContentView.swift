//
//  ContentView.swift
//  SimpleNewsWatch Watch App
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("item_selection") private var selectedMenuItemId: MenuItem.ID?
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
        NavigationStack {
            List {
                Section {
                    navigationLinkForMenuItem(.saved) {
                        Label(MenuItem.saved.text, systemImage: MenuItem.saved.systemImage)
                    }
                }
                
                Section {
                    ForEach(Category.menuItems) { item in
                        navigationLinkForMenuItem(item) {
                            listRowForCategoryMenuItem(item)
                        }
                    }
                } header: {
                    Text("Categories")
                }
            }
            .navigationDestination(for: MenuItem.self) { item in
                viewForMenuItem(item)
            }
            .searchable(text: .constant(""))
            .navigationTitle("XCA News")
        }
    }
    
    @ViewBuilder
    private func viewForMenuItem(_ item: MenuItem) -> some View {
        switch item {
            case .saved:
                Text("Saved")
            case .search:
                Text("Search")
            case .category(let category):
                Text("Category: \(category.rawValue)")
        }
    }
    
    private func navigationLinkForMenuItem<Label: View>(_ item: MenuItem, @ViewBuilder label: () -> Label) -> some View {
        NavigationLink(
            value: item,
            label: label
        )
        .listItemTint(item.listItemTintColor)
    }
    
    private func listRowForCategoryMenuItem(_ item: MenuItem) -> some View {
        VStack(alignment: .leading) {
            Image(systemName: item.systemImage)
                .imageScale(.large)
            Text(item.text)
        }
        .padding(.vertical, 10)
    }
}

fileprivate extension MenuItem {
    var listItemTintColor: Color? {
        switch self {
            case .category(let category):
                switch category {
                    case .general:
                        return .orange
                    case .business:
                        return .cyan
                    case .technology:
                        return .blue
                    case .entertainment:
                        return .indigo
                    case .sport:
                        return .purple
                    case .science:
                        return .brown
                    case .health:
                        return .red
                }
            default: return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
