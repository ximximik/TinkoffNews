//
//  Created by Danil Pestov on 22.12.16.
//  Copyright © 2016 Danil Pestov. All rights reserved.
//
import UIKit

extension UIView {
    class var describing: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: describing, bundle: nil)
    }
    
    class func instantiateFromNib() -> Self {
        return _instantiateFromNib()
    }
    
    private class func _instantiateFromNib<T>() -> T {
        return nib.instantiate(withOwner: nil, options: nil)[0] as! T
    }
}
