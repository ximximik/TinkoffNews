//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

//MARK: Enums
public enum NewsViewModelState {
    case normal, loading, error(NSError), successful
}

//MARK: ViewModel
public class NewsViewModel {
    private let newsAccessor: NewsAccessorProtocol
    private var disposeBag = DisposeBag()
    private var articles: [Article] = []
    private var cachedViewModels: [Int: NewsArticleCellViewModel] = [:]
    
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
            .onSuccess { [weak self] articles in
                self?.cachedViewModels.removeAll()
                self?.articles = articles
                self?.state = .successful
            }
            .onError { [weak self] error in
                self?.state = .error(error as NSError)
            }
            .addTo(disposeBag)
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
    
}

extension NewsViewModelState: Equatable { }

public func == (lhs: NewsViewModelState, rhs: NewsViewModelState) -> Bool {
    switch (lhs, rhs) {
    case (.normal, .normal):
        return true
    case (.successful, .successful):
        return true
    case (.loading, .loading):
        return true
    default:
        return false
    }
}
