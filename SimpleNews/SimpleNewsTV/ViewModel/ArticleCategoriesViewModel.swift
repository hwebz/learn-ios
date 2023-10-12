//
//  ArticleCategoriesViewModel.swift
//  SimpleNewsTV
//
//  Created by Personal on 12/10/2023.
//

import Foundation

@MainActor
class ArticleCategoriesViewModel: ObservableObject {
    @Published var phase = DataFetchPhase<[CategoryArticles]>.empty
    
    private let newsAPI = NewsAPI.shared
    
    var categoryArticles: [CategoryArticles] {
        phase.value ?? []
    }
    
    func loadCategoryArticles() async {
        // For development
        // phase = .success(Article.previewCategoryArticles)
        if Task.isCancelled { return }
        phase = .empty
        
        do {
            let categoryArticles = try await newsAPI.fetchAllCategoryArticles()
            if Task.isCancelled { return }
            phase = .success(categoryArticles)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
