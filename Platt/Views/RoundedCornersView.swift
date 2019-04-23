//
//  RoundedCornersView.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class RoundedCornersView: UIView {
    var cornerRadius: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.cornerRadius
        layer.masksToBounds = true
    }
}
