//
//  Plate.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class Plate: NSObject {
    static let defaultPlates = [  // TMP!
        Plate(color: .brightRed(), unitWeight: 2.5),
        Plate(color: .limeGreen(), unitWeight: 5),
        Plate(color: .fadedOrange(), unitWeight: 10),
        Plate(color: .skyBlue(), unitWeight: 25),
        Plate(color: .goldenYellow(), unitWeight: 45),
    ]
    
    var color: UIColor = UIColor.lightGray
    var unitWeight: Double = 0
    convenience init(color: UIColor, unitWeight: Double) {
        self.init()
        self.color = color
        self.unitWeight = unitWeight
    }
}
