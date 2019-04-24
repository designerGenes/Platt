//
//  Enums.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation

enum MeasurementSystem {
    case english, metric
    func suffix() -> String {
        switch self {
        case .english: return "lb"
        case .metric : return "kg"
        }
    }
    
    static func convert(plate: Plate, to system: MeasurementSystem) -> Double {
        guard plate.measurementSystem != system else {
            return plate.unitWeight
        }
        return convert(val: plate.unitWeight, to: system)
    }
    
    static func convert(val: Double, to system: MeasurementSystem) -> Double {
        switch system {
        case .english: return ((val * 2.2046) * 100).rounded() / 100
        case .metric: return ((val * 0.4535923) * 100).rounded() / 100
        }
    }
}
