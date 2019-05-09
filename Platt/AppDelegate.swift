//
//  AppDelegate.swift
//  Platt
//
//  Created by Jaden Nation on 4/22/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let spineVC = SpineViewController()
        let calcVC = CalculatorViewController()
        spineVC.addChild(calcVC)
        spineVC.view.coverSelfEntirely(with: calcVC.view, obeyMargins: false)
        calcVC.didMove(toParent: spineVC)
    
        window?.rootViewController = spineVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

