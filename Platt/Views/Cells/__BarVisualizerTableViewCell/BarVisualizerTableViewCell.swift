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
    let exaggScrollBar = RoundedCornersView()
    private var plates = [(plateView: SkinnyPlateView, plate: Plate)]()
    private var platesMap: [Plate: SkinnyPlateView] {
        var out = [Plate: SkinnyPlateView]()
        plates.forEach { (arg) in
            out[arg.plate] = arg.plateView
        }
        return out
    }
    
    private let xSpacing: CGFloat = 20

    @objc func clickedLoadedPlate(sender: UITapGestureRecognizer) {
        let cellSuper = superview as! BarVisualizerTableViewCell
        let senderPlateView = sender.view as! SkinnyPlateView
        let senderPlate = plates.filter({$0.plateView == senderPlateView}).first!.plate
        cellSuper.delegate?.didSelectPlate(plate: senderPlate, sender: cellSuper)
        
//        removePlates(plateViews: )
    }
    
    private func slidePlate(plate: Plate, xPos: CGFloat) {
        
    }
    
    func clearPlates() {
        removePlates(plateViews: plates.map({$0.plateView}))
    }
    
    func removePlates(plateViews: [SkinnyPlateView]) {
        plates.removeAll { (plateView, _) -> Bool in
            plateViews.contains(plateView)
        }
        plateViews.forEach { (plateView) in
            plateView.removeFromSuperview()
        }
        layoutSubviews()
    }
    
    func loadPlates(plates: [Plate]) {
//        if plates.isEmpty {
            clearPlates()
//        }
        for plate in plates { //plates.filter({!platesMap.keys.contains($0)}) {
            
            let plateView = SkinnyPlateView.facing(direction: .right, plate: plate, topInset: 0.3, bottomLoss: 0.3, usePercentages: true)
            self.plates.append((plateView, plate))
            scrollView.layer.masksToBounds = false
            scrollView.addSubview(plateView)
            plateView.frame.size = CGSize(width: 20, height: 40)
            plateView.center = CGPoint(x: scrollViewContainer.bounds.midX, y: scrollView.bounds.midY)
            
            plateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickedLoadedPlate(sender:))))
        }
        let doomedPlates = platesMap.keys.filter({!plates.contains($0)})
        self.plates.removeAll { (_, plate) -> Bool in
            // remove any not included in the new platesList
            return doomedPlates.contains(plate)
        }
        
        layoutSubviews()
    }
    
    
    
    private func getContentWidth() -> CGFloat {
        return getBarWidth() + scrollViewContainer.layoutMargins.left + scrollViewContainer.layoutMargins.right
    }
    
    private func getBarWidth() -> CGFloat {
        let minimum = scrollViewContainer.bounds.inset(by: scrollViewContainer.layoutMargins).width  - (scrollViewContainer.layoutMargins.right * 2)
        let computedWidth = (minimum / 2) + getPlatesWidth()
        return max(minimum, computedWidth)
    }
    
    private func getPlatesWidth() -> CGFloat {
        return plates.map({$0.plateView.frame.width + xSpacing}).reduce(0, +)
    }
    
    private func layoutPlates() {
        let minX = scrollViewContainer.bounds.inset(by: scrollViewContainer.layoutMargins).width / 2
        for (k, plateTuple) in plates.enumerated() {
            let sizes = [PlateSize.verySmall: 0.5, .small: 0.7, .medium: 0.8, .large: 1]
            let computedHeight = (scrollViewContainer.frame.height * 0.9) * CGFloat(sizes[plateTuple.plate.size]!)
            plateTuple.plateView.frame.size = CGSize(width: 16, height: computedHeight)
            layoutIfNeeded()
            let computedX = minX + (CGFloat(k) * (plateTuple.plateView.frame.width + xSpacing))
            plateTuple.plateView.center = CGPoint(x: computedX, y: scrollView.bounds.midY)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        barView.frame.origin = CGPoint(x: scrollView.layoutMargins.left, y: scrollView.bounds.minY)
        
        barView.frame.size = CGSize(width: getBarWidth(), height: 20)
        scrollView.contentSize = CGSize(width: getContentWidth(), height: barView.frame.height)
        layoutPlates()
        let computedX = scrollView.contentSize.width - scrollView.bounds.size.width + (scrollViewContainer.layoutMargins.right * 2)
        scrollView.setContentOffset(CGPoint(x: computedX, y: scrollView.contentOffset.y), animated: false)
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
    var barVisualizeView = BarVisualizerView()
    weak var delegate: PlateCollectionDelegate?
    
    // MARK: - PlateCollectionTableViewCellDelegate methods
    func didSelectPlate(plate: Plate, in cell: PlateCollectionTableViewCell) {
        barVisualizeView.loadPlates(plates: [plate])
    }
    
    override func setup() {
        super.setup()
        coverSelfEntirely(with: barVisualizeView)
    }
    
    

}
