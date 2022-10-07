//
//  EmptyView.swift
//  RAWG
//
//  Created by Kevin Maulana on 14/09/2022.
//

import Foundation
import Declayout

final class EmptyDataView: UIView {
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.center(to: self)
        $0.spacing = 8
        $0.edges(to: self)
    }
    
    lazy var image = UIImageView.make {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.height(250)
    }
    
    lazy var title = UILabel.make {
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    lazy var button = UIButton.make {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 10
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.backgroundColor = .orange
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subViews() {
        backgroundColor = .clear
        addSubviews([
            vStack.addArrangedSubviews([
                image,
                title,
                button
            ])
        ])
    }
}
