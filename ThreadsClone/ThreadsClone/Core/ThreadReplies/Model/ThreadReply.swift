//
//  ThreadReply.swift
//  ThreadsClone
//
//  Created by Personal on 18/01/2024.
//

import Firebase
import FirebaseFirestoreSwift

struct ThreadReply: Codable, Identifiable {
    @DocumentID var replyId: String?
    let threadId: String
    let replyText: String
    let threadReplyOwnerUid: String
    let threadOwnerUid: String
    let timestamp: Timestamp
    
    var thread: Thread?
    var replyUser: User?
    
    var id: String {
        return replyId ?? NSUUID().uuidString
    }
}

