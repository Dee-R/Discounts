//
//  DiscountCell.swift
//  Discounts
//
//  Created by Eddy R on 01/12/2020.
//

import UIKit

class DiscountCell: UITableViewCell {

    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
