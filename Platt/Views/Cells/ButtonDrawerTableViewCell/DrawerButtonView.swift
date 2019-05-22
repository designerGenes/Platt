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
    private var drawerButtonType: DrawerButtonType?
    
    @objc func receivedNotification(sender: Notification) {
        guard let configOption = sender.userInfo?[CalculatorProperty.configOption.rawValue] as? CalculatorConfigOption, configOption == drawerButtonType?.getReflectingOption() else {
            return
        }
        reflectOption(configOption: configOption)
    }
    
    func reflectOption(configOption: CalculatorConfigOption) {
        let assetName: NamedAsset
        let calc = PlateCalculator.activeInstance
        
        switch configOption {
        case .measurementSystem:
            assetName = [MeasurementSystem.metric: NamedAsset.kg, .english: .lb][calc.measurementSystem]!
        case .multiplier:
            assetName = calc.multiplier < 2 ? .halfBar : .fullBar
        }
        iconView.image = UIImage.fromAsset(assetName)
    }
    
    func load(drawerButtonType: DrawerButtonType, calculator: PlateCalculator) {
        self.drawerButtonType = drawerButtonType
        
        if !subviews.contains(iconView) {
            coverSelfEntirely(with: iconView)
            iconView.contentMode = .center
            backgroundColor = .lighterBgroundGray()
            cornerRadius = 6
        }
        
        if let reflectingOption = drawerButtonType.getReflectingOption() {
            reflectOption(configOption: reflectingOption)
            NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification(sender:)), name: .calculatorUpdatedConfigOption, object: nil)
        } else if drawerButtonType == .clear {
            iconView.image = UIImage.fromAsset(.letterC)
        }
    }
}
