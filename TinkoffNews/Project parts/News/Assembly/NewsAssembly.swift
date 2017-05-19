//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

public class NewsAssembly: Assembly {
    public class func assemble(container: Container) {
        //NewsParser
        container.register(NewsParserProtocol.self) { _ in
            NewsParser()
        }
        
        //NewsRequestPreparer
        container.register(NewsRequestPreparerProtocol.self) { r in
            NewsRequestPreparer(networkRequestFactory: AssemblyCenter.shared.networkAssembly().networkRequestFactory())
        }
        
        //NewsAccessor
        container.register(NewsAccessorProtocol.self) { r in
            NewsAccessor(requestPreparer: r.resolve(NewsRequestPreparerProtocol.self)!,
                         parser: self.parser())
        }
        
        //NewsViewController
        container.register(NewsViewModel.self) { r in
            NewsViewModel(newsAccessor: self.accessor())
        }
        container.registerInjection(NewsViewController.self) { r, c in
            c.viewModel = r.resolve(NewsViewModel.self)
        }

        //ArticleViewController
        container.register(ArticleViewModel.self) { r in
            ArticleViewModel(newsAccessor: self.accessor())
        }
        container.registerInjection(ArticleViewController.self) { r, c in
            c.viewModel = r.resolve(ArticleViewModel.self)
        }
    }
    
    public class func parser() -> NewsParserProtocol {
        return container.resolve(NewsParserProtocol.self)!
    }
    
    public class func accessor() -> NewsAccessorProtocol {
        return container.resolve(NewsAccessorProtocol.self)!
    }
}
