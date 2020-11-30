//
//  DIscountsTableViewCell.swift
//  Discounts
//
//  Created by Eddy R on 30/11/2020.
//

import UIKit
class DIscountsTableViewCell: UITableViewCell {

    @IBOutlet weak var Tax: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
