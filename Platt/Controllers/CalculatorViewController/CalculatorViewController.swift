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
    private let dataSource = CalculatorTableDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutMargins = UIEdgeInsets(top: 48, left: 16, bottom: 16, right: 16)
        view.coverSelfEntirely(with: tableView, obeyMargins: true)
        tableView.backgroundColor = .clear
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(PlateCollectionTableViewCell.self, forCellReuseIdentifier: "PlateCollectionTableViewCell")
        tableView.register(PlateAdditionSequenceTableViewCell.self, forCellReuseIdentifier: "PlateAdditionSequenceTableViewCell")
        tableView.register(PlateSumTableViewCell.self, forCellReuseIdentifier: "PlateSumTableViewCell")
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsTableViewCell")
    }

    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

}

