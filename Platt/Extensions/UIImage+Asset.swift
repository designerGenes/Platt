//
//  UIImage+Asset.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

enum NamedAsset: String {
    case letterC, fullBar, halfBar
    case lb, kg
}

extension UIImage {
    static func fromAsset(_ asset: NamedAsset) -> UIImage {
        return UIImage(named: asset.rawValue)!  // crash if asset name mismatch happens
    }
}
