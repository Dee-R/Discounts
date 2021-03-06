//
//  EngineDiscounts.swift
//  EngineDiscounts
//
//  Created by Eddy R on 29/11/2020.
//
import Foundation

// can have many implementation (iOS, iPad, iWatch, TVos )
public protocol EngineDiscountDelegate {
    func showResultWith(sum: Float, sumTax:Float)
}

public class EngineDiscounts {
    var items: [EngineDiscountsItem] = []
    var delegate: EngineDiscountDelegate! = nil
    
    
    public init(delegate: EngineDiscountDelegate, items: [EngineDiscountsItem]) {
        self.items = items
        self.delegate = delegate
    }
    public func calculateTotal() {
        if !items.isEmpty {
            var localPrices : Float = 0
            var localDiscount: Float = 0
            
            for i in 0...items.count-1 {
                localPrices += (items[i].price) - (items[i].price * (items[i].tax / 100))
                localDiscount += items[i].price * (items[i].tax / 100)
            }
            delegate.showResultWith(sum: localPrices, sumTax: localDiscount)
        }
    }
    public func calculateTotal(array:[EngineDiscountsItem]) {
        self.items = array
        calculateTotal()
    }
}
