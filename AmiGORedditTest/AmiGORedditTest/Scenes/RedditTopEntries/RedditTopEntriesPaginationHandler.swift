import Foundation

final class RedditTopEntriesPaginationHandler {
    private(set) var entriesList = [RedditChildrenData]()
    private(set) var after = ""
    var entriesCount: Int {
        entriesList.count
    }
    
    func updatePagination(with rootModel: RedditAPIRootModel) {
        let newEntries = rootModel.data.children.compactMap { $0.data }
        self.entriesList.append(contentsOf: newEntries)
        self.after = rootModel.data.after
        print(entriesList)
    }
}
