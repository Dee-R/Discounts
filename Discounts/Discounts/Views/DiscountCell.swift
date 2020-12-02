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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // Initialization code
        bgView.layer.cornerRadius = 18
        self.priceTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    
    
   

}
