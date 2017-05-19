//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol NewsParserProtocol {
	func parse(newsData: Data) throws -> [Article]
    func parse(articleData: Data) throws -> Article
}

public class NewsParser: NewsParserProtocol {

    public func parse(newsData: Data) throws -> [Article] {
        guard let json = try JSONSerialization.jsonObject(with: newsData) as? [String: Any],
              let payload = json[NetworkKeys.payload] as? [[String: Any]] else {
            throw NSError.invalidResponse
        }

        let articles = try payload.map { try parse(articleTitleJSON: $0) }
        return articles
    }

    public func parse(articleTitleJSON: [String: Any]) throws -> Article {
        guard let idString = articleTitleJSON[NetworkKeys.Article.Title.id] as? String,
              let id = Int(idString),
              let title = articleTitleJSON[NetworkKeys.Article.Title.title] as? String,
              let dateJSON = articleTitleJSON[NetworkKeys.Article.Title.publicationDate] as? [String: Any],
              let dateTimestamp = dateJSON[NetworkKeys.Article.Title.PublicationDate.milliseconds] as? Double else {
            throw NSError.invalidResponse
        }
        let date = Date(timeIntervalSince1970: dateTimestamp / 1000)
        let article = Article(id: id, title: title, date: date)
        return article
    }

    public func parse(articleData: Data) throws -> Article {
        guard let json = try JSONSerialization.jsonObject(with: articleData) as? [String: Any],
              let payload = json[NetworkKeys.payload] as? [String: Any],
              let titlePayload = payload[NetworkKeys.Article.titlePayload] as? [String: Any],
              let content = payload[NetworkKeys.Article.content] as? String else {
            throw NSError.invalidResponse
        }

        var article = try parse(articleTitleJSON: titlePayload)
        article.content = content

        return article
    }
}
