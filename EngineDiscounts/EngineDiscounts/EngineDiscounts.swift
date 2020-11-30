//
//  EngineDiscounts.swift
//  EngineDiscounts
//
//  Created by Eddy R on 29/11/2020.
//

import Foundation



// can have many implementation (iOS, iPad, iWatch, TVos )
protocol EngineDiscountDelegate {
    func showResultWith(sum: Float)
}
// POLICE
class EngineDiscounts {
    var items: [Item]
    var delegate: EngineDiscountDelegate
    
    init(delegate: EngineDiscountDelegate, items: [Item]) {
        self.items = items
        self.delegate = delegate
    }
    func calculateTotal() {
        if !items.isEmpty {
            var localPrice : Float = 0
            var localDiscount: Float = 0
            for i in 0...items.count-1 {
                localPrice += (items[i].price) - (items[i].price * (items[i].tax / 100))
                localDiscount += (items[i].tax / 100)
            }
            delegate.showResultWith(sum: localPrice)
        }
    }
}
