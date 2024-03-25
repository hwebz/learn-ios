//
//  ContentView.swift
//  SplashVideoOnboarding
//
//  Created by Personal on 25/03/2024.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var Dshow = false
    
    var body: some View {
        ZStack {
            LoopedVideoPlayer(videoName: "working", videoType: "mp4")
            StartedView(Dshow: $Dshow)
            SignInView(showSignView: $Dshow)
                .offset(y: Dshow ? 0 : 450)
        }.ignoresSafeArea()
        
    }
}

#Preview {
    ContentView()
}
