//
//  RequestResult.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

enum RequestResult<T: Codable> {
    case success(data: T)
    case failure(error: RedditError)
}

typealias ResponseCompletion = (RequestResult<RedditResponse>) -> Void
typealias DataCompletion = (Bool, Data?) -> Void
