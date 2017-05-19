//
//  Created by Danil Pestov on 19.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public class NewsArticleCellViewModel {
    let id: Int
    let title: String
    let date: String
    
    public init(model: Article) {
        id = model.id
        title = model.title.withoutHTML
        date = model.date.formattedDateString
    }
}
