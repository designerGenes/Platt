//
//  SpineViewController.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

@objc protocol HostsSideCabinet: class {
    func toggleCabinetOpen()
    func setCabinetOpen(shouldOpen: Bool)
    func getCabinetIsOpen() -> Bool
    func tappedOption(optionValue: String) // hack to get around enum
}

class SpineViewController: BaseViewController, HostsSideCabinet {    
    private var centerInnerViewController: UIViewController?
    private var centerNavigationController: UINavigationController?
    private var sideCabinetController: SideCabinetController?

    private var hazeView = UIControl()
    private var snapShotView: UIImageView?
    
    func tappedOption(optionValue: String) {
        guard let option = SideCabinetOption(rawValue: optionValue) else {
            return
        }
        switch option {
        case .close: setCabinetOpen(shouldOpen: false)
        case .about: break
        case .contact: break
        }
    }
    
    private func addCabinetVC() {
        guard sideCabinetController == nil else {
            return
        }
        let sideCabinetController = SideCabinetController()
        self.sideCabinetController = sideCabinetController
        sideCabinetController.delegate = self
        view.addSubview(sideCabinetController.view)
        addChild(sideCabinetController)
        sideCabinetController.didMove(toParent: self)
        sideCabinetController.view.frame = CGRect(origin: CGPoint(x: -UIScreen.main.bounds.width, y: 0), size: UIScreen.main.bounds.size)
    }
    
    
    
    convenience init<T: UIViewController>(centerVCClass: T.Type) {
        self.init()
        centerInnerViewController = T()
        centerNavigationController = UINavigationController(rootViewController: centerInnerViewController!)
        
        centerInnerViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.fromAsset(.menu), style: .plain, target: self, action: #selector(toggleCabinetOpen))
        centerInnerViewController?.navigationItem.rightBarButtonItem?.tintColor = .spotifyMud()
        addChild(centerNavigationController!)
        view.coverSelfEntirely(with: centerNavigationController!.view, obeyMargins: false)
//        view.backgroundColor = centerInnerViewController?.view.backgroundColor
        centerNavigationController?.didMove(toParent: self)
        
    }
    
    override func viewDidLayoutSubviews() {
        hazeView.frame = UIScreen.main.bounds
    }
    
    // MARK: - HostsSideCabinet methods
    func getCabinetIsOpen() -> Bool {
        return sideCabinetController?.state == SideCabinetController.CabinetState.open
    }
    
    public func toggleCabinetOpen() {
        let isOpen = getCabinetIsOpen()
        animateCabinetOpen(shouldOpen: !isOpen)
        setCabinetOpen(shouldOpen: !isOpen)
    }
    
    public func setCabinetOpen(shouldOpen: Bool) {
        guard getCabinetIsOpen() == !shouldOpen else {
            return
        }
        
        addCabinetVC()
        sideCabinetController?.state = shouldOpen ? .open : .closed
        
        animateCabinetOpen(shouldOpen: shouldOpen)
        
        sideCabinetController?.state = shouldOpen ? SideCabinetController.CabinetState.open : .closed
    }
    
    @objc private func tappedHaze(sender: NSObject) {
        animateCabinetOpen(shouldOpen: false)
    }
    
    private func animateCabinetOpen(shouldOpen: Bool) {
        guard let sideCabinetController = sideCabinetController, let sideCabinetView = sideCabinetController.view, let centerView = centerNavigationController?.view else {
            return
        }
        
        let nName: Notification.Name = shouldOpen ? .openedSideCabinetController : .closedSideCabinetController
        
        let cabinetViewOffset: CGFloat = shouldOpen ? UIScreen.main.bounds.width * 0.4 : 0
        let centerViewOffset: CGFloat = shouldOpen ? UIScreen.main.bounds.width * 0.4 : 0
        let zOffset: CGFloat = shouldOpen ? 0.8 : 1

        // animate haze
        if shouldOpen {
            hazeView = UIControl()
            view.coverSelfEntirely(with: hazeView)  // make sure it stays on top
            hazeView.backgroundColor = UIColor.lightPurple()
            hazeView.addTarget(self, action: #selector(tappedHaze(sender:)), for: .touchUpInside)
            hazeView.alpha = 0
        }
        
        var centerCoverView: UIView?
        if shouldOpen {
            view.bringSubviewToFront(sideCabinetView)
            
            let snapShotView = UIImageView(image: centerView.takeScreenShot())
            self.snapShotView = snapShotView
            
            centerCoverView = UIView()
            centerCoverView!.backgroundColor = centerInnerViewController?.view.backgroundColor
            
            centerView.coverSelfEntirely(with: centerCoverView!, obeyMargins: false)
            centerView.coverSelfEntirely(with: snapShotView, obeyMargins: false)
        }
        
        NotificationCenter.default.post(name: .openingSideCabinetController, object: nil)
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.hazeView.alpha = shouldOpen ? 0.4 : 0
            sideCabinetView.transform = CGAffineTransform.identity.translatedBy(x: cabinetViewOffset, y: 0)
            if let snapShotView = self.snapShotView {
                centerView.transform = CGAffineTransform.identity.translatedBy(x: centerViewOffset, y: 0)
                
                snapShotView.transform = CGAffineTransform.identity.scaledBy(x: zOffset, y: zOffset)
                
                
            }
            
        }, completion: { (done) in
            NotificationCenter.default.post(name: nName, object: nil)
            if done == true && shouldOpen == false {
                self.hazeView.removeFromSuperview()
                centerView.subviews[centerView.subviews.count - 2].removeFromSuperview()
                self.sideCabinetController?.removeFromParent()
                self.sideCabinetController = nil
                self.snapShotView?.removeFromSuperview()
                self.snapShotView = nil
            }
        })
    }

}
