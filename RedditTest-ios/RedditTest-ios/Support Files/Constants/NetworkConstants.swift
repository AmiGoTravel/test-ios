//
//  NetworkConstants.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 20/09/21.
//

import Foundation

enum NetworkConstants {
    static let baseUrL =  "https://api.reddit.com"
    static let count = "50"
    
    enum Path {
        static let top = "/top"
        static let new = "/new"
        static let hot = "/hot"
        static let random = "/random"
        static let rising = "/rising"
    }
}

