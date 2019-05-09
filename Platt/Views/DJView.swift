//
//  DJView.swift
//  Platt
//
//  Created by Jaden Nation on 5/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class DJView: UIView {

    open func addConstraints() {
        
    }
    
    open func setup() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        addConstraints()
    }

}
