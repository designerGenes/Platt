//
//  ModernView.swift
//  Platt
//
//  Created by Jaden Nation on 5/9/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

@objc public protocol ModernInitialized {
    @objc func setup()
    @objc optional func addConstraints()
}

extension UIView: ModernInitialized {
    public func setup() {
        //
    }
    
    public func addConstraints() {
        //
    }
}

class ModernViewController: UIViewController, ModernInitialized {
    func addConstraints() {
        
    }
    
    func setup() {
        // happens before view loads
    }
    
    func onLoadSetup() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoadSetup()
        addConstraints()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    class ModernNavigationController: UINavigationController, ModernInitialized {
        
        func setup() {
            //
        }
        
        override init(rootViewController: UIViewController) {
            super.init(rootViewController: rootViewController)
            setup()
        }
        
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
    }
}

class ModernView: UIView {
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

    class ModernTextField: UITextField {
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
            addConstraints()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
            addConstraints()
        }
    }
    
    class ModernControl: UIControl {
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
    
    class ModernTableViewCell: UITableViewCell {

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
            addConstraints()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
            addConstraints()
        }

        @objc override func setup() {
            selectionStyle = .none
            backgroundColor = .clear
        }

    }

    class ModernTableView: UITableView {
        override init(frame: CGRect, style: UITableView.Style) {
            super.init(frame: frame, style: style)
            setup()
            addConstraints()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
            addConstraints()
        }
    }

    class ModernCollectionViewCell: UICollectionViewCell {
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

    class ModernCollectionView: UICollectionView {
        override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
            super.init(frame: frame, collectionViewLayout: layout)
            setup()
            addConstraints()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
            addConstraints()
        }
    }
}
