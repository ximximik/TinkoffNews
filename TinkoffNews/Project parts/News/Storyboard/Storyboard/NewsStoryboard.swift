//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import UIKit

public class NewsStoryboard: Storyboard {
    public override class func storyboard() -> Storyboard {
        return AssemblyCenter.createStoryboard(name: "News")
    }
    
    public class func newsViewController() -> NewsViewController {
        return instantiate(NewsViewController.self)
    }

    public class func articleViewController() -> ArticleViewController {
        return instantiate(ArticleViewController.self)
    }
}
