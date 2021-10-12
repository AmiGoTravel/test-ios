//
//  UIFont+Extension.swift
//  RedditTest-ios
//
//  Created by Stefan V. de Moraes on 19/09/21.
//

import UIKit

extension UIFont {
    
    enum CustomFont {
        static let gillSans = "GillSans"
        static let helveticaOblique = "Helvetica-Oblique"
        static let helveticaNeue = "HelveticaNeue"
        static let verdana = "Verdana"
    }

    
    enum PatternSize {
        case title
        case text
        case info
        case draft
        case comment
        case nano
        
        func setFontPatternSize() -> CGFloat {
            switch self {
            case .title:
                return 22.0
            case .text:
                return 14.0
            case .draft:
                return 18.0
            case .info:
                return 16.0
            case .comment:
                return 12.0
            case .nano:
                return 8.0
            }
        }
    }
    
    class func getHelveticaNeue(for pattern: PatternSize) -> UIFont {
        let size: CGFloat = pattern.setFontPatternSize()

        return UIFont(name: CustomFont.helveticaNeue, size: size)
            ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    class func getHelveticaOblique(for pattern: PatternSize) -> UIFont {
        let size: CGFloat = pattern.setFontPatternSize()
        
        return UIFont(name: CustomFont.helveticaOblique, size: size)
            ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    class func getGillSans(for pattern: PatternSize) -> UIFont {
        let size: CGFloat = pattern.setFontPatternSize()

        return UIFont(name: CustomFont.gillSans, size: size)
            ?? UIFont.italicSystemFont(ofSize: size)
    }
  
    class func getVerdana(for pattern: PatternSize) -> UIFont {
        let size: CGFloat = pattern.setFontPatternSize()

        return UIFont(name: CustomFont.verdana, size: size)
            ?? UIFont.boldSystemFont(ofSize: size)
    }
}
