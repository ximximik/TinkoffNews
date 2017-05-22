//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol NewsAccessorProtocol {
    func getNews() -> Request<[Article]>
    func getArticle(id: Int) -> Request<Article>
}

public class NewsAccessor: NewsAccessorProtocol {
    private let requestPreparer: NewsRequestPreparerProtocol
    private let parser: NewsParserProtocol
    
    init(requestPreparer: NewsRequestPreparerProtocol,
         parser: NewsParserProtocol) {
        self.requestPreparer = requestPreparer
        self.parser = parser
    }
    
    //MARK: Network requests
    public func getNews() -> Request<[Article]> {
        return Request(urlRequest: requestPreparer.getNews(),
                       handler: parser.parse(newsData:),
                       cacheTask: getCachedArticles)
            .onSuccess(save(articles:))
    }
    
    public func getArticle(id: Int) -> Request<Article> {
        return Request(urlRequest: requestPreparer.getArticle(id: id),
                       handler: parser.parse(articleData:),
                       cacheTask: { [weak self] in return self?.getCachedArticle(id: id) })
            .onSuccess(save(article:))
    }
    
    //MARK: Cache
    public func getCachedArticles() -> [Article] {
        let _articles = Storage.shared.articlesSortedByDate()
        let articles = _articles.flatMap { Article(article: $0) }
        return articles
    }
    
    public func getCachedArticle(id: Int) -> Article? {
        if let _article = Storage.shared.article(id: id) {
            let article = Article(article: _article)
            return article
        }
        return nil
    }
    
    public func save(articles: [Article]) {
        DispatchQueue.main.async {
            let cachedArticles = Storage.shared.articlesSortedByDate()
            for article in articles {
                if let _article = cachedArticles.first(where: { $0.id == Int32(article.id) }) {
                    _article.copyValues(from: article)
                } else {
                    let _article = Storage.shared.createArticle(id: article.id)
                    _article.copyValues(from: article)
                }
            }
            Storage.shared.saveContext()
        }
    }
    
    public func save(article: Article) {
        DispatchQueue.main.async {
            let _article = Storage.shared.findOrCreateArticle(id: article.id)
            _article.copyValues(from: article)
            Storage.shared.saveContext()
        }
    }
}
