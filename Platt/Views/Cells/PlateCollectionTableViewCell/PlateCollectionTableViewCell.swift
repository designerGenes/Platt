//
//  PlateCollectionTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateCollectionDataSource: CollectionDataSource<PlateCollectionViewCell, Plate> {
    override func loadDataIntoCell(cell: PlateCollectionViewCell, at indexPath: IndexPath) {
        cell.loadPlate(plate: data[indexPath.section], position: 1)
    }
    
    override func widthForRow(at indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func didSelectCell(data: Plate, at indexPath: IndexPath) {
        PlateCalculator.activeInstance.add(plate: data)
    }
    
    func loadPlates(plates: [Plate]) {
        data = plates
        collectionView?.reloadData()
        if data.count > 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.collectionView?.scrollToItem(at: IndexPath(row: 0, section: self.data.count - 1), at: .right, animated: false)
            }
        }
    }
}

class PlateCollectionView: TypedCollectionView<PlateCollectionViewCell, Plate, PlateCollectionDataSource> {
    // convenience
}

// contains lateral collection of Plate cells
class PlateCollectionTableViewCell: CollectionTableViewCell<PlateCollectionViewCell, Plate, PlateCollectionDataSource, PlateCollectionView> {
    
    override func setup() {
        super.setup()
        backgroundColor = .spotifyMud()
    }
    
}
