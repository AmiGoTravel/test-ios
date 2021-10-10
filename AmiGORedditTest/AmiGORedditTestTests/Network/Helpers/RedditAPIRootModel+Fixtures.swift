@testable import AmiGORedditTest

extension RedditAPIRootModel {
    static func fixture() -> RedditAPIRootModel {
        .init(data: RedditDataModel.fixture())
    }
}

extension RedditDataModel {
    static func fixture() -> RedditDataModel {
        .init(after: "anyString", children: [ChildrenModel.fixture()])
    }
}

extension ChildrenModel {
    static func fixture() -> ChildrenModel {
        .init(data: RedditChildrenData.fixture())
    }
}

extension RedditChildrenData {
    static func fixture() -> RedditChildrenData {
        .init(
            title: "anytitle",
            author: "anyAuthor",
            thumbnail: "anyThumbnail",
            numComments: 15,
            created: 1231.0
        )
    }
}
