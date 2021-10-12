@testable import AmiGORedditTest

extension RedditAPIRootModel {
    static func fixture(after: String = "anyString") -> RedditAPIRootModel {
        .init(data: RedditDataModel.fixture(after: after))
    }
}

extension RedditDataModel {
    static func fixture(after: String) -> RedditDataModel {
        .init(after: after, children: [ChildrenModel.fixture(), ChildrenModel.fixture()])
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
            thumbnail: "https://anyThumbnail.com",
            numComments: 15,
            created: 1231.0
        )
    }
}
