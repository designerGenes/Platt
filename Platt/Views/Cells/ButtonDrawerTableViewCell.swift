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

class ButtonDrawerCollectionViewCell: UICollectionViewCell {
    private let drawerButtonView = DrawerButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layoutMargins = UIEdgeInsets(top: layoutMargins.top, left: 24, bottom: layoutMargins.bottom, right: 24)
        coverSelfEntirely(with: drawerButtonView)
        backgroundColor = .clear
        
    }
    
    func load(drawerButtonData: DrawerButtonType, calculator: PlateCalculator) {
        drawerButtonView.load(drawerButtonData: drawerButtonData, calculator: calculator)
    }
}

protocol ButtonDrawerDelegate: class {
    func didTapDrawerButton(buttonType: DrawerButtonType)
}

class ButtonDrawerTableViewCell: CalculatorTableCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var calculator: PlateCalculator?
    weak var delegate: ButtonDrawerDelegate?
    private var data: [DrawerButtonType] = [
        .clear,
        .toggleMultiplier,
        .toggleMeasurementSystem
    ]
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 16, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapDrawerButton(buttonType: data[indexPath.section])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  CalculatorTableDataSource.CalculatorTableCellId.ButtonDrawerTableViewCell.rawValue, for: indexPath) as! ButtonDrawerCollectionViewCell
        cell.load(drawerButtonData: data[indexPath.section], calculator: calculator!) // TMP!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 24, height: 24)
    }
    
    override func setup() {
        super.setup()
        contentView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 24, height: 24)
//        flowLayout.itemSize = CGSize(width: 24, height: 24) //UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        coverSelfEntirely(with: collectionView, obeyMargins: false)
        collectionView.backgroundColor = .clear
        collectionView.register(ButtonDrawerCollectionViewCell.self, forCellWithReuseIdentifier: CalculatorTableDataSource.CalculatorTableCellId.ButtonDrawerTableViewCell.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}
