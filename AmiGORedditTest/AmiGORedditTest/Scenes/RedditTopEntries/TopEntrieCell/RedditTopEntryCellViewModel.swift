import Foundation

final class RedditTopEntryCellViewModel {
    private let model: RedditChildrenData
    private let imageLoader: ImageDataLoader
    private var task: ImageDataLoaderTask?
    weak var controllerDelegate: RedditTopEntryCellControllerDelegate?
    
    init(model: RedditChildrenData,
         imageLoader: ImageDataLoader = MainThreadDispatchDecorator(RemoteImageDataLoader())) {
        self.model = model
        self.imageLoader = imageLoader
    }
    
    
    func requestImage() {
        guard let url = URL(string: self.model.thumbnail) else { return }
       
        let model = self.model
        controllerDelegate?.didStartLoadingImage(for: model)
        task = imageLoader.loadImageData(from: url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.controllerDelegate?.presentImageDate(with: data, for: model)
            case .failure:
                self?.controllerDelegate?.presentWithDefaultImage(for: model)
            }
        }
    }
    
    func cancelImageRequest() {
        task?.cancel()
    }
}
