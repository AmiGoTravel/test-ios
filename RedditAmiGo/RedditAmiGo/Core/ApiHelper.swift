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
    static func listEntries(params: EntryRequest, completion: @escaping (Result<EntryResponse, AFError>) -> Void) {
        let request = AF.request(HttpRequestRouter.listEntries(params))
        request.validate(statusCode: 200..<300)
        request.responseDecodable(of: EntryResponse.self) {
            response in
            debugPrint(response)
            completion(response.result)
        }
    }
}
