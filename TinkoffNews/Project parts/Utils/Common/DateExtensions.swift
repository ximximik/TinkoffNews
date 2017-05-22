//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

extension Date {
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: self)
    }
}
