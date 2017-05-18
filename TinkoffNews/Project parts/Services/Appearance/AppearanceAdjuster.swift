//
// Created by Danil Pestov on 18.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//

import UIKit

public protocol AppearanceAdjuster {
    func setupAppearance()
}

let tabBarItemTitleFontSize: CGFloat = 12.0

public class AppearanceAdjusterDefault: AppearanceAdjuster {
    
    public func setupAppearance() {
        setupNavigationBar()
        setupStatusBar()
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    private func setupStatusBar() {
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
