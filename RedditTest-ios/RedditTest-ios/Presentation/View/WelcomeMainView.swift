//
//  WelcomeMainView.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

class WelcomeMainView: UIView {

    weak var viewModel: BaseViewModelProtocol?

    private(set) lazy var welcomeLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = UIFont.getGillSans(for: .title)
        label.textColor = .black
        label.shadowColor = .redditPurple
        label.textAlignment = .center
        label.insertLine(width: 1.0, color: .redditOrange)

        return label
    }()
    
    private(set) lazy var enterButton: UIButton = {
        
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = true
        button.setTitle(Texts.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.getHelveticaNeue(for: .draft)
        button.backgroundColor = .redditOrange
        button.setTitleColor(UIColor.redditWhite, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.showsTouchWhenHighlighted = true
        button.layer.cornerRadius = 6.0
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewCode()
        backgroundColor = .redditWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(with viewModel: BaseViewModelProtocol) {
        self.viewModel = viewModel
        enterButton.addTarget(self, action: #selector(didTapEnter),
                              for: .touchUpInside)
    }
    
    func setTitle(_ text: String) {
        welcomeLabel.text = text
    }
    
    @objc
    func didTapEnter() {
        (viewModel?.action ?? { })()
    }
}

extension WelcomeMainView: ViewCodeProtocol {
    func addSubviews() {
        addSubview(welcomeLabel)
        addSubview(enterButton)
    }
    
    func layoutHierarchy() {
        let verticalPattern = "V:|-72-[v0(28)]-64-[v1(48)]-72-|"
        let horizontalPattern = "H:|-64-[v0]-64-|"
        
        setUpContraints(pattern: verticalPattern, options: .alignAllCenterX,
                        views: welcomeLabel, enterButton)
        setUpContraints(pattern: horizontalPattern, options: .alignAllCenterY,
                        views: welcomeLabel)
        setUpContraints(pattern: horizontalPattern, options: .alignAllCenterY,
                        views: enterButton)

    }
}
