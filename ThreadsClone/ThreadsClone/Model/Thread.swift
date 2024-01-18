//
//  Thread.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    var replyCount: Int
    
    var didLike: Bool? = false
    
    var id: String {
        return threadId ?? NSUUID().uuidString
    }
    
    var user: User?
}
