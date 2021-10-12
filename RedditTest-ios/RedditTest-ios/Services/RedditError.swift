//
//  RedditError.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 21/09/21.
//

import Foundation

enum RedditError: String, Error {
    case invalidResponse = "The response from the server was invalid."
    case invalidData = "The data received from the server was invalid."
    case invalidId = "The ID sent to the server was invalid."
    case reloadError = "The reload sent to the server was invalid."
}
