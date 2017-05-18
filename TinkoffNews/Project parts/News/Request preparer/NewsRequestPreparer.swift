//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol NewsRequestPreparerProtocol {     
	func getNews() -> URLRequest     
}

public class NewsRequestPreparer: NewsRequestPreparerProtocol {     
    private let networkRequestFactory: NetworkRequestFactoryProtocol
    
    init(networkRequestFactory: NetworkRequestFactoryProtocol) {
        self.networkRequestFactory = networkRequestFactory
    }

    public func getNews() -> URLRequest {
        let params: [String: Any] = [:]
        return networkRequestFactory.prepareRequest(request: NetworkKeys.Requests.news,
                                                    method: .get,
                                                    params: params)
    }
}
