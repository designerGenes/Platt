//
//  CalculatorTableDataSource.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

protocol CalculatorTableCellData: class {
    
}

class CalculatorTableDataSource: NSObject, UITableViewDataSource, ButtonDrawerDelegate {
    static var cellRefs = [String: CalculatorTableCell]()
    
    static let cellIds = [
        "PlateCollectionTableViewCell",
        "PlateAdditionSequenceTableViewCell",
        "PlateSumTableViewCell",
        "ButtonDrawerTableViewCell"
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CalculatorTableDataSource.cellIds.count
    }
    
    
    
    // MARK: - ButtonDrawerDelegate methods
    func didTapDrawerButton(buttonType: DrawerButtonType) {
        let cfg = SessionConfig.activeConfig()
        switch buttonType {
        case .clear: cfg.clear()
        case .toggleMultiplier:
            let mult = cfg.configOptions[.multiplier] as! Int
            cfg.configOptions[.multiplier] = [1, 2].filter({$0 != mult}).first!
            SessionConfig.updateListeners()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = CalculatorTableDataSource.cellIds[indexPath.section]
        let out = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! CalculatorTableCell
        CalculatorTableDataSource.cellRefs[id] = out
        switch indexPath.section {
        case 0:  // plate collection
            let plateCollectionCell = out as! PlateCollectionTableViewCell
            plateCollectionCell.loadPlates(plates: Plate.defaultPlates) // TMP!
        case 1:  // plate addition
            let plateAdditionCell = out as! PlateAdditionSequenceTableViewCell
            let pCollectionCell = (CalculatorTableDataSource.cellRefs["PlateCollectionTableViewCell"] as? PlateCollectionTableViewCell)
            pCollectionCell?.delegate = plateAdditionCell
            plateAdditionCell.loadPlates(plates: SessionConfig.activeConfig().plates, clearBeforeAdding: true)
        case 2:  // plate sum
            let pAdditionCell = (CalculatorTableDataSource.cellRefs["PlateAdditionSequenceTableViewCell"] as? PlateAdditionSequenceTableViewCell)
            pAdditionCell?.additionSequenceDelegate = out as! PlateSumTableViewCell
            (out as? PlateSumTableViewCell)?.reflectSum()
        case 3:  // options
            let buttonDrawerCell = out as! ButtonDrawerTableViewCell
            buttonDrawerCell.delegate = self
            buttonDrawerCell.collectionView.reloadData()
            
        default: break
        }
        
        
        
        return out
    }
}
