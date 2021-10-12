//
//  ViewCodeProtocol.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import Foundation

protocol ViewCodeProtocol: AnyObject {
    func loadViewCode()
    func addSubviews()
    func layoutHierarchy()
}

extension ViewCodeProtocol {
    
    func loadViewCode() {
        addSubviews()
        layoutHierarchy()
    }
}
