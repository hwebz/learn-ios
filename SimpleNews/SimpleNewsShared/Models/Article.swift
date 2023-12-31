//
//  Article.swift
//  SimpleNews
//
//  Created by Personal on 07/10/2023.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

let activityTypeViewKey = "com.hado.SimpleNews.view"
let activityURLKey = "SimpleNews.url.key"

struct Article: Hashable {
    // This id will be unique and auto generated from client side to avoid clashing of Identifiable in a List
    // as NewsAPI response doesn't provide unique identifier
    let id = UUID()
    let source: Source
    
    let title: String
    let url: String
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    let content: String?
    
    var authorTeext: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) . \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var contentText: String {
        content ?? ""
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {}

extension Article {
    static var previewData: [Article] {
        // Must include news.json in Project Settings -> Build Phases -> Copy Bundle Resources -> Add your json file
        if let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json") {
            let data = try! Data(contentsOf: previewDataURL)
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .iso8601
            
            let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
            return apiResponse.articles ?? []
        }
        return []
    }
    
    static var previewCategoryArticles: [CategoryArticles] {
        let articles = previewData
        return Category.allCases.map {
            .init(category: $0, articles: articles.shuffled())
        }
    }
}

struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}
