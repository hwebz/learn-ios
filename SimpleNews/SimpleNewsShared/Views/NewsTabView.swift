//
//  NewsTabView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct NewsTabView: View {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    // OLD CODE for iOS only
//    var body: some View {
//        NavigationView {
//            ArticleListView(articles: articles)
//                .overlay(OverlayView)
//                // This one created, no need .onChange() anymore
////                .task(id: articleNewsVM.selectedCategory, loadTask)
//            // Whenever fetchTaskToken.token (new timestamp) update, task gonna run and re-fetch articles
//                .task(id: articleNewsVM.fetchTaskToken, loadTask)
////                .refreshable {
////                    // Pull to refresh
//////                    loadTask()
////                }
//                .refreshable(action: loadTask)
//                .onAppear {
////                    loadTask()
//                }
//                // load articles again when category changed
////                .onChange(of: articleNewsVM.selectedCategory) {_ in
////                    loadTask()
////                }
////                .navigationTitle(articleNewsVM.selectedCategory.text)
//                .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
//                .navigationBarItems(trailing: menu)
//        }
//    }
    
    init(articles: [Article]? = nil, category: Category = .general) {
        self._articleNewsVM = StateObject(wrappedValue: ArticleNewsViewModel(articles: articles, selectedCategory: category))
    }
    
    var body: some View {
        ArticleListView(articles: articleNewsVM.articles, isFetchingNextPage: articleNewsVM.isFetchingNextPage, nextPageHandler: {
            await articleNewsVM.loadNextPage()
        })
            .overlay(OverlayView)
            .navigationTitle(articleNewsVM.fetchTaskToken.category.text)
            .task(id: articleNewsVM.fetchTaskToken, loadTask)
            .refreshable(action: refreshTask)
            #if os(iOS)
            .navigationBarItems(trailing: navigationBarItem)
            #elseif os(macOS)
            .navigationSubtitle(articleNewsVM.lastRefreshedDateText)
            .focusedSceneValue(\.refreshAction, forceRefreshArticles)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: forceRefreshArticles) {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                    }
                }
            }
            #endif
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
                RetryView(text: error.localizedDescription, retryAction: forceRefreshArticles)
            default:
                EmptyView()
        }
    }
    
    // Use articleNewsVM.articles instead
//    private var articles: [Article] {
//        if case let .success(articles) = articleNewsVM.phase {
//            return articles
//        } else {
//            return []
//        }
//    }
    
    private func forceRefreshArticles() {
        articleNewsVM.fetchTaskToken = FetchTaskToken(category: articleNewsVM.fetchTaskToken.category, token: Date())
    }
    
//    private func loadTask() {
//        Task.init(operation: {
//            await articleNewsVM.loadArticles()
//        })
//    }
    
    @Sendable private func loadTask() async {
        await articleNewsVM.loadFirstPage()
    }
    
    @Sendable private func refreshTask() async {
        Task {
            await articleNewsVM.refreshTask()
        }
    }
    
    #if os(iOS)
    @ViewBuilder
    private var navigationBarItem: some View {
        switch horizontalSizeClass {
            case .regular:
                Button(action: forceRefreshArticles) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
            default:
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
    #endif
}

struct NewsTabView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        NewsTabView(articles: Article.previewData)
            .environmentObject(articleBookmarkVM)
    }
}
