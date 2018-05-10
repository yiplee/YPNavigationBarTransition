//
//  AppDelegate.swift
//  SwiftNavigationBarTransition
//
//  Created by Guoyin Lee on 2018/5/9.
//  Copyright © 2018 yiplee. All rights reserved.
//

import UIKit
import YPNavigationBarTransition

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let frame = UIScreen.main.bounds
        window = UIWindow.init(frame: frame)
        
        let root = YPDemoViewController.init()
        let nav = YPNavigationController.init(rootViewController: root)
        nav.view.backgroundColor = UIColor.white
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

extension YPNavigationController : NavigationBarConfigureStyle {
    public func yp_navigtionBarConfiguration() -> YPNavigationBarConfigurations {
        return [.styleBlack]
    }
    
    public func yp_navigationBarTintColor() -> UIColor! {
        return UIColor.white
    }
}

