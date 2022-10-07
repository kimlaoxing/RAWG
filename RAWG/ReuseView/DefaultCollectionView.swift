//
//  DefaultCollectionView.swift
//  RAWG
//
//  Created by Kevin Maulana on 01/10/22.
//

import Foundation
import UIKit

class DefaultCollectionView: UICollectionView {
    
    var isBouncesVertical: Bool = false
    var touchCallback: (() -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.touchCallback?()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.alwaysBounceVertical = isBouncesVertical
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
