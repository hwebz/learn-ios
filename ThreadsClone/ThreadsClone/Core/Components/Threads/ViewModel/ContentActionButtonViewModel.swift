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
    
    func likeThread() {
        self.thread.didLike = true
    }
    
    func unlikeThread() {
        self.thread.didLike = false
    }
}
