//
//  PlayerView.swift
//  RAWG
//
//  Created by Kevin Maulana on 06/10/22.
//

import Foundation
import AVKit
import AVFoundation

final class PlayerView: UIView {
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        
        set {
            playerLayer.player = newValue
        }
    }
}
