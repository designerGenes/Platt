//
//  File.swift
//  Platt
//
//  Created by Jaden Nation on 5/21/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit



// contains a collection view
class CalculatorCollectionTableViewCell<CellType: UICollectionViewCell, DataType>: DJView.DJTableViewCell, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var lastOffset: CGPoint = .zero
    private var touchIsDown: Bool = false
    var collectionView: CollectionViewWithSize!
    var data = [DataType]()
    
    func loadDataIntoCell(cell: CellType, at indexPath: IndexPath) {
        // override this
    }
    
    
    func reuseIdentifier(indexPath: IndexPath) -> String {
        // override this
        return ""
    }
    
    func cellForIndexPath(at indexPath: IndexPath) -> CellType {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier(indexPath: indexPath), for: indexPath) as! CellType
        loadDataIntoCell(cell: cell, at: indexPath)
        return cell
    }
    
    open func didSelectItem(indexPath: IndexPath) {
        // override this
    }
    
    func headerWidth(section: Int) -> CGFloat {
        return 0
    }
    
    func footerWidth(section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: footerWidth(section: section), height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: headerWidth(section: section), height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resetToLastX()
//        didSelectItem(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForIndexPath(at: indexPath)
    }
    
    override func setup() {
        contentView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 13, height: 53)
        collectionView = CollectionViewWithSize(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        coverSelfEntirely(with: collectionView, obeyMargins: false)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        backgroundColor = .clear
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset
    }
    
    func resetToLastX() {
        collectionView.setContentOffset(lastOffset, animated: false)
    }
}
