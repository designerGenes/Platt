//
//  UIView+Convenience.swift
//  RainCaster
//
//  Created by Jaden Nation on 5/5/17.
//  Copyright © 2017 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
	func setAnchorPoint(anchorPoint: CGPoint) {
		var newPoint = CGPoint(x: bounds.size.width * anchorPoint.x, y: bounds.size.height * anchorPoint.y)
		var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)
		
		newPoint = newPoint.applying(transform)
		oldPoint = oldPoint.applying(transform)
		
		var position = layer.position
		position.x -= oldPoint.x
		position.x += newPoint.x
		
		position.y -= oldPoint.y
		position.y += newPoint.y
		
		layer.position = position
		layer.anchorPoint = anchorPoint
	}
    
    func takeScreenShot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0);
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func placeSubViewAtCenter(subview: UIView, withOffset offset: CGPoint = CGPoint.zero) {
        if !subviews.contains(subview) {
            addSubview(subview)
        }
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offset.x).isActive = true
        subview.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offset.y).isActive = true
    }
	
    func coverSelfEntirely(with subview: UIView, obeyMargins: Bool = true, allowVerticalExtensionDown: Bool = false) {
        if subviews.contains(subview) {
            bringSubviewToFront(subview)
        } else {
            addSubview(subview)
        }
		subview.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            subview.leadingAnchor.constraint(equalTo: obeyMargins ? layoutMarginsGuide.leadingAnchor : leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: obeyMargins ? layoutMarginsGuide.trailingAnchor : trailingAnchor),
            subview.topAnchor.constraint(equalTo: obeyMargins ? layoutMarginsGuide.topAnchor : topAnchor),
            ])
        if allowVerticalExtensionDown {
            subview.bottomAnchor.constraint(lessThanOrEqualTo: obeyMargins ? layoutMarginsGuide.bottomAnchor : bottomAnchor).isActive = true
        } else {
            subview.bottomAnchor.constraint(equalTo: obeyMargins ? layoutMarginsGuide.bottomAnchor : bottomAnchor).isActive = true
        }
        
	}
}
