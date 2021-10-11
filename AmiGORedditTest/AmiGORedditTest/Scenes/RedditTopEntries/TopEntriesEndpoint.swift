import Foundation

enum TopEntriesEndPoint: ApiEndpoint {
    case topEntries
    
    var path: String {
        return "/top?limit=50"
    }
}
