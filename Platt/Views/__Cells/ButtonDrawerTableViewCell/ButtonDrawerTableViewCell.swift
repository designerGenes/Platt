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


// cell containing DrawerButton
class ButtonDrawerCollectionViewCell: ModernView.ModernCollectionViewCell {
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
class ButtonDrawerCollectionView: TypedCollectionView<ButtonDrawerCollectionViewCell, DrawerButtonType, ButtonDrawerCollectionDataSource> {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 140)
    }
}

class ButtonDrawerCollectionDataSource: CollectionDataSource<ButtonDrawerCollectionViewCell, DrawerButtonType> {
    var calculator: PlateCalculator?
    override var data: [DrawerButtonType] {
        get { return [.clear, .toggleMultiplier, .toggleMeasurementSystem] }
        set {}
    }
    
    override func loadDataIntoCell(cell: ButtonDrawerCollectionViewCell, at indexPath: IndexPath) {
        if let calculator = calculator {
            cell.load(drawerButtonData: data[indexPath.section], calculator: calculator)
        }
    }

    
    // MARK: - CollectionViewSizingDelegate methods
    override func widthForHeader(at section: Int) -> CGFloat {
        return 10
    }
    
    override func widthForFooter(at section: Int) -> CGFloat {
        return 10
    }
    
    override func widthForRow(at indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

// Table view cell containing ButtonDrawerCollectionView
class ButtonDrawerTableViewCell: CollectionTableViewCell<ButtonDrawerCollectionViewCell, DrawerButtonType, ButtonDrawerCollectionDataSource, ButtonDrawerCollectionView> {
    
    weak var delegate: ButtonDrawerDelegate?
}
