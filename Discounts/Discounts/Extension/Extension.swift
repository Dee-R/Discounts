//
//  Extension.swift
//  Discounts
//
//  Created by Eddy R on 16/12/2020.
//

import Foundation

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
