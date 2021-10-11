import UIKit

protocol RedditEntryDetailsViewProtocol: AnyObject {
    
}

final class RedditEntryDetailsViewController: UIViewController, Storyboarded {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}

extension RedditEntryDetailsViewController: RedditEntryDetailsViewProtocol {
    
}
