//
//  Created by Danil Pestov on 09.12.16.
//  Copyright © 2016 Danil Pestov. All rights reserved.
//
import UIKit

extension UIViewController {
    static var describing: String {
        return String(describing: self)
    }
    
    class func instantiate(storyboard: UIStoryboard) -> Self {
        return _instantiate(storyboard: storyboard)
    }
    
    private class func _instantiate<T>(storyboard: UIStoryboard) -> T {
        return storyboard.instantiateViewController(withIdentifier: self.describing) as! T
    }
}
