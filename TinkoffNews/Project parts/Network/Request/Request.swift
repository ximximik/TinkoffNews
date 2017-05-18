//
//  Created by Danil Pestov on 19.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

open class Request<T> {
    public typealias SuccessActions = (T) -> Void
    public typealias ErrorActions = (Error) -> Void
    
    open var dataTask: URLSessionDataTask?
    open var successActions: SuccessActions?
    open var errorActions: ErrorActions?
    
    init(urlRequest: URLRequest, handler: @escaping  ((Data) throws -> T)) {
        successActions = nil
        errorActions = nil
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.global(qos: .utility).async {
                guard let sSelf = self else { return }
                if let error = error {
                    sSelf.errorActions?(error)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let object = try handler(data)
                    sSelf.successActions?(object)
                } catch let parseError {
                    sSelf.errorActions?(parseError)
                }
            }
        }
        dataTask?.resume()
    }
    
    //MARK: -
    open func onSuccess(_ successActions: @escaping SuccessActions) -> Self {
        self.successActions = successActions
        return self
    }
    
    open func onError(_ errorActions: @escaping ErrorActions) -> Self {
        self.errorActions = errorActions
        return self
    }
}

extension Request: Disposable {
    open func dispose() {
        dataTask?.cancel()
        dataTask = nil
    }
}
