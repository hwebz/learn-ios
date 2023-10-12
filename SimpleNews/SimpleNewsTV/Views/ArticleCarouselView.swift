//
//  ArticleCarouselView.swift
//  SimpleNewsTV
//
//  Created by Personal on 12/10/2023.
//

import SwiftUI

struct ArticleCarouselView: View {
    
    @EnvironmentObject private var bookmarkVM: ArticleBookmarkViewModel
    let title: String
    let articles: [Article]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding(.horizontal, 64)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 32) {
                    ForEach(articles) { article in
                        NavigationLink {
                            Text(article.title)
                        } label: {
                            ArticleItemView(article: article)
                                .frame(width: 420, height: 420)
                        }
                        .buttonStyle(.card)

                    }
                }
                .padding([.bottom, .horizontal], 64)
                .padding(.top, 32)
            }
        }
    }
}

struct ArticleCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleCarouselView(title: "Test", articles: Article.previewData)
                .environmentObject(ArticleBookmarkViewModel.shared)
        }
    }
}
