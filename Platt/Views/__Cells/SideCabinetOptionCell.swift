//
//  SideCabinetOptionCell.swift
//  Platt
//
//  Created by Jaden Nation on 5/13/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class SideCabinetOptionCell: DJView.DJTableViewCell {
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .openedSideCabinetController, object: nil)
        NotificationCenter.default.removeObserver(self, name: .closedSideCabinetController, object: nil)
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
    
    private func buildCell() {
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .openingSideCabinetController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .openedSideCabinetController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changedSideCabinetOpen), name: .closedSideCabinetController, object: nil)
        
        
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.sfProDisplayBold(size: 32)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
        titleLabel.transform = CGAffineTransform(translationX: -24, y: 0)
        
        contentView.addConstraints([
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCell()
    }
    
}
