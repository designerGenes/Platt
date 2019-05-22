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

class CollectionViewWithSize: ModernView.ModernCollectionView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: 100)
    }
}

class PlateCollectionDataSource: CollectionDataSource<PlateCollectionViewCell, Plate> {
    weak var delegate: PlateCollectionTableViewCell?
    override func loadDataIntoCell(cell: PlateCollectionViewCell, at indexPath: IndexPath) {
        cell.loadPlate(plate: data[indexPath.section], position: 1)
    }
    
    override func widthForRow(at indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func didSelectItem(at indexPath: IndexPath) {
        delegate?.didSelectPlate(plate: data[indexPath.section], sender: self)
    }
    
    func loadPlates(plates: [Plate]) {
        data = plates
        collectionView?.reloadData()
    }
}

// contains lateral collection of Plate cells
class PlateCollectionTableViewCell: CollectionTableViewCell<PlateCollectionViewCell, Plate, PlateCollectionDataSource, TypedCollectionView<PlateCollectionViewCell, Plate, PlateCollectionDataSource>> {
    weak var delegate: PlateCollectionDelegate?
    
    override func setup() {
        super.setup()
        backgroundColor = .spotifyMud()
    }
    
    func didSelectPlate(plate: Plate, sender: PlateCollectionDataSource) {

    }
}
