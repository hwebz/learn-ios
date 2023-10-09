//
//  NewsCommands.swift
//  SimpleNewsMac
//
//  Created by Personal on 10/10/2023.
//

import SwiftUI

struct NewsCommands: Commands {
    var body: some Commands {
        CommandGroup(before: .sidebar) {
            BodyView()
                .keyboardShortcut("R", modifiers: [.command])
        }
    }
    
    struct BodyView: View {
        @FocusedValue(\.refreshAction) private var refreshAction: (() -> Void)?
        
        var body: some View {
            Button("Refresh News") {
                refreshAction?()
            }
        }
    }
}
