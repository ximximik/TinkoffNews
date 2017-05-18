//
// Created by Danil Pestov on 13.10.16.
// Copyright (c) 2016 HOKMT LLC. All rights reserved.
//


public class NetworkAssembly: Assembly {
    
    public class func assemble(container: Container) {
        //NetworkRequestProcessor
        container.register(NetworkRequestProcessorProtocol.self) { r in
            NetworkRequestProcessor()
        }
        
        //NetworkRequestFactory
        container.register(NetworkRequestFactoryProtocol.self) { r in
            NetworkRequestFactory(baseURL: NetworkKeys.APIBaseURL)
        }
    }
    
    public class func networkRequestProcessor() -> NetworkRequestProcessorProtocol {
        return container.resolve(NetworkRequestProcessorProtocol.self)!
    }
    
    public class func networkRequestFactory() -> NetworkRequestFactoryProtocol {
        return container.resolve(NetworkRequestFactoryProtocol.self)!
    }
}
