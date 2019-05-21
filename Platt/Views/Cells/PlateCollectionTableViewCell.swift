//
//  PlateCollectionTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

protocol PlateCollectionDelegate: class {
    func didSelectPlate(plate: Plate, sender: UIView)
}

class CollectionViewWithSize: UICollectionView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: 100)
    }
}

// contains lateral collection of Plate cells
class PlateCollectionTableViewCell: CalculatorTableCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var data = [Plate]()
    var collectionView: UICollectionView!
    weak var delegate: PlateCollectionDelegate?
    
    // MARK: - lifecycle methods
    func loadPlates(plates: [Plate]) {
        data = plates
        collectionView.reloadData()
    }
    
    
    override func setup() {
        super.setup()
        contentView.backgroundColor = .clear
        

        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 13, height: 53)
        
        collectionView = CollectionViewWithSize(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        coverSelfEntirely(with: collectionView, obeyMargins: false)
        collectionView.backgroundColor = .clear
        collectionView.register(PlateCollectionViewCell.self, forCellWithReuseIdentifier: "PlateCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 8, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 8, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectPlate(plate: data[indexPath.section], sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlateCollectionViewCell", for: indexPath) as! PlateCollectionViewCell
        cell.loadPlate(plate: data[indexPath.section], position: indexPath.section)
        return cell
    }
    
    
    
    

}
