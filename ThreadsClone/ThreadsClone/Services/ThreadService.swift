//
//  ThreadService.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ThreadService {
    static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }
    
    static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
    }
    
    static func fetchUserThreads(uid: String) async throws -> [Thread] {
        print("DEBUG: uid = \(uid)")
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        let threads = snapshot.documents.compactMap({ try? $0.data(as: Thread.self) })
        print("DEBUG: threads = \(threads.count)")
        return threads.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
}

// MARK: - Likes

extension ThreadService {
    static func likeThread(_ thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadRef = FirestoreConstants.ThreadsCollection.document(thread.id)
        
        // 3 tasks below run asynchronously
        async let _ = try await threadRef.collection("thread-likes").document(uid).setData([:])
        async let _ = try await threadRef.updateData(["likes": thread.likes + 1])
        async let _ = try await FirestoreConstants.UserCollection.document(uid).collection("user-likes").document(thread.id).setData([:])
    }
    
    static func unlikeThread(_ thread: Thread) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let threadRef = FirestoreConstants.ThreadsCollection.document(thread.id)
        
        async let _ = try await threadRef.collection("thread-likes").document(uid).delete()
        async let _ = try await threadRef.updateData(["likes": thread.likes - 1])
        async let _ = try await FirestoreConstants.UserCollection.document(uid).collection("user-likes").document(thread.id).delete()
    }
    
    static func checkIfUserLikedThread(_ thread: Thread) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(uid)
            .collection("user-likes")
            .document(thread.id)
            .getDocument()
        
        return snapshot.exists
    }
}
