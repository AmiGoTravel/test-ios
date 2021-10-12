//
//  String+Extension.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 22/09/21.
//

import Foundation


extension String {
    
    static func secondsToLocal(value: Float) -> String {
        
        let epochTime = TimeInterval(value) / 1000.0
        let date = Date(timeInterval: epochTime, since: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current

        dateFormatter.dateFormat = "yyyy H:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
}
