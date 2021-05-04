//
//  Entry.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

struct EntryRequest: Codable {
    var after: String
    var before: String
    var count: String
}

struct EntryResponse: Codable {
    var kind: String
    var data: Entry
}

struct Entry: Codable {
    var children: [EntryInfo]
    var after: String
    var before: String
}

struct EntryInfo: Codable {
    var kind: String
    var data: EntryDetails
}

struct EntryDetails: Codable {
    var id: String
    var title: String
    var author: String
    var thumbnail: String
    var num_comments: Int
    var created: Double
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
