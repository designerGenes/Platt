//
//  Utils.swift
//  MostFamiliar
//
//  Created by Jaden Nation on 4/11/19.
//  Copyright © 2019 Designer Jeans. All rights reserved.
//

import Foundation
import UIKit


func randomInt(high: Int, low: Int = 0) -> Int {
    return low + Int(arc4random_uniform(UInt32(high - low)))
}

func randomPercent(low: Double = 0) -> Double {
    return low + Double((randomInt(high: 101, low: 0)) - Int(low * 100)) / 100
}

func fisherYatesShuffle<T>(arr: inout [T]) {
    for w in (0..<arr.count).reversed() {
        let random = Int(arc4random_uniform(UInt32(w > 0 ? arr.count : 0)))
        let holder = arr[random]
        arr[random] = arr[w]
        arr[w] = holder
    }
}
