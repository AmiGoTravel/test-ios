import Foundation

protocol ApiEndpoint {
    var baseHost: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension ApiEndpoint {
    var baseHost: String { "api.reddit.com" }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseHost
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
}

