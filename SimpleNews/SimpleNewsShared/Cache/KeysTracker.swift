//
//  KeysTracker.swift
//  SimpleNews
//
//  Created by Personal on 12/10/2023.
//

import Foundation

final class KeysTracker<V>: NSObject, NSCacheDelegate {
    var keys = Set<String>()
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        guard let entry = obj as? CacheEntry<V> else {
            return
        }
        
        keys.remove(entry.key)
    }
}
