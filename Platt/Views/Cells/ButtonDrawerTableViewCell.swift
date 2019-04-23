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
    func getReflectingOption() -> ConfigOption? {
        switch self {
        case .toggleMultiplier: return .multiplier
        default: return nil
        }
    }
    
    func getReflectingOptionVal() -> Any? {
        if let reflectionName = getReflectingOption() {
            return SessionConfig.activeConfig().configOptions[reflectionName]
        }
        return nil
    }
    
    func getImg() -> UIImage {
        switch self {
        case .clear: return UIImage.fromAsset(.letterC)
        case .toggleMultiplier: return UIImage.fromAsset((self.getReflectingOptionVal() as! Int) < 2 ? NamedAsset.halfBar : .fullBar)
        }
    }
}

class DrawerButtonView: RoundedCornersView {
    private let iconView = UIImageView()
    
    func load(drawerButtonData: DrawerButtonType) {
        if !subviews.contains(iconView) {
            coverSelfEntirely(with: iconView)
            iconView.contentMode = .center
            backgroundColor = .lighterBgroundGray()
            cornerRadius = 6
        }
        iconView.image = drawerButtonData.getImg()
    }
}

class ButtonDrawerCollectionViewCell: UICollectionViewCell {
    private let drawerButtonView = DrawerButtonView()
//    private var optionButton: DrawerButtonView
    
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
    
    func load(drawerButtonData: DrawerButtonType) {
        drawerButtonView.load(drawerButtonData: drawerButtonData)
    }
}

protocol ButtonDrawerDelegate: class {
    func didTapDrawerButton(buttonType: DrawerButtonType)
}

class ButtonDrawerTableViewCell: CalculatorTableCell, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView!
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
        cell.load(drawerButtonData: data[indexPath.section])
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
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.register(ButtonDrawerCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonDrawerCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}
