//
//  DiscountsFooterCell.swift
//  Discounts
//
//  Created by Eddy R on 02/12/2020.
//

import UIKit

class DiscountsFooterCell: UITableViewCell {

    @IBOutlet weak var mainRow: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }

    func setup() {
        mainRow.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
