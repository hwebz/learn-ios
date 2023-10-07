//
//  ArticleNewsViewModel.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory: Category
    
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        
        self.selectedCategory = selectedCategory
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
    func loadArticles() async {
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory)
            phase = .success(articles)
        } catch {
            print(error)
            phase = .failure(error)
        }
    }
}
