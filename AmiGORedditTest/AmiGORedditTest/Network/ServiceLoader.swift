import Foundation

protocol ServiceLoader {
    func load<T: Decodable>(completion: @escaping (Result<T, ServiceError>) -> Void)
}
