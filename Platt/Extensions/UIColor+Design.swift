//
//  UIColor+Design.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hexString)
        var hexInt: UInt32 = 0
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        self.init(
            red: CGFloat((hexInt & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexInt & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexInt & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    class func darkPurple() -> UIColor { return UIColor(hexString: "#2F195F") }
    class func brightRed() -> UIColor { return UIColor(hexString: "#DB5461") }
    
    class func limeGreen() -> UIColor { return UIColor(hexString: "#AAFF4E") }
    class func fadedOrange() -> UIColor { return UIColor(hexString: "#FF7F4E") }
    class func skyBlue() -> UIColor { return UIColor(hexString: "#4EC6FF") }
    class func goldenYellow() -> UIColor { return UIColor(hexString: "#FFF94B") }
    
    class func lightPurple() -> UIColor { return UIColor(hexString: "#9877B5") }
    class func bgroundGray() -> UIColor { return UIColor(hexString: "#F7F7F7") }
    
    class func spotifyGray() -> UIColor { return UIColor(hexString: "#1F2124") }
    class func spotifyDarkGray() -> UIColor { return UIColor(hexString: "#121212") }
    class func lighterBgroundGray() -> UIColor { return UIColor(hexString: "#4B4F57") }
    class func spotifyGreen() -> UIColor { return UIColor(hexString: "#55B761") }
    class func spotifyMud() -> UIColor { return UIColor(hexString: "#2F2F2F") }
   
}
