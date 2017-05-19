//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol NewsRequestPreparerProtocol {
    func getNews() -> URLRequest
    func getArticle(id: Int) -> URLRequest
}

public class NewsRequestPreparer: NewsRequestPreparerProtocol {
    private let networkRequestFactory: NetworkRequestFactoryProtocol
    
    init(networkRequestFactory: NetworkRequestFactoryProtocol) {
        self.networkRequestFactory = networkRequestFactory
    }
    
    public func getNews() -> URLRequest {
        return networkRequestFactory.prepareRequest(request: NetworkKeys.Requests.news,
                                                    method: .get)
    }
    
    public func getArticle(id: Int) -> URLRequest {
        let params: [String: Any] = [NetworkKeys.Article.Title.id : id]
        return networkRequestFactory.prepareRequest(request: NetworkKeys.Requests.articleContent,
                                                    method: .get,
                                                    params: params)
    }
}
