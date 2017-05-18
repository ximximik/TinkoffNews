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
    let text: String
    let date: Date
    let content: String
    
    public init(id: Int, text: String, date: Date, content: String = "") {
        self.id = id
        self.text = text
        self.date = date
        self.content = content
    }
}
