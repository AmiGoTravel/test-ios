import Foundation

final class RedditEntryDetails {
    weak var controllerDelegate: RedditEntryDetailsViewProtocol?
    weak var coordinator: MainCoordinator?
    private let entryModel: RedditChildrenData
    
    init(entryModel: RedditChildrenData) {
        self.entryModel = entryModel
    }
}
