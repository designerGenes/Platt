//
//  File.swift
//  Platt
//
//  Created by Jaden Nation on 5/21/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewSizingDelegate: class {
    func widthForHeader(at section: Int) -> CGFloat
    func widthForFooter(at section: Int) -> CGFloat
    func widthForRow(at indexPath: IndexPath) -> CGFloat
}

class ModernCollectionView<DSourceType: CollectionDataSource>: CollectionViewWithSize {
    
}

class CollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var lastOffset: CGPoint = .zero
    private weak var collectionView: ModernCollectionView<CollectionDataSource>?
    weak var sizingDelegate: CollectionViewSizingDelegate?
    
    
    func typeName(type: AnyClass) -> String {
        return String(describing: type.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cellTypesInOrder.count
    }
    
    open func loadDataIntoCell(cell: ModernView.ModernCollectionViewCell, at indexPath: IndexPath) {
        // override this
    }
    
    var cellTypesInOrder: [ModernView.ModernCollectionViewCell.Type] {
        return [] // override this
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: sizingDelegate?.widthForFooter(at: section) ?? 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: sizingDelegate?.widthForHeader(at: section) ?? 0, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sizingDelegate?.widthForRow(at: indexPath) ?? 0, height: 50) // TMP!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = typeName(type: cellTypesInOrder[indexPath.section])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! ModernView.ModernCollectionViewCell
        loadDataIntoCell(cell: cell, at: indexPath)
        return cell
        
    }
    
    open func didSelectItem(at indexPath: IndexPath) {
        // override this
    }
    
    required init<T: CollectionDataSource>(collectionView: ModernCollectionView<T>) {
        super.init()
        self.collectionView = collectionView as? ModernCollectionView<CollectionDataSource>
        for cellType in cellTypesInOrder {
            collectionView.register(cellType.self, forCellWithReuseIdentifier: String(describing: cellType.self))
        }
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// contains a collection view
class CollectionTableViewCell<DSourceType: CollectionDataSource>: ModernView.ModernTableViewCell {
    
    var collectionView: ModernView.ModernCollectionView!

    override func setup() {
        contentView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 13, height: 53)
        collectionView = ModernCollectionView<DSourceType>()
        coverSelfEntirely(with: collectionView, obeyMargins: false)
        
        backgroundColor = .clear
    }
}
