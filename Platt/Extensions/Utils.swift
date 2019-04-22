//
//  Utils.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/11/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit


func randomInt(upperBound: Int, min: Int = 0) -> Int {
    guard min < upperBound else {
        return upperBound
    }
    let availableInts = Array(min..<upperBound)
    return availableInts[Int(arc4random_uniform(UInt32(availableInts.count)))]
}


func fisherYatesShuffle<T>(arr: inout [T]) {
    for w in (0..<arr.count).reversed() {
        let random = Int(arc4random_uniform(UInt32(w > 0 ? arr.count : 0)))
        let holder = arr[random]
        arr[random] = arr[w]
        arr[w] = holder
    }
}
