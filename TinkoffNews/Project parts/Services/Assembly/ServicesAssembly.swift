//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public class ServicesAssembly: Assembly {
    
    public class func assemble(container: Container) {
        //AppearanceAdjuster
        container.register(AppearanceAdjuster.self) { _ in
            AppearanceAdjusterDefault()
        }
    }
    
    public class func appearanceAdjuster() -> AppearanceAdjuster {
        return container.resolve(AppearanceAdjuster.self)!
    }
}
