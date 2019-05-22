//
//  CalculatorTableDataSource.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class CalculatorTableDataSource: StaticListTableViewDataSource, ButtonDrawerDelegate  {
    
    let plateCalculator = PlateCalculator.activeInstance // calls all the shots after init
    
    override var cellTypesInOrder: [ModernView.ModernTableViewCell.Type] {
        return [
            PlateSumTableViewCell.self,
            PlateCollectionTableViewCell.self,
            BarVisualizerTableViewCell.self,
            ButtonDrawerTableViewCell.self
        ]
    }
    
    // MARK: - ButtonDrawerDelegate methods
    func didTapDrawerButton(buttonType: DrawerButtonType) {
        switch buttonType {
        case .clear:
            plateCalculator.clear()
        case .toggleMultiplier:
            plateCalculator.toggleMultiplier()
        case .toggleMeasurementSystem:
            plateCalculator.toggleMeasurementSystem()
        }
    }
    
    // load initial data
    override func loadDataIntoCell(cell: ModernView.ModernTableViewCell, at indexPath: IndexPath) {
        switch cell {
        case is PlateSumTableViewCell:
            let sumCell = cell as! PlateSumTableViewCell
            sumCell.reflectSum(sum: plateCalculator.sum())
        case is PlateCollectionTableViewCell:
            let plateCollectionCell = cell as! PlateCollectionTableViewCell
            let defaultPlates = PlatesLibrary.defaultPlates(measurementSystem: plateCalculator.measurementSystem) // TMP!
            plateCollectionCell.dataSource?.loadPlates(plates: defaultPlates)
        case is BarVisualizerTableViewCell:
            let barVisualizerCell = cell as! BarVisualizerTableViewCell
            barVisualizerCell.barVisualizerView.loadPlates(plates: plateCalculator.plates)
        case is ButtonDrawerTableViewCell:
            let buttonDrawerCell = cell as! ButtonDrawerTableViewCell
            buttonDrawerCell.dataSource?.calculator = plateCalculator
            buttonDrawerCell.delegate = self
        default:
            break
        }
    }
}
