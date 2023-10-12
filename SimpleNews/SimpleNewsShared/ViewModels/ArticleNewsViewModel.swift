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
    private let cache = InMemoryCache<[Article]>(expirationInterval: 2 * 60)
    
    private let newsAPI = NewsAPI.shared
    
    var lastRefreshedDateText: String {
        dateFormatter.timeStyle = .short
        return "Last refreshed at: \(dateFormatter.string(from: fetchTaskToken.token))"
    }
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        
//        self.selectedCategory = selectedCategory
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
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
    
    func loadArticles() async {
        // JSON data
//        phase = .success(Article.previewData)
        if Task.isCancelled { return }
        
        let category = fetchTaskToken.category
        if let articles = await cache.value(forKey: category.rawValue) {
            phase = .success(articles)
            print("CACHE: Loaded articles for category: \(category.rawValue)")
            return
        }
        
        print("CACHE: Missed or expired")
        phase = .empty
        do {
//            let articles = try await newsAPI.fetch(from: selectedCategory)
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled { return }
            await cache.setValue(articles, for: category.rawValue)
            print("CACHE: Set articles for category: \(category.rawValue)")
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error)
            phase = .failure(error)
        }
    }
}
