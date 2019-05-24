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

class HazeGradient: NSObject {
    var gradient: CGGradient!
    
    init(primaryColor: CGColor) {
        super.init()
    }
}

class HazeGradientLayer: CAGradientLayer {
    var gradient: CGGradient? = nil
    var primaryColor: UIColor = .lightPurple() {
        didSet {
            rebuildGradient()
        }
    }
    
    var endOpacity: (start: CGFloat, end: CGFloat) = (0, 0) {
        didSet {
            rebuildGradient()
        }
    }
    
    func rebuildGradient() {
//        let la = CAGradientLayer()
//        la.gra
    }
}

class SpineViewController<T: ModernViewController>: ModernViewController, HostsSideCabinet {
    private var centerInnerViewController: ModernViewController?
    private var centerNavigationController: ModernNavigationController?
    private var sideCabinetController: SideCabinetController?
    private var hazeView = UIControl()
    private var snapShotView = UIImageView()
    private let showSideCabinetOptionsPosition = SideCabinetPosition.partiallyOnscreen(percentOnscreen: 0.4)
    
    func tappedOption(optionValue: String) {
        guard let option = SideCabinetOption(rawValue: optionValue) else {
            return
        }
        
        switch option {
        case .close:
            animateCabinetPosition(position: .offscreen)
            sideCabinetController?.pairedLabelContainer.loadData(title: nil, body: nil)
        case .about:
            animateCabinetPosition(position: .fullscreen)
            sideCabinetController?.pairedLabelContainer.loadData(title: "about", body: "Platt is an easy way to calculate how much weight you lift")
        case .contact:
            animateCabinetPosition(position: .fullscreen)
            sideCabinetController?.pairedLabelContainer.loadData(title: "contact", body: "Contact Designer Jeans at \njnationmint@gmail.com")
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
    
    override func setup() {
        centerInnerViewController = T()
        centerNavigationController = ModernNavigationController(rootViewController: centerInnerViewController!)
        view.backgroundColor = UIColor.spotifyGray().lightened(by: 15)
        snapShotView.layer.drawsAsynchronously = true
        
        let barButtonItem = UIBarButtonItem(image: UIImage.fromAsset(.menu), style: .plain, target: self, action: #selector(openCabinet(sender:)))
        barButtonItem.tintColor = .spotifyMud()
        centerInnerViewController?.navigationItem.rightBarButtonItem = barButtonItem
        
        addChild(centerNavigationController!)
        
        centerNavigationController?.didMove(toParent: self)
        
        
        hazeView.backgroundColor = UIColor.lightPurple()
        hazeView.alpha = 0
        hazeView.layer.drawsAsynchronously = true
        hazeView.addTarget(self, action: #selector(tappedHaze(sender:)), for: .touchUpInside)
    }
    
    override func addConstraints() {
        view.coverSelfEntirely(with: hazeView)  // make sure it stays on top
        view.coverSelfEntirely(with: centerNavigationController!.view, obeyMargins: false)
        
    }
    
    
    @objc private func openCabinet(sender: UIBarButtonItem) {
        animateCabinetPosition(position: showSideCabinetOptionsPosition)
    }
    

    override func viewDidLayoutSubviews() {
        if let screen = hazeView.superview {
            hazeView.frame = screen.bounds
        }
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
        var goingToExtremePosition: Bool = false
        let cabinetViewOffset: CGFloat
        switch position {
        case .offscreen:
            cabinetViewOffset = 0
            shouldOpen = false
            goingToExtremePosition = true
        case .fullscreen:
            cabinetViewOffset = 1
            shouldOpen = true
            goingToExtremePosition = true
        case .partiallyOnscreen(let percentOnscreen):
            cabinetViewOffset = percentOnscreen
            addCabinetVC()
            shouldOpen = true
        }
        
        guard let sideCabinetController = sideCabinetController, let sideCabinetView = sideCabinetController.view, let centerView = centerNavigationController?.view else {
            return
        }
        
        let finishedProcessName: Notification.Name = shouldOpen ? .openedSideCabinetController : .closedSideCabinetController
        let midProcessName: Notification.Name = shouldOpen ? .openingSideCabinetController : .closingSideCabinetController
        
        let centerViewOffset: CGFloat = shouldOpen ? cabinetViewOffset * 1.24 : 0
        let zOffset: CGFloat = shouldOpen ? 0.8 : 1

        if shouldOpen && !goingToExtremePosition {  // if opening partially
            snapShotView.image = centerView.takeScreenShot()
            view.bringSubviewToFront(hazeView)
            view.bringSubviewToFront(sideCabinetView)
            
            centerView.coverSelfEntirely(with: snapShotView, obeyMargins: false)
        }
        
        
        
        NotificationCenter.default.post(name: midProcessName, object: nil, userInfo: ["cabinetViewOffset": cabinetViewOffset])
        
        let animations: () -> Void = {
            centerView.transform = CGAffineTransform.identity.scaledBy(x: zOffset, y: zOffset).translatedBy(x: UIScreen.main.bounds.width * centerViewOffset, y: 0)
            sideCabinetView.transform = CGAffineTransform.identity.translatedBy(x: UIScreen.main.bounds.width * cabinetViewOffset, y: 0)
            self.hazeView.alpha = shouldOpen ? 0.4 : 0
        }
        
        let completion: (Bool) -> Void = { done in
            NotificationCenter.default.post(name: finishedProcessName, object: nil)
            sideCabinetController.cabinetPosition = position
            if done == true && shouldOpen == false {
                //                self.view.subviews.filter({$0 === self.hazeView}).first?.removeFromSuperview()
                
                sideCabinetController.removeFromParent()
                self.sideCabinetController = nil
                self.snapShotView.image = nil
            }
        }
        
        if shouldOpen {
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           usingSpringWithDamping: 0.85,
                           initialSpringVelocity: 1,
                           options: [UIView.AnimationOptions.curveEaseOut],
                           animations: animations,
                           completion: completion)
        } else {
            UIView.animate(withDuration: 0.35,
                           delay: 0,
                           options: [.curveEaseOut],
                           animations: animations,
                           completion: completion)
        }
        
        
    }

}
