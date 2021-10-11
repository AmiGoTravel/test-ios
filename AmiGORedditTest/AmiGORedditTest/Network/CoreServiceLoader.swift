import Foundation

final class CoreServiceLoader {
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))) {
        self.client = client
    }
}

extension CoreServiceLoader: ServiceLoader {
    func load<T>(apiEndpoint: ApiEndpoint, completion: @escaping (Result<T, ServiceError>) -> Void) where T : Decodable {
        guard let url = apiEndpoint.urlComponents.url else {
            return completion(.failure(ServiceError.malformedURL))
        }
        
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                let mappedResult: Result<T, ServiceError> = DataMapper.map(data, from: response)
                completion(mappedResult)
            case .failure:
                completion(.failure(ServiceError.connectivity))
            }
            
        }
    }
}

enum ServiceError: Error {
    case connectivity
    case invalidData
    case malformedURL
}
