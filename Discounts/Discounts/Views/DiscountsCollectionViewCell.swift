//
//  DiscountsCollectionViewCell.swift
//  Discounts
//
//  Created by Eddy R on 15/12/2020.
//

import UIKit

class DiscountsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var taxButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 18
        taxButton.titleLabel?.numberOfLines = 1
        taxButton.titleLabel?.adjustsFontSizeToFitWidth = true
        taxButton.titleLabel?.lineBreakMode = .byClipping //<-- MAGIC LINE
    }
}
