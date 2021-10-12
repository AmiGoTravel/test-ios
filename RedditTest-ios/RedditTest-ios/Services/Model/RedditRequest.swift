//
//  RedditRequest.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

struct RedditRequest: Codable {
    var after: String?
    var before: String?
    var count: String?
    var limit: String?
    
    func getParams() -> [String: String] {
        
        var params: [String: String] = [:]
        if self.after != nil {
            params["after"] = self.after
        }
        if self.before != nil {
            params["before"] = self.before
        }
        if self.count != nil {
            params["count"] = self.count
        }
        if self.limit != nil {
            params["limit"] = self.limit
        }
        
        params["show"] = "all"
        
        return params
    }
}
