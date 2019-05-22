//
//  CollectionViewWithSize.swift
//  Platt
//
//  Created by Jaden Nation on 5/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

class CollectionViewWithSize: ModernView.ModernCollectionView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentSize.width, height: 100)
    }
}

