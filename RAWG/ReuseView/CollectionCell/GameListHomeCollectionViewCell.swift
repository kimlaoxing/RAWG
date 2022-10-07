//
//  GameListHomeCollectionViewCell.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/09/2022.
//

import Declayout

final class GameListHomeCollectionViewCell: UICollectionViewCell {
    
    private lazy var gameListHomeView = GameListHomeView.make {
        $0.edges(to: contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubview(gameListHomeView)
    }
    
    func setContent(with data: GameResponse.GameResult) {
        gameListHomeView.setContent(with: data)
    }
}
