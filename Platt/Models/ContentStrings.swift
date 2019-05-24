//
//  ContentStrings.swift
//  Platt
//
//  Created by Jaden Nation on 5/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation

class ContactPageData: GenericPageData {
    var email: String = ""
}

class AboutPageData: GenericPageData {
    struct MovieRole: Codable {
        let role: String
        let movie: String
    }
    
    override var processedBody: String {
        let randomRole = roles.randomElement()!
        
        return ""
    }
    
    var roles: [MovieRole]!
}

//class ContentStrings: NSObject {
//    var pageData: [GenericPageData] = {
//      let file = URL(
//    }()
//    
//    
//}
