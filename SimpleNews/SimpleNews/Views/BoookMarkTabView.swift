//
//  BoookMarkTabView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct BoookMarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        let articles = self.articles
        
        ArticleListView(articles: articles)
        .overlay(OverlayView(isEmpty: articles.isEmpty))
        .navigationTitle("Saved Articles")
        .searchable(text: $searchText)
    }
    
    
    private var articles: [Article] {
        if (searchText.isEmpty) {
            return articleBookmarkVM.bookmarks
        }
        return articleBookmarkVM.bookmarks.filter {
            $0.title.lowercased().contains(searchText.lowercased()) ||
            $0.descriptionText.lowercased().contains(searchText.lowercased())
        }
    }
    
    @ViewBuilder
    private func OverlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
}

struct BoookMarkTabView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    static var previews: some View {
        BoookMarkTabView()
            .environmentObject(articleBookmarkVM)
    }
}
