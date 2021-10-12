import UIKit

protocol RedditEntryDetailsViewProtocol: AnyObject {
    func showThumbnailImage(data: Data)
}

final class RedditEntryDetailsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: RedditEntryDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.requestImage()
        titleLabel.text = viewModel?.title
    }
}

extension RedditEntryDetailsViewController: RedditEntryDetailsViewProtocol {
    func showThumbnailImage(data: Data) {
        let image = UIImage(data: data)
        thumbnailImageView.image = image
    }
}
