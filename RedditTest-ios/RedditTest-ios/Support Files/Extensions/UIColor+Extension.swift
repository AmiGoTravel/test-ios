//
//  UIColor+Extension.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

extension UIColor {
    
    // MARK: - Custom Setup

    static func fromHex(hexValue: UInt32) -> UIColor {
        let r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hexValue & 0x0000FF)) / 255.0
        let a = CGFloat(1.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Colors
    
    static var redditOrange: UIColor {
        return UIColor.fromHex(hexValue: 0xFF4500)
    }
    
    static var redditPurple: UIColor {
        return UIColor.fromHex(hexValue: 0xCEE3F8)
    }
    
    static var redditWhite: UIColor {
        return UIColor.fromHex(hexValue: 0xFAFAFA)
    }
    
    static var redditGray: UIColor {
        return UIColor.fromHex(hexValue: 0xD7D7D7)
    }
    
    static var redditBlue: UIColor {
        return UIColor.fromHex(hexValue: 0x5F99cf)
    }
    
}
