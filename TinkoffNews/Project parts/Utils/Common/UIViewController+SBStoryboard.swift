//
//  Created by Danil Pestov on 09.12.16.
//  Copyright © 2016 Danil Pestov. All rights reserved.
//
import UIKit

extension UIViewController {
    static var describing: String {
        return String(describing: self)
    }
    
    class func instantiate(storyboard: Storyboard) -> Self {
        return _instantiate(storyboard: storyboard)
    }
    
    class func instantiate<T: Storyboard>(storyboard: T.Type) -> Self {
        return _instantiate(storyboard: storyboard.storyboard())
    }
    
    private class func _instantiate<T>(storyboard: Storyboard) -> T {
        return storyboard.instantiateViewController(withIdentifier: self.describing) as! T
    }
}
