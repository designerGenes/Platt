//
//  PlateSumTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let submittingValueForEditing = Notification.Name("submittingValueForEditing")
    static let didSubmitUpdatedValue = Notification.Name("didSubmitUpdatedValue")
}

class PlateSumTableViewCell: ModernView.ModernTableViewCell {
    private var sumTextField = DualStateInsetTextView(textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32))
    
    @objc func reflectSum(notification: Notification) {
        reflectSum(sum: notification.userInfo?[CalculatorProperty.sum.rawValue] as? Double ?? 0)
    }
    
    func reflectSum(sum: Double) {
        var sumStr = String(sum)
        if Double(Int(sum)) == sum {
            sumStr = String(Int(sum))
        }
        let mSystemSuffix = "\(PlateCalculator.activeInstance.measurementSystem.suffix().uppercased())\(sum > 1 ? "s" : "")"
        sumTextField.text = "\(sumStr)  \(mSystemSuffix)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sumTextField.layer.cornerRadius = 10 //lblSum.frame.height / 2
    }
    
    override func setup() {
        super.setup()
        backgroundColor = .clear
        contentView.coverSelfEntirely(with: sumTextField, obeyMargins: true)
        sumTextField.heightAnchor.constraint(equalToConstant: 88).isActive = true
        sumTextField.backgroundColor = .white
        sumTextField.font = .boldSystemFont(ofSize: 40)
        sumTextField.textAlignment = .right
        sumTextField.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        sumTextField.layer.masksToBounds = true
        NotificationCenter.default.addObserver(sumTextField, selector: #selector(DualStateInsetTextView.reflectLocalValue(sender:)), name: .submittingValueForEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reflectSum(notification:)), name: .calculatorUpdatedSum, object: nil)
        
    }

}
