import Foundation

final class DataMapper {
    static func map<T: Decodable>(_ data: Data, from response: HTTPURLResponse) -> Result<T, ServiceError> {
        do {
            let items: T = try DataMapper.map(data, from: response)
            return .success(items)
        } catch {
            return .failure(.invalidData)
        }
    }
    
    private static func map<T: Decodable>(_ data: Data, from response: HTTPURLResponse) throws -> T {
        guard response.isOK,
              let decodedObject = try? JSONDecoder().decode(T.self, from: data) else {
            throw ServiceError.invalidData
        }
        
        return decodedObject
    }
}
