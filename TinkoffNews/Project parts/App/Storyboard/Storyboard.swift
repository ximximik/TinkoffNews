//
// Created by Danil Pestov on 17.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//
import UIKit

public class Storyboard {
    private let _storyboard: UIStoryboard
    private var container: Container?
    
    public init() {
        _storyboard = UIStoryboard()
    }
    
    public init(name: String, bundle: Bundle?) {
        _storyboard = UIStoryboard(name: name, bundle: bundle)
    }
    
    public convenience init(name: String, bundle: Bundle?, container: Container) {
        self.init(name: name, bundle: bundle)
        self.container = container
    }
    
    public class func storyboard() -> Storyboard {
        return Storyboard()
    }
    
    public class func instantiate<T: UIViewController>(_ viewControllerType: T.Type) -> T {
        let storyboard = self.storyboard()
        let viewController = T.instantiate(storyboard: storyboard._storyboard)
        storyboard.container?.resolveInjection(viewController)
        return viewController
    }
}
