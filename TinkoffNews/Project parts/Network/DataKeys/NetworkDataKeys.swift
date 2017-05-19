//
// Created by Danil Pestov on 13.10.16.
// Copyright (c) 2016 HOKMT. All rights reserved.
//

enum NetworkKeys {
    static let APIBaseURL = "https://api.tinkoff.ru/v1/"

    enum Requests {
        static let news = "news"
        static let articleContent = "news_content"
    }

    enum Article {
        static let content = "content"

        static let titlePayload = "title"

        enum Title {
            static let id = "id"
            static let title = "text"
            static let publicationDate = "publicationDate"

            enum PublicationDate {
                static let milliseconds = "milliseconds"
            }
        }
    }

    static let payload = "payload"
}
