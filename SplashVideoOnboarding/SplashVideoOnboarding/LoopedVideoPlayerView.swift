//
//  LoopedVideoPlayerView.swift
//  SplashVideoOnboarding
//
//  Created by Personal on 25/03/2024.
//

import SwiftUI
import AVKit

final class LoopedVideoPlayerView: UIView {
    fileprivate var videoURL: URL?
    fileprivate var queuPlayer: AVQueuePlayer?
    fileprivate var playerLayer: AVPlayerLayer?
    fileprivate var playbackLooper: AVPlayerLooper?
    
    func prepareVideo(_ videoURL: URL) {
        let playerItem = AVPlayerItem(url: videoURL)
        
        self.queuPlayer = AVQueuePlayer(playerItem: playerItem)
        self.playerLayer = AVPlayerLayer(player: self.queuPlayer)
        guard let playerLayer = self.playerLayer else { return }
        guard let queuPlayer = self.queuPlayer else { return }
        self.playbackLooper = AVPlayerLooper(player: queuPlayer, templateItem: playerItem)
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.frame
        self.layer.addSublayer(playerLayer)
    }
    
    func play() {
        self.queuPlayer?.play()
    }
    
    func pause() {
        self.queuPlayer?.pause()
    }
    
    func stop() {
        self.queuPlayer?.pause()
        self.queuPlayer?.seek(to: CMTime.init(seconds: 0, preferredTimescale: 1))
    }
    
    func unload() {
        self.playerLayer?.removeFromSuperlayer()
        self.playerLayer = nil
        self.queuPlayer = nil
        self.playbackLooper = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.playerLayer?.frame = self.bounds
    }
}

struct LoopedVideoPlayer: UIViewRepresentable {
    var videoName: String
    var videoType: String
    
    func makeUIView(context: Context) -> UIView {
        let url = Bundle.main.url(forResource: videoName, withExtension: videoType)
        let videoView = LoopedVideoPlayerView()
        videoView.prepareVideo(url!)
        videoView.play()
        return videoView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        (uiView as! LoopedVideoPlayerView).pause()
    }
}
