//
//  CalculatorTableDataSource.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit


class CalculatorTableDataSource: NSObject, UITableViewDataSource, PlateCalculatorDelegate, ButtonDrawerDelegate, PlateCollectionDelegate  {
    var cellRefs = [CalculatorTableCellId: CalculatorTableCell]()
    var plateCalculator = PlateCalculator()
    weak var tableView: UITableView?
    
    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
        self.tableView = tableView
        plateCalculator.delegate = self
    }
    
    // MARK: - PlateCollectionCellDelegate methods
    func didSelectPlate(plate: Plate, sender: UIView) {
        switch sender {
        case cellRefs[.PlateCollectionTableViewCell]:
            plateCalculator.add(plate: plate)
        case cellRefs[.BarVisualizerTableViewCell]:
            plateCalculator.remove(plate: plate)
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
        tableView?.reloadData()
    }
    
    func didUpdateConfigOption(option: CalculatorConfigOption, in calculator: PlateCalculator) {
        switch option {
        default: tableView?.reloadData()
        }
    }
    
    enum CalculatorTableCellId: String {
        case PlateCollectionTableViewCell, BarVisualizerTableViewCell, PlateSumTableViewCell, ButtonDrawerTableViewCell
        static func inOrder() -> [CalculatorTableCellId] {
            return [
                CalculatorTableCellId.PlateSumTableViewCell,
                CalculatorTableCellId.PlateCollectionTableViewCell,
                CalculatorTableCellId.BarVisualizerTableViewCell,
                CalculatorTableCellId.ButtonDrawerTableViewCell
                ]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CalculatorTableCellId.inOrder().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = CalculatorTableCellId.inOrder()[indexPath.section]
        let out = tableView.dequeueReusableCell(withIdentifier: id.rawValue, for: indexPath) as! CalculatorTableCell
        cellRefs[id] = out
        
        switch indexPath.section {
        case 0:  // plate sum
            (out as? PlateSumTableViewCell)?.reflectSum(in: plateCalculator)
        case 1:  // plate addition
            let plateCollectionCell = out as! PlateCollectionTableViewCell
            plateCollectionCell.delegate = self
            plateCollectionCell.loadPlates(plates: PlatesLibrary.defaultPlates) // TMP!
        case 2: // bar visualizer
            let barVisualizerCell = out as! BarVisualizerTableViewCell
            let barVView = barVisualizerCell.barVisualizeView
            barVisualizerCell.delegate = self
            barVView.loadPlates(plates: plateCalculator.plates)
        case 3:  // options
            let buttonDrawerCell = out as! ButtonDrawerTableViewCell
            buttonDrawerCell.calculator = plateCalculator
            buttonDrawerCell.delegate = self
            buttonDrawerCell.collectionView.reloadData()
            
        default: break
        }
        
        
        
        return out
    }
}
