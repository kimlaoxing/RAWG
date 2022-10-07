//
//  UICollectionView.swift
//  RAWG
//
//  Created by Kevin Maulana on 06/10/22.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func reloads() {
        DispatchQueue.main.async {
            self.reloadData()
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    private var defaultCollectionViewHeight: CGFloat {
        guard let refresh = refreshControl?.bounds else { return 0 }
        return refresh.height + 50
    }
    
    var layoutContentSizeHeight: CGFloat {
        let height = collectionViewLayout.collectionViewContentSize.height
        return height != 0 ? height : defaultCollectionViewHeight
    }
}
