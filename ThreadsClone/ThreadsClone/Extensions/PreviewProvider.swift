//
//  PreviewProvider.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import Foundation
import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullname: "Ha Manh Do", email: "hatest@gmail.com", username: "hadm")
    
    lazy var thread = Thread(
        ownerUid: "123",
        caption: "This is a test thread",
        timestamp: Timestamp(),
        likes: 0,
        replyCount: 5,
        user: user
    )
    
    lazy var reply = ThreadReply(
        threadId: "123",
        replyText: "This a preview reply",
        threadReplyOwnerUid: "1234",
        threadOwnerUid: "12345",
        timestamp: Timestamp(),
        thread: thread,
        replyUser: user
    )
}
