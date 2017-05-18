//
//  Created by Danil Pestov on 19/05/2017.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import UIKit

public class NewsViewController: UIViewController {
    typealias CellType = NewsArticleCell
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    public var viewModel: NewsViewModel!
    
    //MARK: Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        
        refreshData()
    }
    
    //MARK: Setups
    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = CellType.estimatedHeight
        setupRefreshControl()
    }
    
    private func setupBindings() {
        viewModel.stateChanged = { [weak self] state in
            guard let sSelf = self else { return }
            switch state {
            case .normal:
                sSelf.hideStatusHud()
                sSelf.refreshControl.endRefreshing()
            case .successful:
                sSelf.hideStatusHud()
                sSelf.refreshControl.endRefreshing()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .loading:
                sSelf.showStatusHud()
            case .error(let error):
                sSelf.hideStatusHud()
                sSelf.refreshControl.endRefreshing()
                sSelf.showAlert(with: error)
            }
        }
        
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Localization.News.reloadText)
        refreshControl.addTarget(self, action: #selector(NewsViewController.refreshData), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
    
    public func refreshData() {
        viewModel.getNews()
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.describing, for: indexPath)
        if let cell = cell as? CellType {
            cell.set(viewModel: viewModel.article(at: indexPath.row))
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
