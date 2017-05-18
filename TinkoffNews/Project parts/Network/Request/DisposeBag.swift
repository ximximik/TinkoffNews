//
//  Created by Danil Pestov on 19.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol Disposable {
    func dispose()
    func addTo(_ disposeBag: DisposeBag)
}

open class DisposeBag {
    private var disposables: [Disposable] = []
    
    open func add(_ disposable: Disposable) {
        disposables.append(disposable)
    }
    
    deinit {
        for disposable in disposables {
            disposable.dispose()
        }
        disposables.removeAll(keepingCapacity: false)
    }
}

extension Disposable {
    public func addTo(_ disposeBag: DisposeBag) {
        disposeBag.add(self)
    }
}
