//
//  EntryListTableViewCell.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 4/5/21.
//

import UIKit

class EntryListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblNumComments: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgThumb: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(title: String?, author: String?, thumbnail: String?, numComments: Int?, date: Double?) {
        lblTitle.text = title ?? ""
        lblAuthor.text = author ?? ""
        lblNumComments.text = "\(numComments ?? 0)"
        let now = Int(Date().timeIntervalSince1970)
        let diff = Int(date ?? 0) - now
        let hours = diff / 3600
        lblDate.text = "\(hours)"
        ApiHelper.getImage(fromUrl: thumbnail ?? "") {
            [weak self]
            success, data in
            guard let self = self else { return }
            if success {
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imgThumb.image = image
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.imgThumb.image = #imageLiteral(resourceName: "ph")
                }
            }
        }
    }
}
