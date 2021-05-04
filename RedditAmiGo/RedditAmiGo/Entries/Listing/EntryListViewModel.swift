//
//  EntryListViewModel.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

class EntryListViewModel: ViewModelProtocol {
    var list: [Entry] = []
    
    func fetchData(completion: @escaping (RequestStatus) -> Void) {
        let params = EntryRequest(after: "", before: "", count: "")
        ApiHelper.listEntries(params: params) {
            [weak self]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let items = data.data?.children, items.count > 0 {
                    self.list.append(contentsOf: items)
                    completion(.success)
                }
            case .failure(_):
                completion(.failure(error: "It was not possible to load data. Try again."))
            }
        }
    }
    
    func getByIndex(index: Int) -> EntryInfo? {
        return list[index].data
    }
}
