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
class PlateCollectionTableViewCell: CalculatorCollectionTableViewCell<PlateCollectionViewCell, Plate> {
    weak var delegate: PlateCollectionDelegate?
    
    override func reuseIdentifier(indexPath: IndexPath) -> String {
        return "PlateCollectionViewCell"  // imperfect solution
    }
    
    override func loadDataIntoCell(cell: PlateCollectionViewCell, at indexPath: IndexPath) {
        cell.loadPlate(plate: data[indexPath.section], position: 1)
    }
    
    override func didSelectItem(indexPath: IndexPath) {
        delegate?.didSelectPlate(plate: data[indexPath.section], sender: self)
    }
    
    // MARK: - lifecycle methods
    func loadPlates(plates: [Plate]) {
        data = plates
        collectionView.reloadData()
    }
    
    
    override func setup() {
        super.setup()
        collectionView.register(PlateCollectionViewCell.self, forCellWithReuseIdentifier: "PlateCollectionViewCell")
    }
    
    
    
    
    
    

}
