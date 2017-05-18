//
//  Created by Danil Pestov on 18.05.17.
//  Copyright © 2017 Danil Pestov. All rights reserved.
//

public class Assembler {
    private let container: Container
    
    public init(container: Container) {
        self.container = container
    }
    
    public func apply(assemblies: [Assembly.Type]) {
        for assembly in assemblies {
            assembly.assemble(container: container)
        }
    }
}
