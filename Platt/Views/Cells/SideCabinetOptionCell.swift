//
//  SideCabinetOptionCell.swift
//  Platt
//
//  Created by Jaden Nation on 5/13/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class SideCabinetOptionCell: ModernView.ModernTableViewCell {
    private var shellView = UIView()
    private var icon: UIImageView = UIImageView()
    private var titleLabel = UILabel()
    private var optionData: SideCabinetOption?
    private var position: Int = 0
    
    public func loadData(optionData: SideCabinetOption, position: Int) {
        self.optionData = optionData
        titleLabel.text = optionData.rawValue
        self.position = position
    }
    
    @objc func changedSideCabinetOpen(sender: Notification) {
        switch sender.name {
        case .openingSideCabinetController:
            UIView.animate(withDuration: 0.24 + (Double(position) * 0.12), delay: 0, options: [.curveEaseInOut], animations: {
                self.titleLabel.transform = .identity
            }, completion: nil)
        default: break
        }
    }
    
    override func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .openingSideCabinetController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .openedSideCabinetController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .closedSideCabinetController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .closingSideCabinetController, object: nil)
        
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.sfProTextBold(size: 32)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
//        titleLabel.transform = CGAffineTransform(translationX: -24, y: 0)
    
    }
    
    override func addConstraints() {
        contentView.addConstraints([
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
    }
    
}
