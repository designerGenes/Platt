//
//  PlateCollectionTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
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
//        contentView.backgroundColor = .white
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

class PlateCollectionTableViewCell: CalculatorTableCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var data = [Plate]()
    var collectionView: UICollectionView!
    
    // MARK: - lifecycle methods
    override func setup() {
        super.setup()
        
        data = Plate.defaultPlates // TMP!
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 2, height: 2)
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        coverSelfEntirely(with: collectionView, obeyMargins: false)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = .clear
        collectionView.register(PlateCollectionViewCell.self, forCellWithReuseIdentifier: "PlateCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    // MARK: - UICollectionViewDataSource, UICollectionViewDelegate methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 24, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 24, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlateCollectionViewCell", for: indexPath) as! PlateCollectionViewCell
        cell.loadPlate(plate: data[indexPath.section], position: indexPath.section)
        return cell
    }
    
    
    
    

}
