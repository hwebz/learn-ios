//
//  UserContentListViewModel.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    @Published var threads = [Thread]()
    @Published var replies = [ThreadReply]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task {
            try await fetchUserThreads()
        }
        Task { try await fetchUserReplies() }
    }
    
    func fetchUserThreads() async throws {
        var threads = try await ThreadService.fetchUserThreads(uid: user.id)
        
        for i in 0 ..< threads.count {
            threads[i].user = user
        }
        
        self.threads = threads
    }
    
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            threads[i].user = user
        }
    }
    
    func fetchUserReplies() async throws {
        self.replies = try await ThreadService.fetchThreadReplies(forUser: user)
        
        try await fetchReplyThreadData()
    }
    
    func fetchReplyThreadData() async throws {
        for i in 0 ..< replies.count {
            let reply = replies[i]
            
            var thread = try await ThreadService.fetchThread(threadId: reply.threadId)
            thread.user = try await UserService.fetchUser(withUid: thread.ownerUid)
            
            replies[i].thread = thread
        }
    }
}
