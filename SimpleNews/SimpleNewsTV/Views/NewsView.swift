//
//  NewsView.swift
//  SimpleNewsTV
//
//  Created by Personal on 12/10/2023.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject private var articleCategoriesVM = ArticleCategoriesViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 48) {
                ForEach(articleCategoriesVM.categoryArticles, id: \.category) {
                    ArticleCarouselView(title: $0.category.text, articles: $0.articles)
                }
            }
        }
        .task(refreshTask)
    }
    
    @ViewBuilder
    private var OverlayView: some View {
        switch articleCategoriesVM.phase {
            case .empty:
                ProgressView()
            case .success(let articles) where articles.isEmpty:
                EmptyPlaceholderView(text: "No Articles", image: nil)
            case .failure(let error):
                RetryView(text: error.localizedDescription, retryAction: refreshTask)
            default: EmptyView()
        }
    }

    @Sendable private func refreshTask() {
        Task {
            await articleCategoriesVM.loadCategoryArticles()
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
