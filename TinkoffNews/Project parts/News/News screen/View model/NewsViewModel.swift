//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

//MARK: Enums
public enum NewsViewModelState {
    case normal, loading, error(NSError), successful, cachedDataLoaded
}

//MARK: ViewModel
public class NewsViewModel: NewsViewModelsStorage {
    private let newsAccessor: NewsAccessorProtocol
    private var disposeBag = DisposeBag()
    private var articles: [Article] = []
    
    public var cachedViewModels: [Int: NewsArticleCellViewModel] = [:]
    private lazy var cacheOperations: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Cache queue"
        queue.qualityOfService = .background
        queue.maxConcurrentOperationCount = 2
        return queue
    } ()
    
    private var state: NewsViewModelState = .normal {
        didSet {
            stateChanged?(state)
        }
    }
    
    //MARK: Bindings
    public var stateChanged: ((NewsViewModelState) -> Void)?
    
    //MARK: Init
    public init(newsAccessor: NewsAccessorProtocol) {
        self.newsAccessor = newsAccessor
    }
    
    public func getNews() {
        guard state != .loading else { return }
        
        state = .loading
        newsAccessor.getNews()
            .onCache { [weak self] articles in
                guard let sSelf = self else { return }
                if sSelf.articles.count == 0 {
                    sSelf.articles = articles
                    sSelf.cacheOperations.cancelAllOperations()
                    sSelf.prefetchViewModels()
                    sSelf.state = .cachedDataLoaded
                }
            }
            .onSuccess { [weak self] articles in
                guard let sSelf = self else { return }
                let sortedArticles = articles.sorted { $0.date > $1.date }
                sSelf.cachedViewModels.removeAll()
                sSelf.articles = sortedArticles
                sSelf.cacheOperations.cancelAllOperations()
                sSelf.prefetchViewModels()
                sSelf.state = .successful
            }
            .onError { [weak self] error in
                self?.state = .error(error as NSError)
            }
            .add(to: disposeBag)
    }
    
    //MARK: Datasource
    public func article(at index: Int) -> NewsArticleCellViewModel {
        let article = articles[index]
        if let viewModel = cachedViewModels[article.id] {
            return viewModel
        }
        let viewModel = NewsArticleCellViewModel(model: article)
        cachedViewModels[article.id] = viewModel
        return viewModel
    }
    
    public func numberOfArticles() -> Int {
        return articles.count
    }
    
    public func prefetchViewModels() {
        for model in articles {
            if cachedViewModels[model.id] == nil {
                cacheOperations.addOperation(CacheOperation(model: model, storage: self))
            }
        }
    }

    public func configure(articleViewModel: ArticleViewModel, at index: Int) {
        let article = articles[index]
        articleViewModel.set(articleID: article.id)
    }
}

extension NewsViewModelState: Equatable { }

public func == (lhs: NewsViewModelState, rhs: NewsViewModelState) -> Bool {
    switch (lhs, rhs) {
    case (.normal, .normal):
        return true
    case (.successful, .successful):
        return true
    case (.cachedDataLoaded, .cachedDataLoaded):
        return true
    case (.loading, .loading):
        return true
    default:
        return false
    }
}
