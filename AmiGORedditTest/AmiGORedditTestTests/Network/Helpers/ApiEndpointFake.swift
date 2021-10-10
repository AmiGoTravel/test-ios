@testable import AmiGORedditTest

enum ApiEndpointFake: ApiEndpoint {
    case fake
    var path: String { "/path" }
}
