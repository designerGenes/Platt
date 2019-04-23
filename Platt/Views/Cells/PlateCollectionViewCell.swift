//
//  PlateCollectionViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateCollectionViewCell: UICollectionViewCell {
    private var plateView = PlateView()
    private var plateWidthConstraint: NSLayoutConstraint?
    
    func loadPlate(plate: Plate, position: Int) {
        plateView.plate = plate
        let percentSize = min(1, Double(position) / Double(Plate.defaultPlates.count))
        let inset = ((40 * CGFloat(1 - percentSize)) / 2)
        contentView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    
    func setup() {
        contentView.addSubview(plateView)
        contentView.backgroundColor = .clear
        plateView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            plateView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            plateView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            plateView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            plateView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            plateView.heightAnchor.constraint(equalTo: plateView.widthAnchor),
            ])
        
        plateWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: 100)
        plateWidthConstraint?.isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
