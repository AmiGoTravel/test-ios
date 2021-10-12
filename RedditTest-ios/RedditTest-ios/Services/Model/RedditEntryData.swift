//
//  RedditEntryData.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

struct RedditEntryData: Codable {    
    var title: String?
    var author: String?
    var thumbnail: String?
    var commentsNumber: Int?
    var created: Float?
    
    private enum CodingKeys: String, CodingKey {
        case commentsNumber = "num_comments"
        case author = "author_fullname"
        case created = "created_utc"
        case thumbnail = "thumbnail"
        case title = "title"
    }
    
}
