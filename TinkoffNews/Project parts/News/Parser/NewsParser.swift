//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol NewsParserProtocol {     
	func parse(newsData: Data) throws -> [Article]
}

public class NewsParser: NewsParserProtocol {
    
    public func parse(newsData: Data) throws -> [Article] {
        guard let json = try JSONSerialization.jsonObject(with: newsData) as? [String: Any],
            let payload = json[NetworkKeys.News.payload] as? [[String: Any]] else {
                throw NSError.invalidResponse
        }
        
        let articles = try payload.map { try parse(articleTitleJSON: $0) }
        return articles
    }
    
    public func parse(articleTitleJSON: [String: Any]) throws -> Article {
        guard let idString = articleTitleJSON[NetworkKeys.News.Payload.id] as? String,
            let id = Int(idString),
            let text = articleTitleJSON[NetworkKeys.News.Payload.text] as? String,
            let dateJSON = articleTitleJSON[NetworkKeys.News.Payload.publicationDate] as? [String: Any],
            let dateTimestamp = dateJSON[NetworkKeys.News.Payload.PublicationDate.milliseconds] as? Double else {
            throw NSError.invalidResponse
        }
        let date = Date(timeIntervalSince1970: dateTimestamp / 1000)
        let article = Article(id: id, text: text, date: date)
        return article
    }
}
