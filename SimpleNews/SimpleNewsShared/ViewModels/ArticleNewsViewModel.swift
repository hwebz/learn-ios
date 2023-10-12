//
//  ArticleNewsViewModel.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}

fileprivate let dateFormatter = DateFormatter()

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    // fetchTaskToken replaced selectedCategory
//    @Published var selectedCategory: Category
//    @Published var fetchTaskToken: FetchTaskToken
    // Set selected category from popup clicked to storage
    @Published var fetchTaskToken: FetchTaskToken {
        didSet {
            if oldValue.category != fetchTaskToken.category {
                selectedMenuItemId = MenuItem.category(fetchTaskToken.category).id
            }
        }
    }
    @AppStorage("item_selection") private var selectedMenuItemId: MenuItem.ID?
    // Cache in memory
//    private let cache = InMemoryCache<[Article]>(expirationInterval: 2 * 60)
    // Cache in disk
    private let cache = DiskCache<[Article]>(filename: "simple_news_articles", expirationInterval: 3 * 60)
    
    private let newsAPI = NewsAPI.shared
    private let pagingData = PagingData(itemsPerPage: 10, maxPageLimit: 5)
    
    var articles: [Article] {
        phase.value ?? []
    }
    
    var lastRefreshedDateText: String {
        dateFormatter.timeStyle = .short
        return "Last refreshed at: \(dateFormatter.string(from: fetchTaskToken.token))"
    }
    
    var isFetchingNextPage: Bool {
        if case .fetchingNextPage = phase {
            return true
        }
        return false
    }
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        
//        self.selectedCategory = selectedCategory
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
        
        // Only need if used disk cache
        Task(priority: .userInitiated) {
            try? await cache.loadFromDisk()
        }
    }

// For testing .failure() case
//    func loadArticles(_ correct: Bool = false) async {
//        phase = .empty
//        if correct {
//            do {
//                let articles = try await newsAPI.fetch(from: selectedCategory)
//                phase = .success(articles)
//            } catch {
//                print(error)
//                phase = .failure(error)
//            }
//        } else {
//            phase = .failure(NSError(domain: "NewsAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: "Network Failed"]))
//        }
//    }
    
    func refreshTask() async {
        await cache.removeValue(forKey: fetchTaskToken.category.rawValue)
        fetchTaskToken.token = Date()
    }
    
    func loadFirstPage() async {
        // JSON data
//        phase = .success(Article.previewData)
        if Task.isCancelled { return }
        
        // Temporarily disable cache for doing paging
//        let category = fetchTaskToken.category
//        if let articles = await cache.value(forKey: category.rawValue) {
//            phase = .success(articles)
//            print("CACHE: Loaded articles for category: \(category.rawValue)")
//            return
//        }
        
        print("CACHE: Missed or expired")
        phase = .empty
        do {
            await pagingData.reset()
//            let articles = try await newsAPI.fetch(from: selectedCategory)
            let articles = try await pagingData.loadNextPage(dataFetchProvider: loadArticles(page:))
            if Task.isCancelled { return }
//            await cache.setValue(articles, for: category.rawValue)
            
            // Only need if used Disk cache
//            try? await cache.saveToDisk()
            
//            print("CACHE: Set articles for category: \(category.rawValue)")
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error)
            phase = .failure(error)
        }
    }
    
    func loadNextPage() async {
        if Task.isCancelled { return }
        
        let articles = self.phase.value ?? []
        phase = .fetchingNextPage(articles)
        
        do {
            let nextArticles = try await pagingData.loadNextPage(dataFetchProvider: loadArticles(page:))
            if Task.isCancelled { return }
            
            phase = .success(articles + nextArticles)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadArticles(page: Int) async throws -> [Article] {
        let articles = try await newsAPI.fetch(
            from: fetchTaskToken.category,
            page: page,
            pageSize: pagingData.itemsPerPage
        )
        
        if (Task.isCancelled) { return [] }
        return articles
    }
}
