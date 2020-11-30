    //
//  TaxButton.swift
//  Discounts
//
//  Created by Eddy R on 30/11/2020.
//

import UIKit
@IBDesignable
class TaxButton: UIButton {
    @IBInspectable
    var mbackgroundColor: UIColor? {
        didSet {
            backgroundColor = mbackgroundColor
        }
    }

}
