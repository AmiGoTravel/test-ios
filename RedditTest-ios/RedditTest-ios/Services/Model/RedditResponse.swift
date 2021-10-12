//
//  RedditResponse.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

struct RedditResponse: Codable {    
    var kind: String?
    var data: RedditEntryList?
}
