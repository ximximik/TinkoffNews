//
//  CacheOperation.swift
//  TinkoffNews
//
//  Created by Danil Pestov on 19.05.17.
//  Copyright © 2017 Danil Pestov. All rights reserved.
//

import Foundation

public protocol NewsViewModelsStorage: class {
    var cachedViewModels: [Int: NewsArticleCellViewModel] { get set }
}

public class CacheOperation: Operation {
    public let model: Article
    public weak var storage: NewsViewModelsStorage?
    
    public init(model: Article, storage: NewsViewModelsStorage) {
        self.model = model
        self.storage = storage
    }
    
    public override func main() {
        guard !checkIsCancelled() else { return }
        
        let viewModel = NewsArticleCellViewModel(model: model)
        
        guard !checkIsCancelled() else { return }
        
        guard let storage = storage else { return }
        
        storage.cachedViewModels[model.id] = viewModel
    }
    
    private func checkIsCancelled() -> Bool {
        guard !isCancelled, let storage = storage, storage.cachedViewModels[model.id] == nil else {
            return true
        }
        return false
    }
}
