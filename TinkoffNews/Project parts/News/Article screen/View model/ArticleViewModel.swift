//
//  Copyright © 2017 HOKMT. All rights reserved.
//

import Foundation

//MARK: Enums
public enum ArticleViewModelState {
    case normal, loading, error(NSError), successful
}

public class ArticleViewModel {
    private let newsAccessor: NewsAccessorProtocol
    private var disposeBag = DisposeBag()

    private var article: Article? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.titleChanged?(self?.article?.title.withoutHTML)
                self?.dateChanged?(self?.article?.date.formattedDateString)
                self?.contentChanged?(self?.article?.content)
            }
        }
    }

    private var state: ArticleViewModelState = .normal {
        didSet {
            stateChanged?(state)
        }
    }

    //MARK: Bindings
    public var stateChanged: ((ArticleViewModelState) -> Void)?
    public var titleChanged: ((String?) -> Void)?
    public var dateChanged: ((String?) -> Void)?
    public var contentChanged: ((String?) -> Void)?

    //MARK: Init
    public init(newsAccessor: NewsAccessorProtocol) {
        self.newsAccessor = newsAccessor
    }

    public func set(articleID: Int) {
        loadArticle(id: articleID)
    }

    private func loadArticle(id: Int) {
        state = .loading
        newsAccessor.getArticle(id: id)
                .onSuccess { [weak self] article in
                    self?.article = article
                    self?.state = .successful
                }
                .onError { [weak self] error in
                    self?.state = .error(error as NSError)
                }
                .add(to: disposeBag)
    }
}
