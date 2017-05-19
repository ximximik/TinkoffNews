//
//  Article.swift
//  TinkoffNews
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
}
