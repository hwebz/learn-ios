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
                // This one created, no need .onChange() anymore
//                .task(id: articleNewsVM.selectedCategory, loadTask)
            // Whenever fetchTaskToken.token (new timestamp) update, task gonna run and re-fetch articles
                .task(id: articleNewsVM.fetchTaskToken, loadTask)
//                .refreshable {
//                    // Pull to refresh
////                    loadTask()
//                }
                .refreshable(action: loadTask)
                .onAppear {
//                    loadTask()
                }
                // load articles again when category changed
//                .onChange(of: articleNewsVM.selectedCategory) {_ in
//                    loadTask()
//                }
//                .navigationTitle(articleNewsVM.selectedCategory.text)
                .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
                .navigationBarItems(trailing: menu)
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
//                RetryView(text: error.localizedDescription) {
//                    // TODO: Refresh the news API
//// For testing .failure() case
////                    Task.init(operation: {
////                        await articleNewsVM.loadArticles(correct: true)
////                    })
////                    loadTask()
//                }
                RetryView(text: error.localizedDescription, retryAction: refreshTask)
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
    
    private func refreshTask() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }
    
//    private func loadTask() {
//        Task.init(operation: {
//            await articleNewsVM.loadArticles()
//        })
//    }
    
    @Sendable private func loadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    private var menu: some View {
        Menu {
//            Picker("Category", selection: $articleNewsVM.selectedCategory) {
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData!))
    }
}
