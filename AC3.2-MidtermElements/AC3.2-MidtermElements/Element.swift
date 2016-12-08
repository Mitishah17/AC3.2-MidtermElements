//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Miti Shah on 12/8/16.
//  Copyright © 2016 Miti Shah. All rights reserved.
//

import Foundation

class Element {
    let name: String
    let symbol: String
    let weight: Int
    let number: Int
    let meltingPoint: Int?
    let boilingPoint: Int?
    let thumbnail: String
    let largestString: String
    
    init(name: String, symbol: String, weight: Int , number: Int, meltingPoint: Int?, boilingPoint: Int?, thumbnail: String, largestString: String) {
        self.name = name
        self.symbol = symbol
        self.weight = weight
        self.number = number
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
        self.thumbnail = thumbnail
        self.largestString = largestString
    }
}

