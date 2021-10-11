import Foundation

enum TopEntriesEndPoint: ApiEndpoint {
    case topEntries(after: String, count: Int)
    
    var path: String {
        guard case .topEntries(_,_) = self else { return "" }
        
        return "/top"
    }
    
    var queryItems: [URLQueryItem]  {
        guard case let .topEntries(after, count) = self else { return [] }
        
        guard !after.isEmpty,
              count != 0 else {
            return [URLQueryItem(name: "limit", value: "50")]
        }
        
        return [
            URLQueryItem(name: "limit", value: "50"),
            URLQueryItem(name: "count", value: String(count)),
            URLQueryItem(name: "after", value: after)
        ]
    }
}
