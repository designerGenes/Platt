//
//  ButtonDrawerTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

enum DrawerButtonType {
    case clear, toggleMultiplier
    func getReflectingOption() -> CalculatorConfigOption? {
        switch self {
        case .toggleMultiplier: return .multiplier
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
        case .clear: assetName = .letterC
        case .toggleMultiplier:
            assetName = (drawerButtonData.getReflectingVal(in: calculator) as! Int) < 2 ? .halfBar : .fullBar
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

class ButtonDrawerTableViewCell: CalculatorTableCell, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView!
    var calculator: PlateCalculator?
    weak var delegate: ButtonDrawerDelegate?
    private var data: [DrawerButtonType] = [
        .clear,
        .toggleMultiplier
    ]
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate methods
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonDrawerCollectionViewCell", for: indexPath) as! ButtonDrawerCollectionViewCell
        cell.load(drawerButtonData: data[indexPath.section], calculator: calculator!) // TMP!
        return cell
    }
    
    
    override func setup() {
        super.setup()
        contentView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 56, height: 56)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        coverSelfEntirely(with: collectionView, obeyMargins: false)
        collectionView.backgroundColor = .clear
        collectionView.register(ButtonDrawerCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonDrawerCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}
