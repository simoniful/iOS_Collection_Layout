//
//  HorizontalFlowLayout.swift
//  Playground
//
//  Created by Sang hun Lee on 2022/07/06.
//

import UIKit

// 서브 클래스로 정의하여 커스텀
protocol HorizontalFlowLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView, sizeForPillAtIndexPath indexPath: IndexPath
    ) -> CGSize
    func collectionView(
        _ collectionView: UICollectionView, insetsForItemsInSection section: Int
    ) -> UIEdgeInsets
    func collectionView(
        _ collectionView: UICollectionView, itemSpacingInSection section: Int
    ) -> CGFloat
    func collectionView(
        _ collectionView: UICollectionView, lineWidthSection: Int
    ) -> CGFloat
}

final class HorizontalFlowLayout: UICollectionViewFlowLayout {
    
    weak var delegate: HorizontalFlowLayoutDelegate?
    
    var layoutHeight: CGFloat = 0.0
    var layoutWidth: CGFloat = 0.0
    
    private var itemCache: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        
        itemCache.removeAll()
        
        guard let collectionView = collectionView else {
            return
        }
        
        var layoutWidthIterator: CGFloat = 0.0
        
        for section in 0..<collectionView.numberOfSections {
            let insets: UIEdgeInsets = delegate?.collectionView(collectionView, insetsForItemsInSection: section) ?? UIEdgeInsets.zero
            let interItemSpacing: CGFloat = delegate?.collectionView(collectionView, itemSpacingInSection: section) ?? 0.0
            let maxLineWidth: CGFloat = delegate?.collectionView(collectionView, lineWidthSection: section) ?? 0.0
            var itemSize: CGSize = .zero
            layoutWidth = maxLineWidth
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                
                itemSize = delegate?.collectionView(collectionView, sizeForPillAtIndexPath: indexPath) ?? .zero
                
                if (layoutWidthIterator + itemSize.width + insets.left + insets.right) > maxLineWidth {
                    layoutWidthIterator = 0.0
                    layoutHeight += itemSize.height + interItemSpacing
                }
                
                let frame = CGRect(
                    x: layoutWidthIterator + insets.left,
                    y: layoutHeight,
                    width: itemSize.width,
                    height: itemSize.height
                )
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                itemCache.append(attributes)
                layoutWidthIterator = layoutWidthIterator + frame.width + interItemSpacing
            }
            
            layoutWidthIterator = 0.0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)-> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in itemCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
        return itemCache[indexPath.row]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: layoutWidth, height: contentHight)
    }
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    private var contentHight: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.bottom + insets.top)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        layoutHeight = 0.0
        layoutWidth = 0.0
        return true
    }
}
