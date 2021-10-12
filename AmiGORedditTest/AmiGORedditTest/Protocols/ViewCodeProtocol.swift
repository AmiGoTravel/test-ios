import Foundation

protocol ViewCodeProtocol {
    func buildViewHierarchy()
    func setupConstraints()
    func additionalSetup()
    func buildLayout()
}

extension ViewCodeProtocol {
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {}
}
