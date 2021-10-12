//
//  ListViewModel.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import UIKit

protocol ListViewModelDelegate: AnyObject {
    func prepareDetails(for index: IndexPath) -> RedditEntryData
    func showError(error: RedditError)
}

class ListViewModel: BaseViewModelProtocol {
    
    var view: UIView
    let title: String = Texts.welcomeTitle
    var action: EnterAction?
    var listChildren: [RedditEntry]? = []
    var after: String?
    var hasMore: Bool = false

    weak var delegate: ListViewModelDelegate?
        
    init(view: UIView) {
        self.view = view
    }
    
    func bind() {
      
    }
    
    func fetchEntries(params: RedditRequest, completion: @escaping EnterAction) {
        let provider = APIProvider()
        let path = NetworkConstants.Path.new
        
        provider.getEntryList(params: params, path: path) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(data: let response):
                self.listChildren?.append(contentsOf: response.data?.children ?? [])
                self.after = response.data?.after
                self.hasMore = true
            case .failure(error: let error):
                DispatchQueue.main.async {
                    self.delegate?.showError(error: error)
                }
                self.hasMore = false
                return
            }
            completion()
        }
    }
    
    func setAction(_ action: @escaping () -> Void) {
        self.action = action
    }
}
