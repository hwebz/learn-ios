//
//  FeedView.swift
//  ThreadsClone
//
//  Created by Personal on 21/11/2023.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.threads) { thread in
                        NavigationLink(value: thread) {
                            ThreadCell(thread: thread)
                        }
                    }
                }
            }
            .refreshable {
                print("DEBUG: Refresh threads")
                Task { try await viewModel.fetchThreads() }
            }
            .navigationDestination(for: Thread.self, destination: { thread in
                ThreadDetailsView(thread: thread)
            })
            .navigationTitle("Threads")
            .navigationBarTitleDisplayMode(.inline)
            // Automatically fetching new threads whenever this view appreared
            // To prevent the unnecessary fetch (fetched only after create new thread)
            // we need to create viewModel in parent's view
            // and then fetching threads when it's needed
//            .onAppear {
//                Task { try await viewModel.fetchThreads() }
//            }
        }
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .foregroundColor(.black)
                
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedView()
        }
    }
}
