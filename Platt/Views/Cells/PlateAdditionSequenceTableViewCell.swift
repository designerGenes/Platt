//
//  PlateAdditionSequenceTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class PlateAdditionSequenceTableViewCell: PlateCollectionTableViewCell {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSubmitNewPlateList(plates: data.filter({$0 != data[indexPath.section]}))
    }

    override func setup() {
        super.setup()
        contentView.backgroundColor = .lighterBgroundGray()
    }

}
