//
//  EntryDetailsViewModel.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

class EntryDetailsViewModel: ViewModelProtocol {
    var item: EntryInfo?

    func setItem(item: EntryInfo?) {
        self.item = item
    }
    
    func listEntries() {
        let params = EntryRequest(after: nil, before: nil, count: nil, limit: 20)
        ApiHelper.listEntries(params: params) {
            result in
            switch result {
            case .success(let data):
                let a = data
            case .failure(let error):
                let a = ""
            }
        }
    }
}
