import UIKit

protocol RedditTopEntryCellControllerDelegate: AnyObject {
    func didStartLoadingImage(for model: RedditChildrenData)
    func presentImageData(with data: Data, for model: RedditChildrenData)
    func presentWithDefaultImage(for model: RedditChildrenData)
    func presentError()
}


final class RedditTopEntryCellController {
    private var cell: RedditTopEntryCell?
    private let viewModel: RedditTopEntryCellViewModel
    
    init(viewModel: RedditTopEntryCellViewModel) {
        self.viewModel = viewModel
    }
    
    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        viewModel.requestImage()
        return cell!
    }
    
    func preload() {
        viewModel.requestImage()
    }
    
    
    func cancelLoad() {
        releaseCellForReuse()
        viewModel.cancelImageRequest()
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
    
    func display(_ model: RedditChildrenData?, image: UIImage? = nil) {
        cell?.authorLabel.text = model?.author
        cell?.titleLabel.text = model?.title
        cell?.numOfCommentsLabel.text = "Comments: \(model?.numComments ?? 0)"
        cell?.entryDateLabel.text = "\(model?.hoursDiff() ?? 0) hours ago"
        cell?.thumbnailImageView.image = image
    }
}

extension RedditTopEntryCellController: RedditTopEntryCellControllerDelegate {
    func didStartLoadingImage(for model: RedditChildrenData) {
        cell?.loadingIndicator.startAnimating()
        cell?.loadingIndicator.isHidden = false
        display(model)
    }
    
    func presentImageData(with data: Data, for model: RedditChildrenData) {
        cell?.loadingIndicator.isHidden = true
        let thumbImage = UIImage(data: data)
        display(model, image: thumbImage)
    }
    
    func presentWithDefaultImage(for model: RedditChildrenData) {
        display(model)
    }
    
    func presentError() {
        print("presentError")
    }
}

private extension RedditChildrenData {
    func hoursDiff() -> Int {
        let entryDate = Date(timeIntervalSince1970: created)
        let diffComponents = Calendar.current.dateComponents([.hour], from: entryDate, to: Date())
        let hours = diffComponents.hour
        return hours ?? 0
    }
}
