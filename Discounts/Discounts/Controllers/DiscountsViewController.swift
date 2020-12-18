//
//  DiscountViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.

import UIKit
import EngineDiscounts
import Combine

class DiscountsViewController: UIViewController {
    // MARK: - 🉑 Setting PROPERTIES
    // Combine
    private let notificationCenter = NotificationCenter.default
    private var subscriberCancellable = Set<AnyCancellable>() // list of subscriber cancel (row)
    private var setOfCancellable = Set<AnyCancellable>() // list of subscriber cancel (data)
    @Published var items : [EngineDiscountsItem] = [] // Model
    
    // UITableViewDelegate
    @IBOutlet weak var tableView: UITableView!
    private let reuseIdentifierCell = "cell"
    private let reuseIdentifierFooter = "DiscountFooter"
    var totalPrice: Float = 0
    var totalTaxPrice: Float = 0
    var isEditingRow = false
    var footerCell: DiscountsFooterCell? = nil
    
    //Passing Button Cliked to DiscountCollectionViewController
    var tagIdButtonCliked: Int?
    
    // Others
    var engineDiscount: EngineDiscounts?
    
    // MARK: - ⚙️ Init
    required init?(coder: NSCoder) {
        super.init(coder: coder) // executed thx to ib
        engineDiscount = EngineDiscounts(delegate: self, items: items)
        engineDiscount?.calculateTotal()
        
    }
    
    // MARK: - ✅ Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleNavigationBar()
        hideNavigationBar()
        setupDragAndDropCell()
        populateArrayOfItem()
        setupDismissKeyboardButton()
        setupFooterTableView() // get data for binding
        binding() // bind data and ui
    }
    
    // MARK: - 💻 Own M - SETUP
    fileprivate func setupTitleNavigationBar() {
        self.title = "Discounts"
    }
    fileprivate func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    fileprivate func populateArrayOfItem() {
        // set array of item by default to 1
        if items.count == 0 {
            items.append(EngineDiscountsItem())
        }
    }
    fileprivate func setupDismissKeyboardButton() {
        // when tap on the view => dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.reloadData()
    }
    @objc fileprivate func dismissKeyboard() {
        // fire the dismiss
        view.endEditing(true)
        isEditingRow = false
    }
    fileprivate func setupDragAndDropCell() {
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    fileprivate func setupFooterTableView() {
        footerCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierFooter) as? DiscountsFooterCell
        footerCell?.totalToPay.text = "0.0 €" // set default Value
        footerCell?.totalDiscounts.text = "0.0 €" // set default Value
    }
    fileprivate func binding() {
        // MARK: - p: items s:Footer
        $items
            .receive(on: DispatchQueue.main)
            .sink { (fail) in
                print(fail)
            } receiveValue: { [weak self] (arrItem) in
                guard let this = self else { return }
                this.engineDiscount?.calculateTotal(array: this.items)
                
                // footer cell configuration
                let totalDiscountPriceFormatedString = NSString(format: "%.2f", this.totalTaxPrice) as String
                this.footerCell?.totalDiscounts.text = this.totalTaxPrice == 0.00 ?  "\(totalDiscountPriceFormatedString) €" :  "-\(totalDiscountPriceFormatedString) €"
                this.footerCell?.totalToPay.text = NSString(format: "%.2f", this.totalPrice) as String + " €"
            }
            .store(in: &setOfCancellable)
    } // Combine
    

    // MARK: - 🖐 Handle U
    @IBAction func actionAddItem(_ sender: Any) {
        // add default item
        items.append(EngineDiscountsItem(tax: 0)) // after
        
        self.tableView.performBatchUpdates({
            self.tableView.insertRows(at: [IndexPath(row: self.items.count - 1,section: 0)],with: .automatic)
        }) { (true) in
            self.tableView.reloadData() // reload data
        }
        // dissmiss
        dismissKeyboard()
        
        // COMBINE
        subscriberCancellable.removeAll()
    } // Add row discount
    @IBAction func actionChangeDiscount(_ sender: UIButton) {
        guard let tagButton = sender.superview?.tag else {return} // ✔︎
        self.tagIdButtonCliked = tagButton // ✔︎ id will send
        performSegue(withIdentifier: "SegueToDiscountsCollectionViewController", sender: nil) // got to
    }
    
    // MARK: - 🈂️ Override A
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToDiscountsCollectionViewController" {
            let discountCollectionVC = segue.destination as! DiscountsCollectionViewController
            discountCollectionVC.discountDidSelected = discountDidSelectedFromDiscountCollectionVC(_:_:)
            discountCollectionVC.tagIdButton = tagIdButtonCliked
        }
    }
    
    // callback
    func discountDidSelectedFromDiscountCollectionVC(_ discount : String, _ id : Int) {
        if let discountValue = Float(discount) {
            items[id].tax = discountValue
            tableView.reloadData()
        }
    }
}

