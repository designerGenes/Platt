//
//  DrawerButtonView.swift
//  Platt
//
//  Created by Jaden Nation on 5/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class DrawerButtonView: RoundedCornersView {
    private let iconView = UIImageView()
    
    func load(drawerButtonData: DrawerButtonType, calculator: PlateCalculator) {
        if !subviews.contains(iconView) {
            coverSelfEntirely(with: iconView)
            iconView.contentMode = .center
            backgroundColor = .lighterBgroundGray()
            cornerRadius = 6
        }
        
        let assetName: NamedAsset
        switch drawerButtonData {
        case .clear:
            assetName = .letterC
        case .toggleMeasurementSystem:
            assetName = [MeasurementSystem.metric: NamedAsset.kg, .english: .lb][calculator.measurementSystem]!
            
        case .toggleMultiplier:
            assetName = calculator.multiplier < 2 ? .halfBar : .fullBar
        }
        iconView.image = UIImage.fromAsset(assetName)
    }
}
