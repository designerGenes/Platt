//
//  PlateView.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateView: UIView {
    var plate: Plate? {
        didSet {
            backgroundColor = plate?.color
        }
    }
    
    override func layoutSubviews() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.height / 2
    }
}
