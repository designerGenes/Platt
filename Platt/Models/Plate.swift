//
//  Plate.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

enum PlateSize: String {
    case large, medium, small, verySmall
}

class Plate: NSObject {
//    var id = UUID.init().uuidString
    var size: PlateSize = .medium
    var color: UIColor = UIColor.lightGray
    var unitWeight: Double = 0
    var measurementSystem: MeasurementSystem = .english
    
    init(plate: Plate) {
        self.size = plate.size
        self.color = plate.color
        self.unitWeight = plate.unitWeight
        self.measurementSystem = plate.measurementSystem
    }
    
    override var description: String {
        return "\(size.rawValue) Plate w/unit weight \(unitWeight)"
    }

    
    init(color: UIColor, size: PlateSize = .medium, measurementSystem: MeasurementSystem = .english, unitWeight: Double) {
        super.init()
        self.color = color
        self.unitWeight = unitWeight
        self.measurementSystem = measurementSystem
        self.size = size
    }
}
