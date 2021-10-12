//
//  APIRequest.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation


import UIKit

class APIRequest: NSMutableURLRequest {
        
    convenience init?(requestMethod: Method, urlString: String, path: String, bodyParams: [String: String]? = nil) {
        
        guard let url = URL(string: urlString),
              var urlComponents =  URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = bodyParams?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
                
        urlComponents.path = path
        guard let NewUrl = urlComponents.url  else { return nil }
        
        self.init(url: NewUrl)
        
        self.httpMethod = requestMethod.rawValue
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}
