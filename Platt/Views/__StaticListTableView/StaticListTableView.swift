//
//  StaticListTableView.swift
//  Platt
//
//  Created by Jaden Nation on 5/21/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class StaticListTableView<DS: StaticListTableViewDataSource>: ModernView.ModernTableView {
    var staticListDataSource: DS? {
        didSet {
            dataSource = staticListDataSource
        }
    }
    
    override func setup() {
        super.setup()
        
        staticListDataSource = DS(tableView: self)
        delegate = staticListDataSource
        separatorStyle = .none
        for cellId in staticListDataSource!.cellTypesInOrder {
            register(cellId.self, forCellReuseIdentifier: staticListDataSource!.typeName(type: cellId))
        }
    }
}
