//
//  ExploreView.swift
//  ThreadsClone
//
//  Created by Personal on 21/11/2023.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(0 ... 10, id: \.self) { user in
                        VStack {
                            UserCell()
                            
                            Divider()
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
