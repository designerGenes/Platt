//
//  DualStateInsetTextView.swift
//  Platt
//
//  Created by Jaden Nation on 5/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

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
            values[oldValue] = text
            backgroundColor = reflectionState.backgroundColor()
            textColor = reflectionState.textColor()
            switch reflectionState {
            case .local:
                becomeFirstResponder()
                //                invisibleHitbox = UIControl()
                //                window?.coverSelfEntirely(with: invisibleHitbox!)
                //                invisibleHitbox?.addTarget(self, action: #selector(reactToLostFocus), for: .touchUpInside)
                isEnabled = true
            case .global:
                
                invisibleHitbox?.removeFromSuperview()
                invisibleHitbox = nil
                resignFirstResponder()
                isEnabled = false
            }
            text = values[reflectionState] ?? ""
            
            
        }
    }
    
    override func setup() {
        super.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(reflectLocalValue(sender:)), name: .submittingValueForEditing, object: nil)
        
        addTarget(self, action: #selector(reactToLostFocus), for: .editingDidEndOnExit)
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
        values[.local] = String(describing: localValue)
        reflectionState = .local
    }
    
    func submitUpdatedLocalValue() {
        NotificationCenter.default.post(name: .didSubmitUpdatedValue, object: nil, userInfo: [UserInfoKey.localValue: text])
    }
}
