//
//  StaticListTableView.swift
//  Platt
//
//  Created by Jaden Nation on 5/21/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class StaticListTableView<DSourceType: StaticListTableViewDataSource>: DJView.DJTableView {
    var staticListDataSource: DSourceType? {
        didSet {
            dataSource = staticListDataSource
        }
    }
    
    
    override func setup() {
        staticListDataSource = DSourceType(tableView: self)
        for cellId in staticListDataSource!.cellIdsInOrder {
            register(cellId.self, forCellReuseIdentifier: staticListDataSource!.typeName(type: cellId))
        }
    }
}
