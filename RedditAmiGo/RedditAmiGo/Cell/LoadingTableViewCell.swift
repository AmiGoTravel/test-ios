//
//  LoadingTableViewCell.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 4/5/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    // Fiz essa classe como Code UI, como demonstração. No resto do projeto usei Storyboards e Xib's.
    
    let viewContainer = UIView(frame: .zero)
    let activity = UIActivityIndicatorView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        activity.style = .medium
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(viewContainer)
        viewContainer.addSubview(activity)
        
        NSLayoutConstraint.activate([
            viewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            activity.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 8),
            activity.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -8),
            activity.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            activity.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor)
            ])
    }
}
