import UIKit

final class LoadingFooterView: UIView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    init() {
        super.init(frame: .zero)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LoadingFooterView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        activityIndicator.constraint { view in
            [view.centerXAnchor.constraint(equalTo: centerXAnchor),
             view.topAnchor.constraint(equalTo: topAnchor),
             view.bottomAnchor.constraint(equalTo: bottomAnchor)]
        }
    }
}
