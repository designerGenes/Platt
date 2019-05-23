//
//  PlateSumTableViewCell.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let submittingValueForEditing = Notification.Name("submittingValueForEditing")
    static let didSubmitUpdatedValue = Notification.Name("didSubmitUpdatedValue")
}

class DualStateInsetTextView: InsetTextField {
    var invisibleHitbox: UIControl?
    enum UserInfoKey: String {
        case localValue
    }
    
    enum EditingEvent {
        case lostFocus, valueChanged
    }
    
    enum ReflectionState {
        case global, local
        func backgroundColor() -> UIColor {
            switch self {
            case .global: return .white
            case .local: return .spotifyMud()
            }
        }
        func textColor() -> UIColor {
            switch self {
            case .global: return .black
            case .local: return .white
            }
        }
    }
    
    var values = [ReflectionState: String]()
    var reflectionState: DualStateInsetTextView.ReflectionState = .global {
        didSet {
            if reflectionState == .local {
                becomeFirstResponder()
                invisibleHitbox = UIControl()
                window?.coverSelfEntirely(with: invisibleHitbox!)
                invisibleHitbox?.addTarget(self, action: #selector(returnToGlobal), for: .touchUpInside)
            }
            values[oldValue] = text
            backgroundColor = reflectionState.backgroundColor()
            textColor = reflectionState.textColor()
            isEnabled = reflectionState == .local
        }
    }
    
    @objc func returnToGlobal() {
        reflectionState = .global
        invisibleHitbox?.removeFromSuperview()
    }
    
    override func setup() {
        super.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(reflectLocalValue(sender:)), name: .submittingValueForEditing, object: nil)
        addTarget(self, action: #selector(reactToTextChange), for: .allEvents)
        addTarget(self, action: #selector(reactToLostFocus), for: .editingDidEndOnExit)
        reflectionState = .global
        autocorrectionType = .no
        isEnabled = false
        
    }
    
    @objc func reactToLostFocus() {
        if reflectionState == .local {
            submitUpdatedLocalValue()
            reflectionState = .global
        }
    }
    
    @objc func reactToTextChange() {
        values[reflectionState] = text
    }
    
    
    @objc func reflectLocalValue(sender: Notification) {
        guard let localValue = sender.userInfo?[UserInfoKey.localValue] else {
            return
        }
        reflectionState = .local
        text = String(describing: localValue)
    }
    
    func submitUpdatedLocalValue() {
        let userInfo = [UserInfoKey.localValue: text]
        NotificationCenter.default.post(name: .didSubmitUpdatedValue, object: nil, userInfo: userInfo)
    }
}

class PlateSumTableViewCell: ModernView.ModernTableViewCell {
    private var sumTextField = DualStateInsetTextView(textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32))
    
    @objc func reflectSum(notification: Notification) {
        reflectSum(sum: notification.userInfo?[CalculatorProperty.sum.rawValue] as? Double ?? 0)
    }
    
    func reflectSum(sum: Double) {
        var sumStr = String(sum)
        if Double(Int(sum)) == sum {
            sumStr = String(Int(sum))
        }
        let mSystemSuffix = "\(PlateCalculator.activeInstance.measurementSystem.suffix().uppercased())\(sum > 1 ? "s" : "")"
        sumTextField.text = "\(sumStr)  \(mSystemSuffix)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sumTextField.layer.cornerRadius = 10 //lblSum.frame.height / 2
    }
    
    override func setup() {
        super.setup()
        backgroundColor = .clear
        contentView.coverSelfEntirely(with: sumTextField, obeyMargins: true)
        sumTextField.heightAnchor.constraint(equalToConstant: 88).isActive = true
        sumTextField.backgroundColor = .white
        sumTextField.font = .boldSystemFont(ofSize: 40)
        sumTextField.textAlignment = .right
        sumTextField.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        sumTextField.layer.masksToBounds = true
        NotificationCenter.default.addObserver(sumTextField, selector: #selector(DualStateInsetTextView.reflectLocalValue(sender:)), name: .submittingValueForEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reflectSum(notification:)), name: .calculatorUpdatedSum, object: nil)
        
    }

}
