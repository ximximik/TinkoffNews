//
//  Created by Danil Pestov on 14.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

public protocol Assembly {
    static func assemble(container: Container)
}

public extension Assembly {
    public static var container: Container {
        return AssemblyCenter.container
    }
}
