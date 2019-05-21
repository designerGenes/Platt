//
//  DJView.swift
//  Platt
//
//  Created by Jaden Nation on 5/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit


class DJView: UIView {
    
    class DJTableViewCell: UITableViewCell {
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        func setup() {
            selectionStyle = .none
            backgroundColor = .clear
        }
        
    }
    
    class DJTableView: UITableView {
        override init(frame: CGRect, style: UITableView.Style) {
            super.init(frame: frame, style: style)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        open func setup() {
            
        }
    }
    
    class DJCollectionView: UICollectionView {
        override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
            super.init(frame: frame, collectionViewLayout: layout)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        open func setup() {
            
        }
    }
    

    open func addConstraints() {
        
    }
    
    open func setup() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        addConstraints()
    }

}
