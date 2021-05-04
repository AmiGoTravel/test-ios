//
//  ApiHelper.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation
import Alamofire

enum RequestStatus {
    case success
    case failure(error: String)
}

final class ApiHelper {
    // Fiz requests usando tanto Alamofire quanto URLSession, como demonstração.
    // Aqui fiz um método usando o Alamofire
    static func listEntries(params: EntryRequest, completion: @escaping (Result<EntryResponse, AFError>) -> Void) {
        let request = AF.request(HttpRequestRouter.listEntries(params))
        request.validate(statusCode: 200..<300)
        request.responseDecodable(of: EntryResponse.self) {
            response in
//            debugPrint(response)
            completion(response.result)
        }
    }
    
    // Aqui fiz um método usando URLSession
    static func getImage(fromUrl: String, completion: @escaping (Bool, Data?) -> Void) {
        guard let url = URL(string: fromUrl) else {
            completion(false, nil)
            return
        }

        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error != nil {
                completion(false, nil)
                return
            }
            
            guard let data = data else {
                completion(false, nil)
                return
            }
            
            completion(true, data)
        }.resume()
    }
}
