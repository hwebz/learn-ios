//
//  SearchTabView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct SearchTabView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    #if os(iOS) || os(tvOS)
    @StateObject var searchVM = ArticleSearchViewModel.shared
    #elseif os(macOS) || os(watchOS)
    @EnvironmentObject var searchVM: ArticleSearchViewModel
    #endif
    
    var shouldShowSuggestions: Bool {
        searchVM.searchQuery.isEmpty
    }
    
    var body: some View {
        ArticleListView(articles: articles)
            .overlay(OverlayView)
#if os(iOS)
            .navigationTitle("Search")
        //            .searchable(text: $searchVM.searchQuery, placement: .navigationBarDrawer) { suggestionsView }
            .searchable(text: $searchVM.searchQuery, placement: horizontalSizeClass == .regular ? .navigationBarDrawer : .automatic) { suggestionsView }
            .onChange(of: searchVM.searchQuery) { newSearchQuery in
                if newSearchQuery.isEmpty {
                    searchVM.phase = .empty
                }
            }
            .onSubmit(of: .search, search)
        
        #elseif os(tvOS)
            .searchable(text: $searchVM.searchQuery)
            .onChange(of: searchVM.searchQuery) { newSearchQuery in
                if newSearchQuery.isEmpty {
                    searchVM.phase = .empty
                }
            }
#elseif os(macOS) || os(watchOS)
            .navigationTitle(searchVM.searchQuery.isEmpty ? "Search" : "Search results for \(searchVM.searchQuery)")
#endif
        
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
#if os(iOS)
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
                
                #elseif os(tvOS)
                if !searchVM.searchQuery.isEmpty {
                    ProgressView()
                } else {
                    EmptyPlaceholderView(text: "Type your query to search from News API", image: Image(systemName: "magnifyingglass"))
                }
#elseif os(macOS) || os(watchOS)
                ProgressView()
#endif
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
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.addHistory(searchQuery)
        }
        
        Task {
            await searchVM.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(bookmarkVM)
    }
}
