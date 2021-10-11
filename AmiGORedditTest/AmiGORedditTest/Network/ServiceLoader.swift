import Foundation

protocol ServiceLoader {
    func load<T: Decodable>(apiEndpoint: ApiEndpoint, completion: @escaping (Result<T, ServiceError>) -> Void)
}
