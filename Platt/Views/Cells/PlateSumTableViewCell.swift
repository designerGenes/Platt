//
//  PlateSumTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateSumTableViewCell: CalculatorTableCell, PlateAdditionSequenceCellDelegate {
    private var lblSum = InsetLabel(textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32))
    
    // MARK: - PlateAdditionSequenceCellDelegate methods
    func didChangeSum(sum: Double, in cell: PlateAdditionSequenceTableViewCell) {
        SessionConfig.activeConfig().sum = sum
        reflectSum()
    }
    
    func reflectSum() {
        let sum = SessionConfig.activeConfig().sum
        var sumStr = String(sum)
        if Double(Int(sum)) == sum {
            // !has remainder
            sumStr = String(Int(sum))
        }
        let measSystem = SessionConfig.activeConfig().configOptions[.measurementSystem] as! MeasurementSystem
        lblSum.text = "\(sumStr)\(measSystem.suffix().uppercased())\(sum > 1 ? "s" : "")"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lblSum.layer.cornerRadius = 10 //lblSum.frame.height / 2
    }
    
    override func setup() {
        super.setup()
        backgroundColor = .clear
        contentView.coverSelfEntirely(with: lblSum, obeyMargins: true)
        lblSum.heightAnchor.constraint(equalToConstant: 34).isActive = true
        lblSum.backgroundColor = .white
        lblSum.font = .boldSystemFont(ofSize: 40)
        lblSum.textAlignment = .right
        lblSum.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        lblSum.layer.masksToBounds = true
        
        reflectSum()
        
    }

}
