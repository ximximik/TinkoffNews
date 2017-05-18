//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public class AssemblyCenter {
    
    private static let _shared = AssemblyCenter()
    public class var shared: AssemblyCenter {
        return _shared
    }
    
    private let _container: Container
    public static var container: Container {
        return _shared._container
    }

    private let assembler: Assembler
    
    //Init
    public init() {
        _container = Container()
        assembler = Assembler(container: _container)
        assembler.apply(assemblies: assemblies)
    }
    
    private var assemblies: [Assembly.Type] {
        return [NetworkAssembly.self,
                ServicesAssembly.self,
                NewsAssembly.self]
    }
    
    //Storyboard
    public static func createStoryboard(name: String) -> Storyboard {
        return Storyboard(name: name, bundle: nil, container: container)
    }
}

//MARK: Assemblies
extension AssemblyCenter {
    public func networkAssembly() -> NetworkAssembly.Type {
        return NetworkAssembly.self
    }
    
    public func servicesAssembly() -> ServicesAssembly.Type {
        return ServicesAssembly.self
    }
    
    public func newsAssembly() -> NewsAssembly {
        return NewsAssembly()
    }
}
