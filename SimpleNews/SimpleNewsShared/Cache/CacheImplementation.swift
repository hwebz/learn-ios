//
//  CacheImplementation.swift
//  SimpleNews
//
//  Created by Personal on 12/10/2023.
//

import Foundation

fileprivate protocol NSCacheType: Cache {
    var cache: NSCache<NSString, CacheEntry<V>> { get }
}

actor InMemoryCache<V>: NSCacheType {
    fileprivate let cache: NSCache<NSString, CacheEntry<V>> = .init()
    let expirationInterval: TimeInterval
    
    init(expirationInterval: TimeInterval) {
        self.expirationInterval = expirationInterval
    }
}

extension NSCacheType {
    func removeValue(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func removeAllValues() {
        cache.removeAllObjects()
    }
    
    func setValue(_ value: V?, for key: String) {
        if let value = value {
            let expiredTimestamp = Date().addingTimeInterval(expirationInterval)
            let cacheEntry = CacheEntry(key: key, value: value, expiredTimestamp: expiredTimestamp)
            cache.setObject(cacheEntry, forKey: key as NSString)
        } else {
            removeValue(forKey: key)
        }
    }
    
    func value(forKey key: String) -> V? {
        guard let entry = cache.object(forKey: key as NSString) else {
            return nil
        }
        
        guard !entry.isCacheExpired(after: Date()) else {
            removeValue(forKey: key)
            return nil
        }
        
        return entry.value
    }
    
    func entry(forKey key: String) -> CacheEntry<V>? {
        guard let entry = cache.object(forKey: key as NSString) else {
            return nil
        }
        
        guard !entry.isCacheExpired(after: Date()) else {
            removeValue(forKey: key)
            return nil
        }
        
        return entry
    }
    
    func insert(_ entry: CacheEntry<V>) {
        cache.setObject(entry, forKey: entry.key as NSString)
    }
}


