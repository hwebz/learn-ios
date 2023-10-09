//
//  FocusedValue+RefreshAction.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

fileprivate var _refreshAction: (() -> Void)?

extension FocusedValues {
    
    var refreshAction: (() -> Void)? {
        get {
//            self[RefreshActionKey.self]
            _refreshAction
        }
        
        set {
//            self[RefreshActionKey.self] = newValue
            _refreshAction = newValue
        }
    }
    
    struct RefreshActionKey: FocusedValueKey {
        typealias Value = () -> Void
    }
}
