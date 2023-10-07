//
//  NewsAPI.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import Foundation

struct NewsAPI {
    static let shared = NewsAPI()
    private init() {}
    
    /// Grab apiKey on https://newsapi.org
    private let apiKey = "7a63cad19f1e41998b14385fd64d5997"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category: Category) async throws -> [Article] {
        let url = generateNewsURL(from: category)
        return try await fetchArticles(from: url)
    }
    
    func search(for query: String) async throws -> [Article] {
        let url = generateSearchURL(from: query)
        print("SEARCH URL: ", url)
        return try await fetchArticles(from: url)
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
            case (200...299), (400...499):
                let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
                if apiResponse.status == "ok" {
                    return apiResponse.articles ?? []
                } else {
                    throw generateError(description: apiResponse.message ?? "An error occurred")
                }
            default:
                throw generateError(description: "A server error occurred")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateSearchURL(from query: String) -> URL {
        let precentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/everything?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&q=\(precentEncodedString)"
        
        return URL(string: url)!
    }
    
    private func generateNewsURL(from category: Category) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        print("URL: ", url)
        
        return URL(string: url)!
    }
}
