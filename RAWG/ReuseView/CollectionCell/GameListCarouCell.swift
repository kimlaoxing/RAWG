//
//  GameListCarouCell.swift
//  RAWG
//
//  Created by Kevin Maulana on 01/10/22.
//

import Declayout
import AVKit
import AVFoundation

final class GameListCarouCell: UICollectionViewCell {
    
    private lazy var playerView = PlayerView.make {
        $0.edges(to: contentView)
        $0.layer.cornerRadius = 15
    }
    
    private var videoPlayer: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubview(playerView)
    }
    
    func setContent(with data: GameTrailer.Result) {
        if let videoURL = URL(string: data.data?.the480 ?? "") {
            let player = AVPlayer(url: videoURL)
            videoPlayer = player
            playerView.player = videoPlayer
        }
    }
    
    func playVideo() {
        videoPlayer?.playImmediately(atRate: 1)
    }
    
    func stopVideo() {
        videoPlayer?.pause()
    }
}
