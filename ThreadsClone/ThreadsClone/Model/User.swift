//
//  User.swift
//  ThreadsClone
//
//  Created by Personal on 11/12/2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
