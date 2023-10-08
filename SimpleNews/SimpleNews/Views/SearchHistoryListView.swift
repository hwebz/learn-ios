//
//  SearchHistoryListView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct SearchHistoryListView: View {
    
    @ObservedObject var searchVM: ArticleSearchViewModel
    let onSubmit: (String) -> ()
    
    var body: some View {
        VStack {
            HStack {
                Text("Recently Searched")
                    .font(.system(size: 25, weight: .semibold))
                Spacer()
                Button("Clear") {
                    searchVM.removeAllHistory()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.accentColor)
            }
            .padding()
            
            List {
                ForEach(searchVM.history, id: \.self) { history in
                    Button(history) {
                        onSubmit(history)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            searchVM.removeHistory(history)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct SearchHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryListView(searchVM: ArticleSearchViewModel.shared) { _ in
            
        }
    }
}
