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
    @IBOutlet weak var taxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 18
        self.priceTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        
        // controle input user while writting
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == decimalSeparator {
                let countdots = textField.text!.components(separatedBy:decimalSeparator).count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == decimalSeparator {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    

}
