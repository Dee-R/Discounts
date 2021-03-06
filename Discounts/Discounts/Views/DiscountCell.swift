//
//  DiscountCell.swift
//  Discounts
//
//  Created by Eddy R on 01/12/2020.
//

import UIKit

class DiscountCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var discountButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 18
        self.priceTextField.delegate = self
    }
}
