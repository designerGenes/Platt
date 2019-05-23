//
//  InsetLabel.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

class InsetTextField: ModernView.ModernTextField {
    var textInsets: UIEdgeInsets = UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)
    
    override func drawText(in rect: CGRect) {
        let insetArr = [textInsets.top, textInsets.left, textInsets.bottom, textInsets.right, ].map({max(0, $0)})
        let insets = UIEdgeInsets(top: insetArr[0], left: insetArr[1], bottom: insetArr[2], right: insetArr[3])
        super.drawText(in: rect.inset(by: insets))
    }
    
    convenience init(textInsets: UIEdgeInsets) {
        self.init()
        self.textInsets = textInsets
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += textInsets.top + textInsets.bottom
        intrinsicSuperViewContentSize.width += textInsets.left + textInsets.right
        return intrinsicSuperViewContentSize
    }
}

class InsetLabel: UILabel {
    var textInsets: UIEdgeInsets = UIEdgeInsets(top: -1, left: -1, bottom: -1, right: -1)
    
    override func drawText(in rect: CGRect) {
        let insetArr = [textInsets.top, textInsets.left, textInsets.bottom, textInsets.right, ].map({max(0, $0)})
        let insets = UIEdgeInsets(top: insetArr[0], left: insetArr[1], bottom: insetArr[2], right: insetArr[3])
        super.drawText(in: rect.inset(by: insets))
    }
    
    convenience init(textInsets: UIEdgeInsets) {
        self.init()
        self.textInsets = textInsets
    }
    
    override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += textInsets.top + textInsets.bottom
        intrinsicSuperViewContentSize.width += textInsets.left + textInsets.right
        return intrinsicSuperViewContentSize
    }
}