// MARK: - 👑 DELEGATE
// MARK: - UITableViewDataSource & Delegate
extension DiscountsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    } // Feed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
        
        //feed Price
        cell.priceTextField.text = items[indexPath.row].price == 0.0 ? "" : String(format: "%.2f", items[indexPath.row].price)
        
        //feed discount
        let discountRouded = roundf(items[indexPath.row].tax).clean
        cell.discountButton.setTitle(items[indexPath.row].tax == 0.0 ? "0 %" : "\(discountRouded) %", for: .normal)
        
        // id tag TextField
        cell.priceTextField.delegate = self
        cell.priceTextField.becomeFirstResponder()
        cell.contentView.tag = indexPath.row
        
        return cell
    } // // Feed
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if items.count != 1 || isEditingRow == true  {
            return true
        }
        return false
    } // allow Editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // deleting
        if items.count != 1  || isEditingRow == false {
            if editingStyle == .delete {
                // delete the item from the items array
                
                self.tableView.performBatchUpdates({
                    items.remove(at: indexPath.row)
                    // update the tableview
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                }) { (true) in
                    self.tableView.reloadData() // reload data
                }
                // tableView.reloadData() // not the best way to call it direclty
            }
        }
    } // Delete / update
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerCell?.contentView
    } // FooterView
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    } // Moving cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = items[sourceIndexPath.row]
        //move the item to the destination
        items.insert(itemToMove, at: destinationIndexPath.row)
        //        remove
        items.remove(at: sourceIndexPath.row)
    } // Drag and drop
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    } // Rejecting scroll
}

// MARK: - Drag And Drop
extension DiscountsViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    } // Drag
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    } // Drop
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    } // Drop
}
// MARK: - Engine Discount Delegate
extension DiscountsViewController: EngineDiscountDelegate {
    func showResultWith(sum: Float, sumTax: Float) {
        totalPrice = sum
        totalTaxPrice = sumTax
    } // get Discount & Total To pay
}

// MARK: - cell text field delegate
extension DiscountsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var validatorUserInput:Bool = false
        guard let tagCell = textField.superview?.tag else {return true} // ✔︎ get ID Tag
        
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        
        // SETUP
        let c = NSLocale.current.decimalSeparator ?? "."
        let limitBeforeSeparator = 9
        let limitAfterSeparator = 2
        
        // Validator
        let pattern = "(?!0[0-9])\\d*(?!\\\(c))^[0-9]{0,\(limitBeforeSeparator)}((\\\(c))[0-9]{0,\(limitAfterSeparator)})?$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            validatorUserInput = regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
        }
         
        // record data user
        if validatorUserInput {
            // setting data
            if let char = string.cString(using: String.Encoding.utf8) {
                let isBackSpace = strcmp(char, "\\b")
                if (isBackSpace == -92 && textField.text?.count == 1) {
                    print("Backspace was pressed")
                    print(newText)
                    //  save data in the array of items when backspace pressed
                    items[tagCell].price = 0 // ✔︎
                    //                print(items)
                } else {
                    print("Number Added")
                    print(newText)
                    //  save data in the array of items when backspace is not pressed
                    let priceValueFloat = Float(newText) ?? 0
                    items[tagCell].price = priceValueFloat
                    print("██░░░ L\(#line) 🚧🚧 privevalue : \(priceValueFloat) 🚧🚧 [ \(type(of: self))  \(#function) ]")
                }
            }
            return validatorUserInput
        } else {
            return validatorUserInput
        }
    } // while editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFloat = textField.text else {return}
        if let f = Float(textFloat) {
            let tipText: String = String(format: "%.2f", f) as String
            textField.text = tipText
        }
    }
}
