//
//  ViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.
//

import UIKit
import EngineDiscounts

class DiscountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
//    var items = [EngineDiscountsItem]()
    
    var items : [EngineDiscountsItem] = [] {
        didSet {
            print("██░░░ L\(#line) 🚧📕 didset Array of Item 🚧🚧 [ \(type(of: self))  \(#function) ]")
            engineDiscount?.calculateTotal(array: items)
        }
    }
    var vc: DiscountsViewController!
    private let reuseIdentifierCell = "cell"
    private let reuseIdentifierFooter = "DiscountFooter"
    
    var engineDiscount: EngineDiscounts?
    var totalPrice: Float = 0
    var totalTaxPrice: Float = 0
    
    static func initItemsVC(items: [EngineDiscountsItem]) -> DiscountsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiscountsViewController") as! DiscountsViewController
        vc.items = items
        return vc
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder) // executed thx to ib
        
        items.append(EngineDiscountsItem(price: 10, tax: 50))
        items.append(EngineDiscountsItem(price: 20, tax: 50))
        engineDiscount = EngineDiscounts(delegate: self, items: items)
        engineDiscount?.calculateTotal()
    }
    
    // MARK: - cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Discounts"
        
        setupMovingCell()
//        setupItemsArr()
        hideNavigationBar()
        dismissingKeyboard()
        
//        EngineDiscounts(delegate: self, items: ))
        
        
    }
    
    // MARK: -  setup
    fileprivate func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    fileprivate func setupItemsArr() {
        // set array of item by default to 1
        if items.count == 0 {
            items.append(EngineDiscountsItem())
            items.append(EngineDiscountsItem())
            items.append(EngineDiscountsItem())
            items.append(EngineDiscountsItem())
        }
    }
    fileprivate func dismissingKeyboard() {
        // when tap on the view => dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.reloadData()
    }
    @objc func dismissKeyboard() {
        // fire the dismiss
        view.endEditing(true)
        // MARK: -
        // TODO: calculate price and reduction
        // TODO: reload tableview ( data )
        // MARK: -
    }
    fileprivate func setupMovingCell() {
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    // MARK: - UITableViewDataSource & Delegate
    
    // Feed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
        cell.priceTextField.text = items[indexPath.row].price == 0.0 ? "" : String(items[indexPath.row].price)
        cell.taxButton.setTitle(items[indexPath.row].tax == 0.0 ? "0%" : String(items[indexPath.row].tax), for: .normal)
//        print("██░░░ L\(#line) 🚧🚧 tag : \(cell.tag) 🚧🚧 [ \(type(of: self))  \(#function) ]")
        cell.priceTextField.delegate = self
        cell.contentView.tag = indexPath.row
        return cell
    }
    
    // Edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if items.count != 1 {
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // deleting
        if items.count != 1 {
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
        
    }
    
    // Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // setup a custom view for the footer
        let footerCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierFooter) as? DiscountsFooterCell
        footerCell?.totalToPay.text = String(self.totalPrice)
        footerCell?.totalDiscounts.text = String(self.totalTaxPrice)
        // return content View prevents footer from delete
        return footerCell?.contentView
    }
    
    // Move cell
     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Drag and drop
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = items[sourceIndexPath.row]
        //move the item to the destination
        items.insert(itemToMove, at: destinationIndexPath.row)
        //        remove
        items.remove(at: sourceIndexPath.row)
    }
    
    // Add cell
    @IBAction func actionAddItem(_ sender: Any) {
        // add default item
        items.append(EngineDiscountsItem(price: 10, tax: 50))
        
        self.tableView.performBatchUpdates({
            self.tableView.insertRows(at: [IndexPath(row: self.items.count - 1,section: 0)],with: .automatic)
        }) { (true) in
            self.tableView.reloadData() // reload data
        }
        // dissmiss
        dismissKeyboard()
    }
    
    // Scrolling dismiss
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

// MARK: - Drag And Drop
extension DiscountsViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}
extension DiscountsViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        if session.localDragSession != nil { // Drag originated from the same app.
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}

// MARK: - Engine
extension DiscountsViewController: EngineDiscountDelegate {
    func showResultWith(sum: Float, sumTax: Float) {
        totalPrice = sum
        totalTaxPrice = sumTax
//        print("██░░░ L\(#line) 🚧📕 sum \(sum), sumTax : \(sumTax) 🚧🚧 [ \(type(of: self))  \(#function) ]")

    }
}












extension DiscountsViewController: UITextFieldDelegate {
    // MARK: - cell text field delegate
    // BEGIN
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("BEGIN ------")
//        print("                  ", textField.text)
//        return true
//    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("END ------")
        // recupere le chiffre dans le textfield
        print("                  ", textField.text)
        if let tag = textField.superview?.tag {
            if let text = textField.text {
                print(text.count)
                
                if text == "" {
                    items[tag].price = 0
                    tableView.reloadData()
                } else {
                    if let textFloat = Float(text) {
                        items[tag].price = textFloat
                        tableView.reloadData()
                    }
                    
                }
            }
            
        }
        tableView.reloadData()
    }
    
    
    
    // DURING
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField.text?.count == 0 {
//            print("textField == 0")
//        }
        
        if let tag = textField.superview?.tag {
            if let text = textField.text {
                print(text.count)
                if let textFloat = Float(text) {
                    // x number
                    print("A : \(textFloat)")
                    items[tag].price = textFloat
//                    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//                        DispatchQueue.main.async {
//                            self?.tableView.reloadData()
//                        }
//                    }
//                    tableView.reloadData()
                } else {
                    print("B")
                    // zero
                    items[tag].price = 0
                    
                }
            }
            
        }
//        guard let text = textField.text else { return false }
//        guard let textFloat = Float(text) else { return false }
//
//        print("WHIL| tag : \(tag), text : \(text), textFloat: \(textFloat)")
        
        return true
    }
    
    // END
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//
//        // assign a tag for each cell
//        // get tag of right cell and update it
//        if let tag = textField.superview?.tag {
//            guard let newpriceFromText = textField.text else { return }
//            guard let newpriceFromFloat =  Float(newpriceFromText) else { return }
//            items[tag].price = newpriceFromFloat
//
//            tableView.reloadData()
//        }
//        if textField.text?.count == 0 {
//            print("██░░░ L\(#line) 🚧🚧 empty : \(textField.text?.count) 🚧🚧 [ \(type(of: self))  \(#function) ]")
//        } else {
//            print("██░░░ L\(#line) 🚧🚧 continue : \(textField.text?.count) 🚧🚧 [ \(type(of: self))  \(#function) ]")
//        }
//    }
}
