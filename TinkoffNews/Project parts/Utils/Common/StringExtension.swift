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
    
    var withoutHTML: String {
        do {
            guard let htmlStringData = self.data(using: String.Encoding.utf8) else { return self }
            
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)]
            let attributedHTMLString = try NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
            
            return attributedHTMLString.string
        } catch _ {
            return self
        }
    }
}
