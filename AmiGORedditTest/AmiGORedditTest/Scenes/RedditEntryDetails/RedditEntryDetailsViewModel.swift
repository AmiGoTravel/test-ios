import Foundation

protocol RedditEntryDetailsDelegate {
    func requestImage()
    var title: String { get }
}

final class RedditEntryDetailsViewModel {
    weak var controllerDelegate: RedditEntryDetailsViewProtocol?
    weak var coordinator: MainCoordinator?
    private let entryModel: RedditChildrenData
    private let imageLoader: ImageDataLoader
    
    init(entryModel: RedditChildrenData,
         imageLoader: ImageDataLoader = MainThreadDispatchDecorator(RemoteImageDataLoader())) {
        self.entryModel = entryModel
        self.imageLoader = imageLoader
    }
}

extension RedditEntryDetailsViewModel: RedditEntryDetailsDelegate {
    var title: String { entryModel.title }
    
    func requestImage() {
        guard let url = URL(string: entryModel.thumbnail) else { return }
        
        imageLoader.loadImageData(from: url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.controllerDelegate?.showThumbnailImage(data: data)
            case .failure:
                break
            }
        }
    }
}
