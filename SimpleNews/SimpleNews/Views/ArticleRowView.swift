//
//  ArticleRowView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            /// Have to update Info -> Custom iOS Target Propperties
            /// To add "App Transport Security Settings" > "Allow Arbitrary Loads" = "YES"
            AsyncImage(url: article.imageURL) { phase in
                switch phase {
                    case .empty:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    case .success(let image):
                        image.resizable()
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
            .frame(minHeight: 200, maxHeight: 300)
            .background(.gray.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                
                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "bookmark")
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        /// Must include news.json in Project Settings -> Build Phases -> Copy Bundle Resources -> Add your json file
        NavigationView {
            List {
                ArticleRowView(article: .previewData![0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
}
