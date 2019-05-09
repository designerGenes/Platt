//
//  BarVisualizerTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 5/8/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class BarVisualizerView: RoundedCornersView, UIScrollViewDelegate {
    let scrollViewContainer = RoundedCornersView()
    let scrollView = UIScrollView()
    let barView = RoundedCornersView()
    let exaggScrollBar = UIView()
    var barWidthConstraint: NSLayoutConstraint?
    
    private var plates = [RoundedCornersView: CGFloat]()  // plate : xPos
    private let xSpacing: CGFloat = 20
    
    private func slidePlate(plate: Plate, xPos: CGFloat) {
        
    }
    
    func loadPlates(plates: [Plate]) {
        for plate in plates {
            let farthestX = self.plates.values.sorted().last ?? scrollViewContainer.bounds.midX
            let plateView = RoundedCornersView()
            plateView.cornerRadius = 6
            plateView.backgroundColor = plate.color
            scrollView.layer.masksToBounds = false
            scrollView.addSubview(plateView)
            
            plateView.frame.size = CGSize(width: 20, height: 40)
            plateView.center = CGPoint(x: farthestX + xSpacing, y: scrollView.bounds.midY)
            self.plates[plateView] = plateView.frame.origin.x
            
        }
    }
    
    func removePlates(plates: Plate...) {
        
    }
    
    private func getContentWidth() -> CGFloat {
        return getBarWidth() + scrollViewContainer.layoutMargins.left + scrollViewContainer.layoutMargins.right
    }
    
    private func getBarWidth() -> CGFloat {
        let minimum = scrollViewContainer.bounds.inset(by: scrollViewContainer.layoutMargins).width
        let computedWidth = (minimum / 2) + getPlatesWidth()
        return max(minimum, computedWidth)
    }
    
    private func getPlatesWidth() -> CGFloat {
        return plates.keys.map({$0.frame.width + xSpacing}).reduce(0, +)
    }
    
    private func layoutPlates() {
        let minX = scrollViewContainer.bounds.inset(by: scrollViewContainer.layoutMargins).width / 2
        for (k, plate) in plates.keys.enumerated() {
            let computedX = minX + (CGFloat(k) * (20 + xSpacing))
            plate.center = CGPoint(x: computedX, y: barView.frame.midY)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        barView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        barView.frame.origin = CGPoint(x: scrollView.layoutMargins.left, y: scrollView.bounds.maxY)
        
        barView.frame.size = CGSize(width: getBarWidth(), height: 20)
        scrollView.contentSize = CGSize(width: getContentWidth(), height: barView.frame.height)
        layoutPlates()
    }
    
    override func setup() {
        addSubview(scrollViewContainer)
        scrollViewContainer.backgroundColor = .lighterBgroundGray()
        backgroundColor = .spotifyMud()
        scrollViewContainer.cornerRadius = 8
        cornerRadius = 8
        scrollView.delegate = self
        barView.backgroundColor = .spotifyGray()
        barView.cornerRadius = 4
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollViewContainer.addSubview(scrollView)
        scrollView.addSubview(barView)
        
        
        loadPlates(plates: [
            Plate(color: .spotifyGreen(), unitWeight: 1),
            Plate(color: .skyBlue(), unitWeight: 1),
            Plate(color: .goldenYellow(), unitWeight: 1),
            Plate(color: .skyBlue(), unitWeight: 1),
            Plate(color: .brightRed(), unitWeight: 1),
            Plate(color: .goldenYellow(), unitWeight: 1),
            Plate(color: .goldenYellow(), unitWeight: 1),
            Plate(color: .spotifyGreen(), unitWeight: 1),
            Plate(color: .skyBlue(), unitWeight: 1),
            ])
        
    }
    
    override func addConstraints() {
        scrollViewContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints([
            scrollViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: topAnchor),
            scrollViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            scrollView.centerYAnchor.constraint(equalTo: scrollViewContainer.centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: scrollViewContainer.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: barView.heightAnchor),

//
            ])
//
//        barWidthConstraint = barView.widthAnchor.constraint(equalToConstant: 50)
//        barWidthConstraint?.isActive = true
    }
    
    // MARK: - UIScrollViewDelegate methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //
    }
    
}


class BarVisualizerTableViewCell: CalculatorTableCell {
    var barView = BarVisualizerView()
    
    override func setup() {
        super.setup()
        coverSelfEntirely(with: barView)
    }
    
    

}
