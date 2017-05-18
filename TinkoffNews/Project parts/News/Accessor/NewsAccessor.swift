//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation 

public protocol NewsAccessorProtocol {     
	func getNews() -> Request<[Article]>     
}

public class NewsAccessor: NewsAccessorProtocol {
    private let requestPreparer: NewsRequestPreparerProtocol
    private let parser: NewsParserProtocol
    
    init(requestPreparer: NewsRequestPreparerProtocol,
         parser: NewsParserProtocol) {
        self.requestPreparer = requestPreparer
        self.parser = parser
    }

    public func getNews() -> Request<[Article]> {
        return Request(urlRequest: requestPreparer.getNews(),
                       handler: parser.parse(newsData:))
    }
}
