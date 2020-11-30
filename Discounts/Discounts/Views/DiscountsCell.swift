//
//  DiscountsCell.swift
//  Discounts
//
//  Created by Eddy R on 30/11/2020.
//

import UIKit

@IBDesignable
class DiscountsCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var viewRow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        myicon = (self.contentView.viewWithTag(1) as! UIImageView)
        setup()
    }
    
    
    
    func setup() {
        iconImageView.alpha = 1
        viewRow.layer.cornerRadius = 25
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
