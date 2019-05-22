//
//  SpineViewController.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

protocol HostsSideCabinet: class {
    func animateCabinetPosition(position: SideCabinetPosition)
    func getCabinetIsOpen() -> Bool
    func tappedOption(optionValue: String) // hack to get around enum
}

class SpineViewController: BaseViewController, HostsSideCabinet {    
    private var centerInnerViewController: UIViewController?
    private var centerNavigationController: UINavigationController?
    private var sideCabinetController: SideCabinetController?
    private var hazeView: UIControl?
    private var snapShotView: UIImageView?
    static let optionsPosition = SideCabinetPosition.partiallyOnscreen(percentOnscreen: 0.4)
    
    func tappedOption(optionValue: String) {
        guard let option = SideCabinetOption(rawValue: optionValue) else {
            return
        }
        switch option {
        case .close:
            animateCabinetPosition(position: .offscreen)
        case .about:
            animateCabinetPosition(position: .fullscreen)
        case .contact:
            animateCabinetPosition(position: .fullscreen)
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
        let barButtonItem = UIBarButtonItem(image: UIImage.fromAsset(.menu), style: .plain, target: self, action: #selector(openCabinet(sender:)))
        centerInnerViewController?.navigationItem.rightBarButtonItem = barButtonItem
        barButtonItem.tintColor = .spotifyMud()
        addChild(centerNavigationController!)
        view.coverSelfEntirely(with: centerNavigationController!.view, obeyMargins: false)
        centerNavigationController?.didMove(toParent: self)
    }
    
    @objc private func openCabinet(sender: UIBarButtonItem) {
        animateCabinetPosition(position: SpineViewController.optionsPosition)
    }
    

    override func viewDidLayoutSubviews() {
        hazeView?.frame = UIScreen.main.bounds
    }
    
    // MARK: - HostsSideCabinet methods
    func getCabinetIsOpen() -> Bool {
        guard let position = sideCabinetController?.cabinetPosition else {
            return false
        }
        switch position {
        case .offscreen: return false
        default: return true
        }
    }
    
    @objc private func tappedHaze(sender: NSObject) {
        animateCabinetPosition(position: .offscreen)
    }
    
    
    func animateCabinetPosition(position: SideCabinetPosition) {
        var shouldOpen: Bool
        let cabinetViewOffset: CGFloat
        switch position {
        case .offscreen:
            cabinetViewOffset = 0
            shouldOpen = false
        case .fullscreen:
            cabinetViewOffset = 1
            shouldOpen = true
        case .partiallyOnscreen(let percentOnscreen):
            cabinetViewOffset = percentOnscreen
            addCabinetVC()
            shouldOpen = true
        }
        
        guard let sideCabinetController = sideCabinetController, let sideCabinetView = sideCabinetController.view, let centerView = centerNavigationController?.view else {
            return
        }
        
        let nName: Notification.Name = shouldOpen ? .openedSideCabinetController : .closedSideCabinetController
        
        
        let centerViewOffset: CGFloat = shouldOpen ? cabinetViewOffset * 1.24 : 0
        let zOffset: CGFloat = shouldOpen ? 0.8 : 1

        // animate haze
        var centerCoverView: UIView?
        if shouldOpen && hazeView == nil {
            hazeView = UIControl()
            view.coverSelfEntirely(with: hazeView!)  // make sure it stays on top
            hazeView?.backgroundColor = UIColor.lightPurple()
            hazeView?.addTarget(self, action: #selector(tappedHaze(sender:)), for: .touchUpInside)
            hazeView?.alpha = 0
            view.bringSubviewToFront(sideCabinetView)
            let snapShotView = UIImageView(image: centerView.takeScreenShot())
            self.snapShotView = snapShotView
            
            centerCoverView = UIView()
            centerCoverView!.backgroundColor = centerView.backgroundColor
            centerView.coverSelfEntirely(with: snapShotView, obeyMargins: false)
        }
        
        NotificationCenter.default.post(name: .openingSideCabinetController, object: nil, userInfo: ["cabinetViewOffset": cabinetViewOffset])
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.hazeView?.alpha = shouldOpen ? 0.4 : 0
        
            centerView.transform = CGAffineTransform.identity.scaledBy(x: zOffset, y: zOffset).translatedBy(x: UIScreen.main.bounds.width * centerViewOffset, y: 0)
            sideCabinetView.transform = CGAffineTransform.identity.translatedBy(x: UIScreen.main.bounds.width * cabinetViewOffset, y: 0)
            
        }, completion: { (done) in
            NotificationCenter.default.post(name: nName, object: nil)
            sideCabinetController.cabinetPosition = position
            if done == true && shouldOpen == false {
                self.hazeView?.removeFromSuperview()
                self.hazeView = nil
//                self.view.subviews.filter({$0 === self.hazeView}).first?.removeFromSuperview()
                sideCabinetController.removeFromParent()
                self.sideCabinetController = nil
                self.snapShotView?.removeFromSuperview()
                self.snapShotView = nil
            }
        })
    }

}
