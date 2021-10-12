//
//  RedditListTableViewCell.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 20/09/21.
//

import UIKit

class RedditListTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var thumbnailView: UIImageView?
    
    @IBOutlet private(set) weak var titleLabel: UILabel?
    
    @IBOutlet private(set) weak var authorLabel: UILabel?
    
    @IBOutlet private(set) weak var commentsLabel: UILabel?
    
    @IBOutlet private(set) weak var entryDateLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with data: RedditEntryData) {
        self.backgroundColor = .redditPurple
        thumbnailView?.image = UIImage(named: AppIdentifiers.defaultThumbnail)
        
        if let imageUrl = data.thumbnail, data.thumbnail != nil {
            thumbnailView?.imageFromURL(imageUrl)
        }
        
        let title = data.title ?? String()
        titleLabel?.text = title
        
        let author = data.author ?? String()
        authorLabel?.text = author
        
        let comments = data.commentsNumber ?? Int.zero
        commentsLabel?.text = "comments: \(comments)"
        
        let seconds = (data.created?.rounded() ?? Float.zero)
        let entryDate = String.secondsToLocal(value: seconds)
        entryDateLabel?.text = "date: \(entryDate)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
}
