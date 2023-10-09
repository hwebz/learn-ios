//
//  NewsAPIResponse.swift
//  SimpleNews
//
//  Created by Personal on 07/10/2023.
//

import Foundation

struct NewsAPIResponse: Decodable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    let message: String?
}
