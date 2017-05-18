//
//  Created by Danil Pestov on 08.11.16.
//  Copyright © 2016 HOKMT. All rights reserved.
//
import UIKit

extension String {
    func caseInsensitiveContains(_ otherString: String) -> Bool {
        return self.lowercased().contains(otherString.lowercased())
    }
    
    var url: URL? {
        return URL(string: self)
    }
    
    var trimWhitespaces: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var length: Int {
        return characters.count
    }
}
