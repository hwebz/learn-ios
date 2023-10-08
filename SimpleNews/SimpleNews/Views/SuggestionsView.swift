//
//  SuggestionsView.swift
//  SimpleNews
//
//  Created by Personal on 08/10/2023.
//

import SwiftUI

struct SuggestionsView: View {
    @Environment(\.dismissSearch) var dismissSearch
    @StateObject var searchVM = ArticleSearchViewModel.shared
    
    var body: some View {
        ForEach(["Swift", "Covid-19", "BTC", "PS5", "iOS 15"], id: \.self) { text in
            Button {
                searchVM.searchQuery = text
                
            } label: {
                Text(text)
            }
        }
        
        Button {
            dismissSearch()
        } label: {
            Text("Close")
        }
    }
}

struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView()
    }
}
