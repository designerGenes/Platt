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
    
    func toggleMeasurementSystem() {
        setConfigOption(option: .measurementSystem, val: [MeasurementSystem.english, .metric].filter({$0 != measurementSystem}).first!)
    }
    
    var measurementSystem: MeasurementSystem {
        return configOptions[.measurementSystem] as? MeasurementSystem ?? .english
    }
    
    var multiplier: Int {
        return configOptions[.multiplier] as? Int ?? 1
    }
    
    func toggleMultiplier() {
        setConfigOption(option: .multiplier, val: [1, 2].filter({$0 != multiplier}).first!)
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
        var out = plates.map({ MeasurementSystem.convert(plate: $0, to: measurementSystem)}).reduce(0, +) * Double(multiplier)
        out = (out * 100).rounded() / 100
        return out
    }
    
    func add(plate: Plate) {
        plates.append(Plate(plate: plate))
    }
    
    func replacePlates(with plates: [Plate]) {
        self.plates = plates
    }
}
