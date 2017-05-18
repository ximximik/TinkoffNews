//
//  Created by Danil Pestov on 14/01/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

infix operator ?= : AssignmentPrecedence

extension Optional {
    public static func ?= ( lhs: inout Wrapped, rhs: Wrapped?) {
        if let unwrapped = rhs {
            lhs = unwrapped
        }
    }
}
