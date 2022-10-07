//
//  SWInflateLayout.swift
//  RAWG
//
//  Created by Vlad on 12/17/18.
//  Copyright © 2018 Vlad Iacob. All rights reserved.

import Foundation
import UIKit

public final class SWInflateLayout: UICollectionViewFlowLayout {
    // MARK: - Properties
    
    public var isPagingEnabled = true
    public var leftContentOffset: CGFloat = 0
    private var firstSetupDone = false
    private var cellWidth: CGFloat = 0
    private var contentSpacing: CGFloat = 0
    
    // MARK: - Override
    
    override public func prepare() {
        super.prepare()
        
        guard !firstSetupDone else {
            return
        }
        
        scrollDirection = .horizontal
        firstSetupDone = true
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let items = NSMutableArray(array: super.layoutAttributesForElements(in: rect)!, copyItems: true)
        
        guard let firstCellAttribute = items.firstObject as? UICollectionViewLayoutAttributes else {
            return nil
        }
        
        cellWidth = firstCellAttribute.size.width
        
        guard let collectionViewBounds  = collectionView?.bounds else {
            return nil
        }
        
        contentSpacing = (collectionViewBounds.width - cellWidth) / 2 - leftContentOffset
        collectionView?.contentInset = UIEdgeInsets(top: collectionView?.contentInset.top ?? 0, left: contentSpacing - leftContentOffset, bottom: collectionView?.contentInset.bottom ?? 0, right: 15)
        
        items.enumerateObjects { (object, _, _) in
            let attribute = object as! UICollectionViewLayoutAttributes
            self.cellWidth = attribute.size.width
            self.updateCellAttributes(attribute: attribute)
        }
        
        return items as? [UICollectionViewLayoutAttributes]
    }
    
    // MARK: - Private functions
    
    private func updateCellAttributes(attribute: UICollectionViewLayoutAttributes) {
        var finalX: CGFloat = attribute.frame.midX - (collectionView?.contentOffset.x)!
        let centerX = attribute.frame.midX - (collectionView?.contentOffset.x)!
        if centerX < collectionView!.frame.midX - contentSpacing {
            finalX = max(centerX, collectionView!.frame.minX)
        } else if centerX > collectionView!.frame.midX + contentSpacing {
            finalX = min(centerX, collectionView!.frame.maxX)
        }
        
        let deltaY = abs(finalX - collectionView!.frame.midX) / attribute.frame.width
        let scale = 1 - deltaY * 0.2
        let alpha = 1 - deltaY
        
        attribute.alpha = alpha
        attribute.transform = CGAffineTransform(scaleX: 1, y: scale)
    }
}
