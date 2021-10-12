//
//  APIProvider.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

protocol APIProviderProtocol {
    func getEntryList(params: RedditRequest, path: String,
                      completion: @escaping ResponseCompletion)
}

class APIProvider: APIProviderProtocol {
        
    func getEntryList(params: RedditRequest, path: String, completion: @escaping ResponseCompletion) {
        let endpoint =  NetworkConstants.baseUrL
        
        guard let request = APIRequest(requestMethod: .GET, urlString: endpoint, path: path, bodyParams: params.getParams()) as URLRequest? else { return }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                return completion(.failure(error: .invalidResponse))
            }
            
            guard let data = data else {
                return completion(.failure(error: .invalidData))
            }
                        
            guard let responseResultData = try? JSONDecoder().decode(RedditResponse.self, from: data) else {
                return completion(.failure(error: .invalidResponse))
            }
            return completion(.success(data: responseResultData))
            
        }.resume()
    }
}
