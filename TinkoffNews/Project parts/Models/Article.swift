//
//  Created by Danil Pestov on 19.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public struct Article {
    let id: Int
    let title: String
    let date: Date
    var content: String
    
    public init(id: Int, title: String, date: Date, content: String = "") {
        self.id = id
        self.title = title
        self.date = date
        self.content = content
    }
    
    public init?(article: _Article) {
        guard let title = article.title,
            let date = article.date as Date?,
            let content = article.content else {
                return nil
        }
        self.id = Int(article.id)
        self.title = title
        self.date = date
        self.content = content
    }
}


extension _Article {
    public func copyValues(from article: Article) {
        id = Int32(article.id)
        title = article.title
        date = article.date
        
        if content == nil || !article.content.isEmpty {
            content = article.content
        }
    }
}
