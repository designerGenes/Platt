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

class TypedCollectionView<CellType: ModernView.ModernCollectionViewCell, DataType, DSourceType: CollectionDataSource<CellType, DataType>>: CollectionViewWithSize {
    var _dataSource: DSourceType? {
        didSet {
            dataSource = _dataSource
        }
    }
    override func setup() {
        super.setup()
        _dataSource = DSourceType(collectionView: self)
    }
    
    required init(flowLayout: UICollectionViewFlowLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CollectionDataSource<CellType: ModernView.ModernCollectionViewCell, DataType: Any>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CollectionViewSizingDelegate {
    func widthForHeader(at section: Int) -> CGFloat {
        // override this or assign delegate
        return sizingDelegate?.widthForHeader(at: section) ?? 0
    }
    
    func widthForFooter(at section: Int) -> CGFloat {
        // override this or assign delegate
        return sizingDelegate?.widthForFooter(at: section) ?? 0
    }
    
    func widthForRow(at indexPath: IndexPath) -> CGFloat {
        // override this or assign delegate
        return sizingDelegate?.widthForRow(at: indexPath) ?? 0
    }
    

    var lastOffset: CGPoint = .zero
    weak var collectionView: ModernView.ModernCollectionView?
    weak var sizingDelegate: CollectionViewSizingDelegate?
    var data = [DataType]()
    
    
    func typeName(type: AnyClass) -> String {
        return String(describing: type.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    open func loadDataIntoCell(cell: CellType, at indexPath: IndexPath) {
        // override this
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: widthForFooter(at: section), height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: widthForHeader(at: section), height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthForRow(at: indexPath), height: 50) // TMP!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = data[indexPath.section]
        
        let reuseId = String(describing: CellType.self)
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! CellType
        loadDataIntoCell(cell: cell, at: indexPath)
        return cell
        
    }
    
    open func didSelectItem(at indexPath: IndexPath) {
        // override this
    }
    
    required init(collectionView: ModernView.ModernCollectionView) {
        super.init()
        self.collectionView = collectionView
        collectionView.register(CellType.self, forCellWithReuseIdentifier: String(describing: CellType.self))
    
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// contains a collection view
class CollectionTableViewCell<C, D, DS: CollectionDataSource<C, D>, CV: TypedCollectionView<C, D, DS>>: ModernView.ModernTableViewCell {
    
    var dataSource: DS? {
        return collectionView.dataSource as? DS
    }
    
    var collectionView: ModernView.ModernCollectionView!

    override func setup() {
        super.setup()
        contentView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 13, height: 53)
        collectionView = CV(flowLayout: flowLayout)
        coverSelfEntirely(with: collectionView, obeyMargins: false)
    }
}
