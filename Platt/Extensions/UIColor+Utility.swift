//
//  UIColor+Utility.swift
//  Platt
//
//  Created by Jaden Nation on 5/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

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
    
    func getBrightness() -> CGFloat {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        let _ = getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return b
    }
    
    func lightened(by percentage: CGFloat) -> UIColor {
        return withAdjustedBrightness(by: abs(percentage))
    }
    
    func darkened(by percentage: CGFloat) -> UIColor {
        return withAdjustedBrightness(by: -(abs(percentage)))
    }
    
    func withBrightness(brightness: CGFloat) -> UIColor {
        let curBrightness = getBrightness()
        guard curBrightness != brightness else {
            return self
        }
        let pct = abs(brightness / curBrightness)
        return withAdjustedBrightness(by: pct)
    }
    
    func withAdjustedBrightness(by percentage: CGFloat) -> UIColor {
        let percentage = percentage > 1 ? percentage : percentage * 100
        
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                let newB: CGFloat = max(min(b + (percentage/100.0)*b, 1.0), 0.0)
                return UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
            } else {
                let newS: CGFloat = min(max(s - (percentage/100.0)*s, 0.0), 1.0)
                return UIColor(hue: h, saturation: newS, brightness: b, alpha: a)
            }
        }
        return self
    }
}
