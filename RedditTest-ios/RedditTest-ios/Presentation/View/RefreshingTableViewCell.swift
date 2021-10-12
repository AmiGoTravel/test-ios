//
//  RefreshingTableViewCell.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import UIKit

class RefreshingTableViewCell: UITableViewCell {
   

    let photoPlaceHolder = UIView()
    
    let loaderSign : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.color = .redditOrange
        
        return loader
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadViewCode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewCode()
        
    }

    func glowColor() {
        photoPlaceHolder.backgroundColor = .redditWhite
        let opacity: Float = 0.15
        photoPlaceHolder.setGlow(radius: 5, opacity: opacity, color: [.redditWhite, .redditGray, .redditBlue, .black])
    }
}

extension RefreshingTableViewCell: ViewCodeProtocol {
    func addSubviews() {
        addSubview(photoPlaceHolder)
        addSubview(loaderSign)
    }
    
    func layoutHierarchy() {
        let verticalPattern = "V:|-8-[v0(64)]-8-|"
        let vertivalDefaultPattern = "V:|-[v0]-|"
        let horizontalDefaultPattern = "H:|-[v0]-|"
        let widthQuarter = frame.width / 4.0
 
        setUpContraints(pattern: verticalPattern, options: nil,
                        views: photoPlaceHolder)
        setUpContraints(pattern: "H:|-[v0(\(widthQuarter * 1.15))]",
                        options: nil, views: photoPlaceHolder)
        
        setUpContraints(pattern: horizontalDefaultPattern,
                        options: .alignAllCenterY, views: loaderSign)
        setUpContraints(pattern: vertivalDefaultPattern,
                        options: .alignAllCenterX, views: loaderSign)
    }
    
    func loadViewCode() {
        self.backgroundColor = .redditPurple
        self.photoPlaceHolder.alpha = 0.75
        
        glowColor()
        addSubviews()
        layoutHierarchy()
        accessibilityLabel = Texts.loading
    }
    
}
