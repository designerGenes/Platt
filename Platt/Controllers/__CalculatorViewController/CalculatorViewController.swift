//
//  CalculatorViewControllerViewController.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class CalculatorViewController: ModernViewController, TableViewSizingDelegate {
    private let tableView = StaticListTableView<CalculatorTableDataSource>()
    
    // MARK: - StaticListTableViewDelegate methods
    func heightForFooter(at section: Int) -> CGFloat {
        return 0
    }
    
    func heightForHeader(at section: Int) -> CGFloat {
        return section < 1 ? 32 : 16
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        switch tableView.staticListDataSource!.cellTypesInOrder[indexPath.section] {
        case is BarVisualizerTableViewCell.Type: return 120
        default: return UITableView.automaticDimension
        }
    }
    
    override func addConstraints() {
        view.coverSelfEntirely(with: tableView, obeyMargins: false)
    }
    
    override func onLoadSetup() {
        view.layoutMargins = .zero
        tableView.backgroundColor = .spotifyGray()
        tableView.staticListDataSource?.sizingDelegate = self
        
    }
    
}

