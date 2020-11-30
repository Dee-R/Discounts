//
//  RowView.swift
//  Discounts
//
//  Created by Eddy R on 30/11/2020.
//

import UIKit
import Foundation
@IBDesignable
class RowView: UIView {
    
    @IBInspectable
    var corner: CGFloat = 30 {
        didSet {
            self.layer.cornerRadius = corner
        }
    }
    
    /**
     var mbackgroundColor: UIColor? {
         didSet {
            backgroundColor = mbackgroundColor
         }
     }
     */
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
