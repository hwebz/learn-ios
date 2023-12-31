//
//  ArticleBookmarkViewModel.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "bookmarks")
    
    static let shared = ArticleBookmarkViewModel()
    private init() {
        Task.init(operation: load)
    }
    
    @Sendable private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    func removeAllBookmarks() {
        bookmarks.removeAll()
        bookmarkUpdated()
    }
    
    func toggleBookmark(for article: Article) {
        if isBookmarked(for: article) {
            removeBookmark(for: article)
        } else {
            addBookmark(for: article)
        }
    }
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task.init(operation: {
            await bookmarkStore.save(bookmarks)
        })
    }
}
