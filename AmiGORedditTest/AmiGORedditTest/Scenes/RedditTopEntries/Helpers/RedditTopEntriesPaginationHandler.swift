import Foundation

final class RedditTopEntriesPaginationHandler {
    private(set) var cellControllers = [RedditTopEntryCellController]()
    private(set) var after = ""
    var shouldResetPagination = false
    private(set) var entriesList = [RedditChildrenData]() {
        didSet {
            cellControllers.append(contentsOf: entriesList.map { mapToController($0) })
        }
    }
    var entriesCount: Int {
        entriesList.count
    }
    
    private func mapToController(_ model: RedditChildrenData) -> RedditTopEntryCellController {
        let viewModel = RedditTopEntryCellViewModel(model: model)
        let controller = RedditTopEntryCellController(viewModel: viewModel)
        viewModel.controllerDelegate = controller
        return controller
    }
    
    func updatePagination(with rootModel: RedditAPIRootModel) {
        if shouldResetPagination {
            resetPagination()
        }
        let newEntries = rootModel.data.children.compactMap { $0.data }
        self.entriesList.append(contentsOf: newEntries)
        self.after = rootModel.data.after
    }
    
    func resetPagination() {
        cellControllers = []
        entriesList = []
        after = ""
        shouldResetPagination = false
    }
}
