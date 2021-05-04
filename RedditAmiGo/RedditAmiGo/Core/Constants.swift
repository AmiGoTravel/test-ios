//
//  Constants.swift
//  RedditAmiGo
//
//  Created by Leonardo Saganski on 3/5/21.
//

import Foundation

struct Constants {
    struct Colors {
        static let NAVY_BLUE = "#13245A"
        static let BLUE = "#0079AA"
        static let TEAL_BLUE = "#23B2C2"
        static let TAB_BAR_RED = "#CF2032"
        static let WHITE = "#FFFFFF"
        static let LIGHT_GREY_F5F5F5 = "#F5F5F5"
        static let DARK_GREY_494C57 = "#494C57"
        static let RED_CC092F = "#CC092F"
        static let DARK_BLUE_003B79 = "#003b79"
    }
    
    struct HttpRequestURL {
        static let BASE: String = "api.reddit.com/"
        static let LIST_ENTRIES: String = "new?limit=2"
    }
}
