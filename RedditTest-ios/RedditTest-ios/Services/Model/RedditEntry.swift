//
//  RedditEntry.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

struct RedditEntry: Codable {
    var kind: String?
    var data: RedditEntryData?
}

struct RedditEntryList: Codable {
    var children: [RedditEntry]?
    var after: String?
    var before: String?
}
