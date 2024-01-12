//
//  AnimatedBackground.swift
//  SmartHomeUI
//
//  Created by Personal on 06/01/2024.
//

import SwiftUI

struct AnimatedBackground: View {
    @State private var startAnimation: Bool = true
    
    var body: some View {
        ZStack {
            Color.black
            LinearGradient(
                colors: [
                    .yellow.opacity(0.4),
                    .black
                ],
                startPoint: startAnimation ? .topLeading : .bottomLeading,
                endPoint: startAnimation ? .bottomTrailing : .topTrailing
            )
        }
    }
}

#Preview {
    AnimatedBackground()
}
