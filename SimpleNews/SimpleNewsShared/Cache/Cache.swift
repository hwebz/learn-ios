//
//  Cache.swift
//  SimpleNews
//
//  Created by Personal on 12/10/2023.
//

import Foundation

protocol Cache: Actor {
    associatedtype V
    var expirationInterval: TimeInterval { get }
    
    func removeValue(forKey key: String)
    func removeAllValues()
    func setValue(_ value: V?, for key: String)
    func value(forKey key: String) -> V?
}
