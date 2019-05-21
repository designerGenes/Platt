//
//  StaticListTableView.swift
//  Platt
//
//  Created by Jaden Nation on 5/21/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

// PlateCollectionTableViewCell, BarVisualizerTableViewCell, PlateSumTableViewCell, ButtonDrawerTableViewCell

public enum StaticCellId: String {
    case unnamed
    
}

class StaticTableViewCell: UITableViewCell {
    var id: StaticCellId = .unnamed

}

class StaticListTableViewDataSource: NSObject, UITableViewDataSource {
    var cellRefs = [StaticCellId: StaticTableViewCell]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func cellIdsInOrder() -> [StaticCellId] {
        return [.unnamed]  // override this
    }

}

class StaticListTableView<D: StaticListTableViewDataSource>: DJView.DJTableView {
    var staticListDataSource: D? {
        didSet {
            dataSource = staticListDataSource
        }
    }
    
    override func setup() {
        super.setup()
        if let dataSource = staticListDataSource {
            for cellType in dataSource.cellIdsInOrder() {
                
                register(cellType.self, forCellReuseIdentifier: cellType.rawValue)
            }
        }
        
    }
}
