//
//  PlateAdditionSequenceTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

protocol PlateAdditionSequenceCellDelegate: class {
    func didChangeSum(sum: Double, in cell: PlateAdditionSequenceTableViewCell)
}

class PlateAdditionSequenceTableViewCell: PlateCollectionTableViewCell, PlateCollectionCellDelegate {
    weak var additionSequenceDelegate: PlateAdditionSequenceCellDelegate?
    
    private func getSum() -> Double {
        return data.map({$0.unitWeight}).reduce(0, +)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        data.remove(at: indexPath.section)
        additionSequenceDelegate?.didChangeSum(sum: getSum(), in: self)
        collectionView.reloadData()
    }
    
    // MARK: - PlateCollectionCellDelegate methods
    func didSelectPlate(plate: Plate, in cell: PlateCollectionTableViewCell) {
        // selected a plate from list, to add to sum
        loadPlates(plates: [plate], clearBeforeAdding: false)
    }
    
    func didUpdatePlateList(plates: [Plate], in cell: PlateCollectionTableViewCell) {
        // added a new type of plate to select ?
    }
    
    override func loadPlates(plates: [Plate], clearBeforeAdding: Bool = true) {
        super.loadPlates(plates: plates, clearBeforeAdding: clearBeforeAdding)
        additionSequenceDelegate?.didChangeSum(sum: getSum(), in: self)
    }
    
    override func setup() {
        super.setup()
        contentView.backgroundColor = .lighterBgroundGray()
    }

    
    func clear() {
        loadPlates(plates: [], clearBeforeAdding: true)
    }
}
