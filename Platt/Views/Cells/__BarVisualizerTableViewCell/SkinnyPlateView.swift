//
//  SkinnyPlateView.swift
//  Platt
//
//  Created by Jaden Nation on 5/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

import UIKit

enum Direction: String {
    case left, right
}

enum Corner: String {
    case tl, tr, bl, br
}

func randomInt(high: Int, low: Int = 0) -> Int {
    return low + Int(arc4random_uniform(UInt32(high - low)))
}

public struct OffsetRect {
    var tl: CGPoint
    var tr: CGPoint
    var bl: CGPoint
    var br: CGPoint
    
    func appliedTo(rect: CGRect, usePercentages: Bool = false) -> CGPath {
        let start = CGPoint(x: rect.minX + tl.x, y: rect.minY + tl.y)
        let path = UIBezierPath()
        path.lineWidth = 4
        path.move(to: start)
        let trX = usePercentages ? tr.x * rect.width : tr.x
        let trY = usePercentages ? tr.y * rect.height : tr.y
        let brX = usePercentages ? br.x * rect.width : br.x
        let brY = usePercentages ? br.y * rect.height : br.y
        let blX = usePercentages ? bl.x * rect.width : bl.x
        let blY = usePercentages ? bl.y * rect.height : bl.y
        path.addLine(to: CGPoint(x: rect.maxX + trX, y: rect.minY + trY))
        path.addLine(to: CGPoint(x: rect.maxX + brX, y: rect.maxY + brY))
        path.addLine(to: CGPoint(x: rect.minX + blX, y: rect.maxY + blY))
        path.close()
        
        return path.cgPath
    }
}

class SkinnyPlateView: UIView {
    private var offsetRect: OffsetRect?
    var usePercentages: Bool = false
    private var fillLayer: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fillLayer?.path = offsetRect?.appliedTo(rect: bounds, usePercentages: usePercentages)
        fillLayer?.cornerRadius = 5
    }
    
    static func facing(direction: Direction, plate: Plate, topInset: CGFloat, bottomLoss: CGFloat, usePercentages: Bool) -> SkinnyPlateView {
        let tl = CGPoint(x: 0, y: direction == .left ? topInset : 0)
        let tr = CGPoint(x: 0, y: direction == .right ? topInset : 0)
        let bl = CGPoint(x: 0, y: direction == .left ? -bottomLoss : 0)
        let br = CGPoint(x: 0, y: direction == .right ? -bottomLoss : 0)
        return SkinnyPlateView(from: OffsetRect(tl: tl, tr: tr, bl: bl, br: br), color: plate.color, usePercentages: usePercentages)
        
    }
    
    
    convenience init(from offsetRect: OffsetRect, color: UIColor, usePercentages: Bool) {
        self.init()
        self.offsetRect = offsetRect
        self.usePercentages = usePercentages
        let fillLayer = CAShapeLayer()
        self.fillLayer = fillLayer
        fillLayer.fillColor = color.cgColor
        layer.addSublayer(fillLayer)
        
    }
}
