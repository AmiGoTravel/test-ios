import Foundation

struct RedditAPIRootModel: Decodable {
    let data: RedditDataModel
}

struct RedditDataModel: Decodable {
    let after: String
    let children: [ChildrenModel]
}

struct ChildrenModel: Decodable {
    let data: RedditChildrenData
}

struct RedditChildrenData: Decodable {
    let title: String
    let author: String
    let thumbnail: String
    let numComments: Int
    let created: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case thumbnail
        case numComments = "num_comments"
        case created
    }
}
