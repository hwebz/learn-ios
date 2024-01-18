//
//  ContentActionButtonViewModel.swift
//  ThreadsClone
//
//  Created by Personal on 18/01/2024.
//

import Foundation

class ContentActionButtonViewModel: ObservableObject {
    @Published var thread: Thread
    
    init(thread: Thread) {
        self.thread = thread
    }
    
    func likeThread() async throws {
        try await ThreadService.likeThread(thread)
        self.thread.didLike = true
        self.thread.likes += 1
    }
    
    func unlikeThread() async throws {
        try await ThreadService.unlikeThread(thread)
        self.thread.didLike = false
        self.thread.likes -= 1
    }
}
