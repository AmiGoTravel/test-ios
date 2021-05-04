//
//  Loading.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 4/5/21.
//

import Foundation
import UIKit

class Loading {
    
    var indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var background = UIView()
    
    init(view: UIView) {
        setupUI(view)
    }
    
    func setupUI(_ view: UIView) {
        self.background = UIView(frame: UIScreen.main.bounds)
        self.background.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.indicator.center = view.center
        self.background.addSubview(self.indicator)
        view.addSubview(self.background)
    }
    
    func start() {
        self.indicator.startAnimating()
    }
    
    func stop() {
        self.background.removeFromSuperview()
        self.indicator.stopAnimating()
    }
}

