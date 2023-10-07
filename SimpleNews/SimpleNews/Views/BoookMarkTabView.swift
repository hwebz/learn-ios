//
//  BoookMarkTabView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct BoookMarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articleBookmarkVM.bookmarks)
            .overlay(OverlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
            .navigationTitle("Saved Articles")
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
