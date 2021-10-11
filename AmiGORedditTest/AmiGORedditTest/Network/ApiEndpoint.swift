import Foundation

protocol ApiEndpoint {
    var baseURL: URL { get }
    var path: String { get }
}

extension ApiEndpoint {
    var baseURL: URL { URL(string: "https://api.reddit.com")! }
    
    var absoluteStringUrl: String {
        let basePathString = baseURL.absoluteString
        let safePath = path.starts(with: "/") || path.isEmpty ? path : "/\(path)"
        return "\(basePathString)\(safePath)"
    }
}

