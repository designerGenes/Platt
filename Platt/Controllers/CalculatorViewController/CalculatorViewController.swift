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
        view.layoutMargins = UIEdgeInsets(top: 48, left: 0, bottom: 16, right: 0)
        view.coverSelfEntirely(with: tableView, obeyMargins: false)
        
        tableView.backgroundColor = .clear        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(PlateCollectionTableViewCell.self, forCellReuseIdentifier: "PlateCollectionTableViewCell")
        tableView.register(PlateAdditionSequenceTableViewCell.self, forCellReuseIdentifier: "PlateAdditionSequenceTableViewCell")
        tableView.register(PlateSumTableViewCell.self, forCellReuseIdentifier: "PlateSumTableViewCell")
        tableView.register(ButtonDrawerTableViewCell.self, forCellReuseIdentifier: "ButtonDrawerTableViewCell")
        
        
    }

    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140 //UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

}

