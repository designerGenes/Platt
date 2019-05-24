//
//  GenericPageData.swift
//  Platt
//
//  Created by Jaden Nation on 5/23/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation

protocol DetailsPageCopy: Codable {
    var title: String { get }
    var body: String { get }
}


class GenericPageData: NSObject, Codable, DetailsPageCopy {
    var title: String
    var body: String
    var processedBody: String {
        return body
    }
}

