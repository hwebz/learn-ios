//
//  DataFetchPhase.swift
//  SimpleNews
//
//  Created by Personal on 12/10/2023.
//

import Foundation

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        
        return nil
    }
}
