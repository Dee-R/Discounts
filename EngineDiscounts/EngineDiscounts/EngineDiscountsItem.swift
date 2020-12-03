//
//  Item.swift
//  EngineDiscounts
//
//  Created by Eddy R on 29/11/2020.
//

import Foundation

public struct EngineDiscountsItem {
    public var price: Float = 0
    public var tax: Float = 0
    
    public init(price: Float = 0, tax: Float = 0) {
        self.price = price
        self.tax = tax
    }
    
}
