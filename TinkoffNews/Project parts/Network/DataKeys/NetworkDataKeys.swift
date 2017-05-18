//
// Created by Danil Pestov on 13.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//

enum NetworkKeys {
    static let APIBaseURL = "https://api.tinkoff.ru/v1/"
    
    enum Requests {
        static let news = "news"
    }
    
    enum News {
        static let payload = "payload"
        
        enum Payload {
            static let id = "id"
            static let text = "text"
            static let publicationDate = "publicationDate"
            
            enum PublicationDate {
                static let milliseconds = "milliseconds"
            }
        }
    }
}
