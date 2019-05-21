//
//  CalculatorViewControllerViewController.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class CalculatorViewController: BaseViewController, UITableViewDelegate {
    private let tableView = UITableView()
    private var dataSource: CalculatorTableDataSource!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = CalculatorTableDataSource(tableView: tableView)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.coverSelfEntirely(with: tableView, obeyMargins: false) 
        
        tableView.backgroundColor = .clear        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(PlateCollectionTableViewCell.self, forCellReuseIdentifier:  CalculatorTableDataSource.CalculatorTableCellId.PlateCollectionTableViewCell.rawValue)
        tableView.register(BarVisualizerTableViewCell.self, forCellReuseIdentifier: CalculatorTableDataSource.CalculatorTableCellId.BarVisualizerTableViewCell.rawValue)
        tableView.register(PlateSumTableViewCell.self, forCellReuseIdentifier: CalculatorTableDataSource.CalculatorTableCellId.PlateSumTableViewCell.rawValue)
        tableView.register(ButtonDrawerTableViewCell.self, forCellReuseIdentifier: CalculatorTableDataSource.CalculatorTableCellId.ButtonDrawerTableViewCell.rawValue)
    }

    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellId = CalculatorTableDataSource.CalculatorTableCellId.inOrder()[indexPath.section]
        switch cellId {
        case .BarVisualizerTableViewCell:
            return dataSource[cellId]?.intrinsicContentSize.height ?? 120
        default: return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

}

