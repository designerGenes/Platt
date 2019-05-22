//
//  PlateView.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateView: ModernView {
    var unitWeightLabel = UILabel()
    var plate: Plate? {
        didSet {
            guard let plate = plate else {
                return
            }
            backgroundColor = plate.color
            
            let unitWeight = MeasurementSystem.convert(plate: plate, to: plate.measurementSystem)
            var unitStr = "\(unitWeight)"
            if Double(Int(unitWeight)) == unitWeight {
                unitStr = "\(Int(unitWeight))"
            }
            
            
            unitWeightLabel.text = "\(unitStr)"
        }
    }
    
    override func setup() {
        addSubview(unitWeightLabel)
        unitWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            unitWeightLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            unitWeightLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            unitWeightLabel.widthAnchor.constraint(equalTo: layoutMarginsGuide.widthAnchor),
            unitWeightLabel.heightAnchor.constraint(equalTo: layoutMarginsGuide.heightAnchor),
            ])
        unitWeightLabel.font = .sfProTextBold(size: 34)
        unitWeightLabel.adjustsFontSizeToFitWidth = true
        unitWeightLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.height / 6
    }
}
