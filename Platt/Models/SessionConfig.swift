//
//  SessionConfig.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

// this is a temporary holder for user settings like kg/lb

enum ConfigOption {
    case multiplier, measurementSystem
//    case custom(img: UIImage)
}

protocol SessionConfigListener: class {
    func didUpdateSessionConfig(updatedConfig: SessionConfig)
}

class SessionConfig: NSObject {
    var configOptions = [ConfigOption: Any]()
    var plates = [Plate]()
    var sum: Double = 0
    
    func clear() {
        sum = 0
        plates.removeAll()
        SessionConfig.updateListeners()
    }
    
    static func updateListeners() {
        listeners.forEach { (listener) in
            listener.didUpdateSessionConfig(updatedConfig: SessionConfig.activeConfig())
        }
    }
    
    static var listeners = [SessionConfigListener]()
    private static var activeCFG: SessionConfig? {
        didSet {
            updateListeners()
        }
    }
    static func activeConfig() -> SessionConfig {
        return activeCFG ?? defaultConfig
    }
    
    static let defaultConfig = SessionConfig(configOptions: [
        .measurementSystem: MeasurementSystem.english,
        .multiplier: 1
    ])
    
    
    init(configOptions: [ConfigOption: Any]) {
        super.init()
        self.configOptions = configOptions
    }
    
    
    
    
}
