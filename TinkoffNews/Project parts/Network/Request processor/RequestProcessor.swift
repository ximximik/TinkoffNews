//
// Created by Danil Pestov on 18.05.17.
// Copyright (c) 2017 HOKMT. All rights reserved.
//

import Foundation

public protocol NetworkRequestProcessorProtocol {
    func process<T>(request: URLRequest, handler: @escaping  ((Data) throws -> T),
                 onSuccess: @escaping (T) -> Void,
                 onError: @escaping (Error) -> Void) -> URLSessionDataTask
}

open class NetworkRequestProcessor: NetworkRequestProcessorProtocol {
    
    open func process<T>(request: URLRequest, handler: @escaping  ((Data) throws -> T),
                      onSuccess: @escaping (T) -> Void,
                      onError: @escaping (Error) -> Void) -> URLSessionDataTask {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                onError(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let object = try handler(data)
                onSuccess(object)
            } catch let parseError {
                onError(parseError)
            }
            
        }
        dataTask.resume()
        return dataTask
    }
}
