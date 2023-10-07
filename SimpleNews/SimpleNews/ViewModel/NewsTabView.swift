//
//  NewsTabView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(OverlayView)
                .onAppear {
                    Task.init(operation: {
                        await articleNewsVM.loadArticles()
                    })
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
        }
    }
    
    @ViewBuilder
    private var OverlayView: some View {
        switch articleNewsVM.phase {
            case .empty:
                ProgressView()
            case .success(let articles) where articles.isEmpty:
                EmptyPlaceholderView(text: "No Articles", image: nil)
            case .failure(let error):
                RetryView(text: error.localizedDescription) {
                    // TODO: Refresh the news API
// For testing .failure() case
//                    Task.init(operation: {
//                        await articleNewsVM.loadArticles(correct: true)
//                    })
                    Task.init(operation: {
                        await articleNewsVM.loadArticles()
                    })
                }
            default:
                EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
            return []
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData!))
    }
}
