//
//  UIViewController+Convenience.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/12/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleAlert(msg: String, title: String? = nil, doneBlock: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}
