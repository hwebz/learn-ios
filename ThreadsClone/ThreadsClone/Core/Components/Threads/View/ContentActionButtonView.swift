//
//  ContentActionButtonView.swift
//  ThreadsClone
//
//  Created by Personal on 18/01/2024.
//

import SwiftUI

struct ContentActionButtonView: View {
    @ObservedObject var viewModel: ContentActionButtonViewModel
    
    init(thread: Thread) {
        self.viewModel = ContentActionButtonViewModel(thread: thread)
    }
    
    private var didLike: Bool {
        return viewModel.thread.didLike ?? false
    }
    
    func handleLikeTapped() async throws {
        if didLike {
            try await viewModel.unlikeThread()
        } else {
            try await viewModel.likeThread()
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                Task { try await handleLikeTapped() }
            } label: {
                Image(systemName: didLike ? "heart.fill" : "heart")
                    .foregroundColor(didLike ? .red : .black)
            }
            
            Button {
                
            } label: {
                Image(systemName: "bubble.right")
            }
            
            Button {
                
            } label: {
                Image(systemName: "arrow.rectanglepath")
            }
            
            Button {
                
            } label: {
                Image(systemName: "paperplane")
            }
        }
        .padding(.vertical, 8)
        .foregroundColor(.black)
    }
}

struct ContentActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContentActionButtonView(thread: dev.thread)
    }
}
