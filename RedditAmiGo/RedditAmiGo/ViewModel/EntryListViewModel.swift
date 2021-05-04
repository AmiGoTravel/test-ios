//
//  EntryListViewModel.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

class EntryListViewModel: ViewModelProtocol {
    private var list: [Entry] = []
    private var before: String?
    private var after: String?
    private var count: Int?
    
    func fetchData(reload: Bool, completion: @escaping (RequestStatus) -> Void) {
        var params = EntryRequest(after: nil, before: nil, count: nil, limit: 20)
        if !reload {
            self.count = list.count
            params.after = self.after
            params.before = self.before
            params.count = self.count
        }
        ApiHelper.listEntries(params: params) {
            [weak self]
            result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let items = data.data?.children, items.count > 0 {
                    self.list.append(contentsOf: items)
                    self.after = data.data?.after
                    completion(.success)
                }
            case .failure(_):
                completion(.failure(error: "It was not possible to load data. Try again."))
            }
        }
    }
    
    func setItems(entries: [Entry]) {
        self.list = entries
    }
    
    func getItemByIndex(index: Int) -> EntryInfo? {
        return list[index].data
    }
    
    func getItemsCount() -> Int {
        return list.count
    }
}
