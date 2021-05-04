//
//  File.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

class EntryListViewModel {
    func listEntries() {
        let params = EntryRequest(after: "", before: "", count: "")
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
