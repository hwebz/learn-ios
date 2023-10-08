//
//  ArticleSearchViewModel.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    private let newsAPI = NewsAPI.shared
    
    private let historyMaxLimit = 10
    
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) {
            history.remove(at: index)
        } else if history.count == historyMaxLimit {
            history.remove(at: 0)
        }
        
        history.insert(text, at: 0)
    }
    
    func removeHistory(_ text: String) {
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) else {
            return
        }
        
        history.remove(at: index)
    }
    
    func removeAllHistory() {
        history.removeAll()
    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if (searchQuery.isEmpty) {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            if (searchQuery != self.searchQuery) {
                return
            }
            addHistory(searchQuery)
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
    
}
