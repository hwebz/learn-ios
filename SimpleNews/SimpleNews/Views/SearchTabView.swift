//
//  SearchTabView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct SearchTabView: View {
    @StateObject var searchVM = ArticleSearchViewModel.shared
    var shouldShowSuggestions: Bool {
        searchVM.searchQuery.isEmpty
    }
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(OverlayView)
                .navigationTitle("Search")
        }
        .searchable(text: $searchVM.searchQuery) { suggestionsView }
        .onChange(of: searchVM.searchQuery) { newSearchQuery in
            if newSearchQuery.isEmpty {
                searchVM.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
        
    }
    
    private var articles: [Article] {
        if case let .success(articles) = searchVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var OverlayView: some View {
        switch searchVM.phase {
            case .empty:
                if !searchVM.searchQuery.isEmpty {
                    ProgressView()
                } else if !searchVM.history.isEmpty {
                    SearchHistoryListView(searchVM: searchVM) { historySearchQuery in
                        searchVM.searchQuery = historySearchQuery
                        search()
                    }
                } else {
                    EmptyPlaceholderView(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
                }
            case .success(let articles) where articles.isEmpty:
                EmptyPlaceholderView(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            case .failure(let error):
                RetryView(text: error.localizedDescription) {
                    
                }
            default:
                EmptyView()
        }
    }
    
    @ViewBuilder
    private var suggestionsView: some View {
        if shouldShowSuggestions {
            ForEach(["Swift", "Covid-19", "BTC", "PS5", "iOS 15"], id: \.self) { text in
                Button {
                    searchVM.searchQuery = text
                } label: {
                    Text(text)
                }
            }
        }
    }
    
    private func search() {
        Task.init(operation: {
            await searchVM.searchArticle()
        })
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(bookmarkVM)
    }
}
