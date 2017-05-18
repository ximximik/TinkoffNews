//
//  Created by Danil Pestov on 18.05.17.
//  Copyright © 2017 Danil Pestov. All rights reserved.
//

import Foundation

public protocol Resolver {
    func resolve<Service>(_ serviceType: Service.Type) -> Service?
    func resolveInjection<Service>(_ service: Service)
}

public typealias ServiceFactory = ((Resolver) -> Any)
public typealias ServiceInjection = ((Resolver, Any) -> Void)

open class Container {
    
    fileprivate var services: [String : ServiceFactory] = [:]
    fileprivate var injections: [String : ServiceInjection] = [:]
    
    public func register<Service>(_ serviceType: Service.Type, factory: @escaping ServiceFactory) {
        let key = String(describing: serviceType)
        services[key] = factory
    }
    
    public func register<Service>(_ serviceType: Service.Type, injection: @escaping ServiceInjection) {
        let key = String(describing: serviceType)
        injections[key] = injection
    }
}

extension Container: Resolver {
    
    public func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        let key = String(describing: serviceType)
        if let serviceFactory = services[key] {
            return serviceFactory(self) as? Service
        }
        return nil
    }
    
    public func resolveInjection<Service>(_ service: Service) {
        let key = String(describing: Service.self)
        if let serviceInjection = injections[key] {
            serviceInjection(self, service)
        }
    }
}
