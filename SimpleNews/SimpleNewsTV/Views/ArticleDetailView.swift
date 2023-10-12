//
//  ArticleDetailView.swift
//  SimpleNewsTV
//
//  Created by Personal on 12/10/2023.
//

import SwiftUI

struct ArticleDetailView: View {
    
    @EnvironmentObject private var bookmarkVM: ArticleBookmarkViewModel
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.title)
                .foregroundStyle(.primary)
                .padding(.bottom)
            
            Text(article.captionText)
                .font(.subheadline)
                .padding(.bottom)
            
            detailView
        }
    }
    
    private var detailView: some View {
        HStack(alignment: .top) {
            asyncImage
            Spacer()
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text(article.descriptionText)
                        .font(.headline)
                    
                    Text(article.url)
                        .foregroundStyle(.secondary)
                    
                    Button {
                        bookmarkVM.toggleBookmark(for: article)
                    } label: {
                        if bookmarkVM.isBookmarked(for: article) {
                            Label("Remove from bookmark", systemImage: "bookmark.fill")
                        } else {
                            Label("Add bookmark", systemImage: "bookmark")
                        }
                    }
                }
                .padding(.leading, 15)
            }
        }
    }
    
    private var asyncImage: some View {
        AsyncImage(url: article.imageURL) { phase in
            switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                        Spacer()
                    }
                default:
                    fatalError()
            }
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(article: Article.previewData[1])
            .environmentObject(ArticleBookmarkViewModel.shared)
    }
}
