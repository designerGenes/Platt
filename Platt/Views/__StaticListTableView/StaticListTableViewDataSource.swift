//
//  StaticListTableViewDataSource.swift
//  Platt
//
//  Created by Jaden Nation on 5/21/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

protocol TableViewSizingDelegate: class {
    func heightForHeader(at section: Int) -> CGFloat
    func heightForFooter(at section: Int) -> CGFloat
    func heightForRow(at indexPath: IndexPath) -> CGFloat
}

class StaticListTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var cellRefs = [String: DJView.DJTableViewCell]()  // live instances
    private weak var tableView: StaticListTableView<StaticListTableViewDataSource>?
    weak var delegate: TableViewSizingDelegate?
    var cellIdsInOrder: [DJView.DJTableViewCell.Type] {
        return []
    }
    
    func typeName(type: AnyClass) -> String {
        return String(describing: type.self)
    }
    
    required init<T: StaticListTableViewDataSource>(tableView: StaticListTableView<T>) {
        super.init()
        self.tableView = tableView as? StaticListTableView<StaticListTableViewDataSource>
    }
    
    subscript(type: DJView.DJTableViewCell.Type) -> DJView.DJTableViewCell? {
        return cellRefs[typeName(type: type)]
    }
    
    open func loadDataIntoCell(cell: DJView.DJTableViewCell, at indexPath: IndexPath) {
        // override this
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellIdsInOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = typeName(type: cellIdsInOrder[indexPath.section])
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! DJView.DJTableViewCell
        loadDataIntoCell(cell: cell, at: indexPath)
        cellRefs[reuseId] = cell
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.heightForRow(at: indexPath) ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.heightForHeader(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate?.heightForFooter(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
