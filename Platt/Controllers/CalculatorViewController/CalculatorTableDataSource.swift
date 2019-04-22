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

class CalculatorTableDataSource: NSObject, UITableViewDataSource {
    static var cellIds = ["PlateCollectionTableViewCell"] //,
//                "PlateAdditionSequenceTableViewCell",
//                "PlateSumTableViewCell",
//                "OptionsTableViewCell"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CalculatorTableDataSource.cellIds.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let out = tableView.dequeueReusableCell(withIdentifier: CalculatorTableDataSource.cellIds[indexPath.section], for: indexPath)
        
        switch indexPath.section {
        case 0:  // plate collection
            let plateCollectionCell = out as! PlateCollectionTableViewCell
            
        case 1:  // plate addition
            break
        case 2:  // plate sum
            break
        case 3:  // options
            break
        default: break
        }
        
        
        
        return out
    }
}
