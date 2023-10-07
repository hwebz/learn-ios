//
//  ContentView.swift
//  SimpleNews
//
//  Created by Personal on 07/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArticleListView(articles: Article.previewData!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
