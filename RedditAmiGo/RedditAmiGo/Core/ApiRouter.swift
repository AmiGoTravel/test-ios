//
//  ApiRouter.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Alamofire

enum HttpRequestRouter: URLRequestConvertible {
    case listEntries(EntryRequest)
    
    var path: String {
        switch self {
        case .listEntries:
            return Constants.HttpRequestURL.LIST_ENTRIES
        }
    }
    
    var queryItems: [String: Any]? {
        switch self {
        case .listEntries(let params):
            var items: [String: Any] = [:]
            if params.after != nil {
                items["after"] = params.after
            }
            if params.before != nil {
                items["before"] = params.before
            }
            if params.count != nil {
                items["count"] = params.count
            }
            if params.limit != nil {
                items["limit"] = "20"
            }
            
            return items
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .listEntries:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Constants.HttpRequestURL.BASE)!
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(path), cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
        
        mutableURLRequest.httpMethod = httpMethod.rawValue
        
        switch self
        {
        case .listEntries:
            return try Alamofire.URLEncoding.default.encode(mutableURLRequest, with: queryItems)
        }
    }
}

