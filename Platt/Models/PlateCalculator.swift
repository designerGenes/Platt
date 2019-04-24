//
//  SessionConfig.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit



enum CalculatorConfigOption {
    case multiplier, measurementSystem
}

protocol PlateCalculatorDelegate: class {
    func didUpdateSum(sum: Double, in calculator: PlateCalculator)
    func didUpdateConfigOption(option: CalculatorConfigOption, in calculator: PlateCalculator)
}

class PlateCalculator: NSObject {
    var plates = [Plate]() {
        didSet {
            delegate?.didUpdateSum(sum: sum(), in: self)
        }
    }
    private var configOptions = [CalculatorConfigOption: Any]()
    weak var delegate: PlateCalculatorDelegate?
    
    func setConfigOption(option: CalculatorConfigOption, val: Any) {
        configOptions[option] = val
        delegate?.didUpdateConfigOption(option: option, in: self)
    }
    
    func getConfigOption(option: CalculatorConfigOption) -> Any {
        switch option {
        case .multiplier: return multiplier
        case .measurementSystem: return measurementSystem
        default: return configOptions[option]
        }
    }
    
    var measurementSystem: MeasurementSystem {
        return configOptions[.measurementSystem] as? MeasurementSystem ?? .english
    }
    
    var multiplier: Int {
        return configOptions[.multiplier] as? Int ?? 1
    }
    
    func clear() {
        plates.removeAll()
        delegate?.didUpdateSum(sum: sum(), in: self)
    }
    
    func remove(plate: Plate) {
        let plateCount = plates.count
        plates = plates.filter({$0 != plate})
        if plates.count != plateCount {
            delegate?.didUpdateSum(sum: sum(), in: self)
        }
        
    }
    
    func sum() -> Double {
        return plates.map({ MeasurementSystem.convert(val: $0.unitWeight, to: measurementSystem)}).reduce(0, +)
    }
    
    func add(plate: Plate) {
        plates.append(plate)
    }
    
    func replacePlates(with plates: [Plate]) {
        self.plates = plates
    }
}
