//
//  PlateSumTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateSumTableViewCell: ModernView.ModernTableViewCell {
    private var lblSum = InsetLabel(textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32))
    
    @objc func reflectSum(notification: Notification) {
        reflectSum(sum: notification.userInfo?["obj"] as? Double ?? 0)
    }
    
    func reflectSum(sum: Double) {
        var sumStr = String(sum)
        if Double(Int(sum)) == sum {
            sumStr = String(Int(sum))
        }
        let mSystemSuffix = "\(PlateCalculator.activeInstance.measurementSystem.suffix().uppercased())\(sum > 1 ? "s" : "")"
        lblSum.text = "\(sumStr)  \(mSystemSuffix)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblSum.layer.cornerRadius = 10 //lblSum.frame.height / 2
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .calculatorUpdatedSum, object: nil)
    }
    
    override func setup() {
        super.setup()
        backgroundColor = .clear
        contentView.coverSelfEntirely(with: lblSum, obeyMargins: true)
        lblSum.heightAnchor.constraint(equalToConstant: 88).isActive = true
        lblSum.backgroundColor = .white
        lblSum.font = .boldSystemFont(ofSize: 40)
        lblSum.textAlignment = .right
        lblSum.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        lblSum.layer.masksToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(reflectSum(notification:)), name: .calculatorUpdatedSum, object: nil)
        
    }

}
