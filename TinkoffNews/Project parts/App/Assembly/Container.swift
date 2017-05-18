//
//  Created by Danil Pestov on 18.05.17.
//  Copyright © 2017 Danil Pestov. All rights reserved.
//

import Foundation

open class ServiceEntry<Service> {
    fileprivate let serviceType: Service.Type
    open let factory: Any
    
    public init(serviceType: Service.Type, factory: Any) {
        self.serviceType = serviceType
        self.factory = factory
    }
}

public protocol Resolver {
    func resolve<Service>(_ serviceType: Service.Type) -> Service?
    func resolveInjection<Service>(_ service: Service)
}

open class Container {
    
    fileprivate var services: [String : Any] = [:]
    fileprivate var injections: [String : Any] = [:]
    
    public func register<Service>(_ serviceType: Service.Type, factory: @escaping (Resolver) -> Service) {
        let key = String(describing: serviceType)
        services[key] = factory
    }
    
    public func registerInjection<Service: Any>(_ serviceType: Service.Type, injection: @escaping (Resolver, Service) -> Void) {
        let key = String(describing: serviceType)
        injections[key] = injection
    }
}

extension Container: Resolver {
    
    public func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        let key = String(describing: serviceType)
        if let serviceFactory = services[key] as? (Resolver) -> Service {
            return serviceFactory(self)
        }
        return nil
    }
    
    public func resolveInjection<Service>(_ service: Service) {
        let key = String(describing: Service.self)
        if let serviceInjection = injections[key] as? (Resolver, Service) -> Void {
            serviceInjection(self, service)
        }
    }
}
