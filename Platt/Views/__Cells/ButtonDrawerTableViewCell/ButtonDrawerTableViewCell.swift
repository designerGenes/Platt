//
//  ButtonDrawerTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

enum DrawerButtonType {
    case clear, toggleMultiplier, toggleMeasurementSystem
    func getReflectingOption() -> CalculatorConfigOption? {
        switch self {
        case .toggleMultiplier: return .multiplier
        case .toggleMeasurementSystem: return .measurementSystem
        default: return nil
        }
    }
    
    func getReflectingVal(in calculator: PlateCalculator) -> Any? {
        if let reflectionName = getReflectingOption() {
            return calculator.getConfigOption(option: reflectionName)
        }
        return nil
    }
}

// actual DrawerButton


// cell containing DrawerButton
class ButtonDrawerCollectionViewCell: DJView.DJCollectionViewCell {
    private let drawerButtonView = DrawerButtonView()
    
    override func setup() {
        layoutMargins = UIEdgeInsets(top: layoutMargins.top, left: 24, bottom: layoutMargins.bottom, right: 24)
        coverSelfEntirely(with: drawerButtonView)
    }
    
    func load(drawerButtonData: DrawerButtonType, calculator: PlateCalculator) {
        drawerButtonView.load(drawerButtonData: drawerButtonData, calculator: calculator)
    }
}

protocol ButtonDrawerDelegate: class {
    func didTapDrawerButton(buttonType: DrawerButtonType)
}

// Collection view containing ButtonDrawerCollectionViewCell's
class ButtonDrawerCollectionView: DJView.DJCollectionView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 140)
    }
}

// Table view cell containing ButtonDrawerCollectionView
class ButtonDrawerTableViewCell: DJCollectionTableViewCell<ButtonDrawerCollectionViewCell, DrawerButtonType> {
    
    var calculator: PlateCalculator?
    weak var delegate: ButtonDrawerDelegate?
    override var data: [DrawerButtonType] {
        get {
            return [
                .clear,
                .toggleMultiplier,
                .toggleMeasurementSystem
            ]
        }
        
        set {}
    }
    
    override var cellTypes: [DJView.DJCollectionViewCell.Type] {
        return [ButtonDrawerCollectionViewCell.self]
    }
    
    override func headerWidth(section: Int) -> CGFloat {
        return 0
    }
    
    override func footerWidth(section: Int) -> CGFloat {
        return 16
    }
    
    override func didSelectItem(indexPath: IndexPath) {
        //
    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout methods
    
 
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 24, height: 24)
//    }


}
