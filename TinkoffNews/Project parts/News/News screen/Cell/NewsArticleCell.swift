//
//  Created by Danil Pestov on 19.05.17.
//  Copyright © 2017 HOKMT. All rights reserved.
//

import UIKit

public class NewsArticleCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    public static let estimatedHeight: CGFloat = 60

    public override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        titleLabel.text = ""
        dateLabel.text = ""
    }
    
    public func set(viewModel: NewsArticleCellViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
    }
}
