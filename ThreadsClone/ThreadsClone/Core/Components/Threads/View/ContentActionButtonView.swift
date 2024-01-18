//
//  ContentActionButtonView.swift
//  ThreadsClone
//
//  Created by Personal on 18/01/2024.
//

import SwiftUI

struct ContentActionButtonView: View {
    @ObservedObject var viewModel: ContentActionButtonViewModel
    @State private var showReplySheet = false
    
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
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Button {
                    Task { try await handleLikeTapped() }
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .foregroundColor(didLike ? .red : .black)
                }
                
                Button {
                    showReplySheet.toggle()
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
            .padding(.top, 8)
            .foregroundColor(.black)
            
            HStack(spacing: 4) {
                if (viewModel.thread.replyCount > 0) {
                    Text("\(viewModel.thread.replyCount) replies")
                }
                
                if (viewModel.thread.replyCount > 0 && viewModel.thread.likes > 0) {
                    Text("-")
                }
                
                if (viewModel.thread.likes > 0) {
                    Text("\(viewModel.thread.likes) likes")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $showReplySheet) {
            ThreadReplyView(thread: viewModel.thread)
        }
    }
}

struct ContentActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContentActionButtonView(thread: dev.thread)
    }
}
