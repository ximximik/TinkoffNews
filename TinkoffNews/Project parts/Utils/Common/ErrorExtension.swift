//
//  Created by Danil Pestov on 17.10.16.
//  Copyright © 2016 HOKMT. All rights reserved.
//
import Foundation

public let eInvalidResponseErrorText = NSLocalizedString("invalidServerResponseErrorText", comment: "")
public let eFillAllFieldsErrorText = NSLocalizedString("fillAllFieldsErrorText", comment: "")

extension Error {
    static var invalidResponse: NSError {
        return NSError(domain: eInvalidResponseErrorText, code: 0, userInfo: nil)
    }
}
