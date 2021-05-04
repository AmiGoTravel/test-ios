//
//  Entry.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

struct EntryRequest: Codable {
    var after: String?
    var before: String?
    var count: Int?
    var limit: Int?
}

struct EntryResponse: Codable {
    var kind: String?
    var data: EntryGroup?
}

struct EntryGroup: Codable {
    var children: [Entry]?
    var after: String?
    var before: String?
}

struct Entry: Codable {
    var kind: String?
    var data: EntryInfo?
}

struct EntryInfo: Codable {
    var id: String?
    var title: String?
    var author: String?
    var thumbnail: String?
    var num_comments: Int?
    var created: Double?
}

//
//kind: String,
//data: {
//    children: [{
//        kind: String,
//        data: {
//            id: String,
//            title : String
//            author : String
//            thumbnail : String
//            num_comments : Integer
//            created : Double
//        }
//    }],
//    after: String,
//    before: String
//}
