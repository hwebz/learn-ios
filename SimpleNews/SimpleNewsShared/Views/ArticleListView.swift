//
//  ArticleListView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct ArticleListView: View {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.selectedArticleURL) private var selectedArticleURL
//    @State private var selectedArticleURL: URL?
    #elseif os(macOS)
    @Environment(\.colorScheme) private var colorScheme
    #endif
    let articles: [Article]
//    @State private var selectedArticle: Article?
    
    var isFetchingNextPage = false
    var nextPageHandler: (() async -> ())? = nil
    
    var body: some View {
        rootView
        // We handled this one inside SimpleNewsApp.swift already
//        #if os(iOS)
////            .sheet(item: $selectedArticle) {
////                SafariView(url: $0.articleURL)
//            .sheet(item: $selectedArticleURL) {
//                SafariView(url: $0)
//                    .edgesIgnoringSafeArea(.bottom)
//                    // This one to force reload the safari view in case of new URL sent to the iPhone
//                    // during Safari still open old URL
//                    .id($0)
//            }
//            .onReceive(NotificationCenter.default.publisher(for: .articleSent, object: nil)) { notification in
//                if let url = notification.userInfo?["url"] as? URL, url != selectedArticleURL {
//                    selectedArticleURL = url
//                }
//            }
//            .onContinueUserActivity(activityTypeViewKey) { userActivity in
//                if let urlString = userActivity.userInfo?[activityURLKey] as? String,
//                   let url = URL(string: urlString),
//                   url != selectedArticleURL {
//                    selectedArticleURL = url
//                }
//            }
//        #endif
    }
    
    @ViewBuilder
    private var bottomProgressView: some View {
        Divider()
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        .padding()
    }
    
    #if os(iOS) || os(watchOS)
    var listView: some View {
        List {
            ForEach(articles) { article in
                if let nextPageHandler = nextPageHandler, article == articles.last {
                    listRowView(for: article)
                        .task { await nextPageHandler() }
                    
                    if isFetchingNextPage {
                        bottomProgressView
                    }
                } else {
                    listRowView(for: article)
                }
            }
            #if os(iOS)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
            #endif
        }
        .listStyle(.plain)
    }
    #endif
    
    @ViewBuilder
    private func listRowView(for article: Article) -> some View {
#if os(iOS)
        ArticleRowView(article: article)
            .onTapGesture {
                //                        selectedArticle = article
                selectedArticleURL.wrappedValue = article.articleURL
            }
#elseif os(watchOS)
        NavigationLink(destination: {
            ArticleDetailView(article: article)
        }, label: {
            ArticleRowView(article: article)
        })
#endif
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: gridSpacing) {
                ForEach(articles) { article in
                    if let nextPageHandler = nextPageHandler, article == articles.last {
                        gridItemView(for: article)
                            .task { await nextPageHandler() }
                    } else {
                        gridItemView(for: article)
                    }
                }
            }
            .padding()
            
            if isFetchingNextPage {
                bottomProgressView
            }
        }
        #if os(iOS)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        #endif
    }
    
    @ViewBuilder
    private func gridItemView(for article: Article) -> some View {
#if os(tvOS)
        NavigationLink {
            ArticleDetailView(article: article)
        } label: {
            ArticleItemView(article: article)
                .frame(width: 400, height: 400)
        }
#else
        ArticleRowView(article: article)
            .onTapGesture {
                handleOnTapGesture(article: article)
            }
#if os(iOS)
            .frame(height: 360)
            .background(Color(uiColor: .systemBackground))
#elseif os(macOS)
            .frame(height: 376)
            .background(Color(nsColor: colorScheme == .light ? .textBackgroundColor : .windowBackgroundColor))
#endif
            .mask(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 4)
            .padding(.bottom)
#endif
    }
    
    private var gridSpacing: CGFloat? {
        #if os(tvOS)
        48
        #else
        nil
        #endif
    }
    
    private var gridItems: [GridItem] {
        #if os(iOS)
        [GridItem(.adaptive(minimum: 300), spacing: 8)]
        #elseif os(macOS)
        [GridItem(.adaptive(minimum: 272, maximum: 272), spacing: 8)]
        #elseif os(tvOS)
        [GridItem(.adaptive(minimum: 400), spacing: 32)]
        #else
        []
        #endif
    }
    
    private func handleOnTapGesture(article: Article) {
        #if os(iOS)
//            self.selectedArticle = article
        self.selectedArticleURL.wrappedValue = article.articleURL
        #elseif os(macOS)
            NSWorkspace.shared.open(article.articleURL)
        #endif
    }
    
    @ViewBuilder
    private var rootView: some View {
        #if os(iOS)
        switch horizontalSizeClass {
            case .regular:
                gridView
            default:
                listView
        }
        #elseif os(macOS) || os(tvOS)
        gridView
        #elseif os(watchOS)
        listView
        #endif
    }
}

extension URL: Identifiable {
    public var id: String { absoluteString }
}

struct ArticleListView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
            .environmentObject(articleBookmarkVM)
    }
}
