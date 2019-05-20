//
//  PlatesLibrary.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class PlatesLibrary: NSObject {
    static func defaultPlates(measurementSystem: MeasurementSystem) -> [Plate] {
        let plates = [  // TMP!
            Plate(color: .brightRed(), size: .verySmall, unitWeight: 2.5),
            Plate(color: .limeGreen(), size: .small, unitWeight: 5),
            Plate(color: .fadedOrange(), size: .small, unitWeight: 10),
            Plate(color: .skyBlue(), size: .medium, unitWeight: 25),
            Plate(color: .spotifyGreen(), size: .medium, unitWeight: 35),
            Plate(color: .goldenYellow(), size: .large, unitWeight: 45),
        ]
        if measurementSystem == .metric {
            plates.forEach { (plate) in
                plate.unitWeight = MeasurementSystem.convert(plate: plate, to: .metric)
            }
        }
        return plates
    }    
    
}
