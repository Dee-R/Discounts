//
//  DiscountsCell.swift
//  Discounts
//
//  Created by Eddy R on 30/11/2020.
//

import UIKit

@IBDesignable
class DiscountsCell: UITableViewCell {
    
    @IBOutlet weak var rowView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var taxButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        myicon = (self.contentView.viewWithTag(1) as! UIImageView)
        setup()
        priceTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    
    
    func setup() {
        rowView.layer.cornerRadius = 20
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
