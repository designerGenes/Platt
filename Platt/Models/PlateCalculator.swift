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

enum CalculatorProperty: String {
    case sum, plates, configOptions
}

extension Notification.Name {
    static let calculatorUpdatedSum = Notification.Name("calculatorUpdatedSum")
    static let calculatorUpdatedConfigOption = Notification.Name("calculatorUpdatedConfigOption")
}

class PlateCalculator: NSObject {
    static let activeInstance: PlateCalculator = PlateCalculator()
    var plates = [Plate]() {
        didSet {
            updateListeners(name: .calculatorUpdatedSum)
        }
    }
    private var configOptions = [CalculatorConfigOption: Any]()

    func updateListeners(name: Notification.Name) {
        var userInfo = [String: Any]()
        switch name {
        case .calculatorUpdatedSum:
            userInfo = [
                CalculatorProperty.sum.rawValue: sum(),
                CalculatorProperty.plates.rawValue: plates
            ]
        case .calculatorUpdatedConfigOption:
            userInfo = [
                CalculatorProperty.configOptions.rawValue: configOptions
            ]
        default: break
        }
        NotificationCenter.default.post(name: name, object: nil, userInfo: userInfo)
    }
    
    func setConfigOption(option: CalculatorConfigOption, val: Any) {
        configOptions[option] = val
        updateListeners(name: .calculatorUpdatedConfigOption)
    }
    
    func getConfigOption(option: CalculatorConfigOption) -> Any {
        switch option {
        case .multiplier: return multiplier
        case .measurementSystem: return measurementSystem
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
        updateListeners(name: .calculatorUpdatedSum)
    }
    
    func remove(plate: Plate) {
        plates = plates.filter({$0 != plate})
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
