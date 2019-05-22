//
//  CalculatorTableDataSource.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class CalculatorTableDataSource: StaticListTableViewDataSource, PlateCalculatorDelegate, ButtonDrawerDelegate, PlateCollectionDelegate  {
    
    var plateCalculator = PlateCalculator()
    
    required init<T>(tableView: StaticListTableView<T>) where T : StaticListTableViewDataSource {
        super.init(tableView: tableView)
        plateCalculator.delegate = self
    }
    
    override var cellTypesInOrder: [ModernView.ModernTableViewCell.Type] {
        return [
            PlateSumTableViewCell.self,
            PlateCollectionTableViewCell.self,
            BarVisualizerTableViewCell.self,
            ButtonDrawerTableViewCell.self
        ]
    }
    
    // MARK: - PlateCollectionCellDelegate methods
    func didSelectPlate(plate: Plate, sender: UIView) {
        switch sender {
//        case self[.PlateCollectionTableViewCell]:
//            plateCalculator.add(plate: plate)
//        case self[.BarVisualizerTableViewCell]:
//            plateCalculator.remove(plate: plate)
        default: break
        }
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
    
    // MARK: - PlateCalculatorDelegate methods
    func didUpdateSum(sum: Double, in calculator: PlateCalculator) {
        
        
//        if let plateCollectionCell = self[PlateCollectionTableViewCell.self] as? PlateCollectionTableViewCell {
////            plateCollectionCell.resetToLastX()
//        }
    }
    
    func didUpdateConfigOption(option: CalculatorConfigOption, in calculator: PlateCalculator) {
        
//        switch option {
//        default: tableView?.reloadData()
//        }
    }
    
    override func loadDataIntoCell(cell: ModernView.ModernTableViewCell, at indexPath: IndexPath) {
        switch cell {
        case is PlateSumTableViewCell:
            break
        case is PlateCollectionTableViewCell:
            let plateCollectionCell = cell as! PlateCollectionTableViewCell
            let defaultPlates = PlatesLibrary.defaultPlates(measurementSystem: plateCalculator.measurementSystem) // TMP!
            plateCollectionCell.dataSource?.loadPlates(plates: defaultPlates)
            

            break
        case is BarVisualizerTableViewCell:
            break
        case is ButtonDrawerTableViewCell:
            let buttonDrawerCell = cell as! ButtonDrawerTableViewCell
            buttonDrawerCell.dataSource?.calculator = plateCalculator
        default:
            break
            
            /*
             case 0:  // plate sum
             (out as? PlateSumTableViewCell)?.reflectSum(in: plateCalculator)
             case 1:  // plate addition
             let plateCollectionCell = out as! PlateCollectionTableViewCell
             plateCollectionCell.delegate = self
             case 2: // bar visualizer
             let barVisualizerCell = out as! BarVisualizerTableViewCell
             let barVView = barVisualizerCell.barVisualizerView
             barVisualizerCell.delegate = self
             barVView.loadPlates(plates: plateCalculator.plates)
             case 3:  // options
             let buttonDrawerCell = out as! ButtonDrawerTableViewCell
             buttonDrawerCell.calculator = plateCalculator
             buttonDrawerCell.delegate = self
             buttonDrawerCell.collectionView.reloadData()
             */
        }
    }
}
