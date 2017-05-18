//
//  AppDelegate.swift
//  ScotusBlog
//
//  Created by Danil Pestov on 08.01.17.
//  Copyright © 2017 Danil Pestov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let appearanceAdjuster: AppearanceAdjuster
    var window: UIWindow?
    
    private var dataTask: URLSessionDataTask?
    
    override init() {
        appearanceAdjuster = AssemblyCenter.shared.servicesAssembly().appearanceAdjuster()
        super.init()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appearanceAdjuster.setupAppearance()
        setupWindow()
        return true
    }
    
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        setStartViewController()
        window?.makeKeyAndVisible()
    }
    
    func setStartViewController() {
        if let controller = window?.rootViewController as? UINavigationController {
            controller.viewControllers.removeAll()
        }
        window?.rootViewController = UIViewController()
    }
}
