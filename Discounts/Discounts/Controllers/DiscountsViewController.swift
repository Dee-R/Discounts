//
//  ViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.
//

import UIKit
import EngineDiscounts
import Combine


class DiscountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: - PROPERTIES
    // Combine
    private let notificationCenter = NotificationCenter.default
    private var subscriberCancellable = Set<AnyCancellable>() // for row
    private var setOfCancellable = Set<AnyCancellable>() //data
    
    // UITableViewDelegate
    @IBOutlet weak var tableView: UITableView!
    private let reuseIdentifierCell = "cell"
    private let reuseIdentifierFooter = "DiscountFooter"
    var totalPrice: Float = 0
    var totalTaxPrice: Float = 0
    var isEditingRow = false
    var footerCell: DiscountsFooterCell? = nil
    
    //Others
    var vc: DiscountsViewController!
    var engineDiscount: EngineDiscounts?
    
    // Model
    @Published var items : [EngineDiscountsItem] = []
    
    
    // MARK: - CYCLE LIFE
    required init?(coder: NSCoder) {
        super.init(coder: coder) // executed thx to ib
        engineDiscount = EngineDiscounts(delegate: self, items: items)
        engineDiscount?.calculateTotal()
        
    }
    override func viewDidLoad() {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        super.viewDidLoad()
        self.title = "Discounts"
        
        setupDragAndDropCell()
        populateArrayOfItem() // add 2 row
        hideNavigationBar()
        dismissKeyboardButton()
                        
        // get data for binding
        footerCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierFooter) as? DiscountsFooterCell
        footerCell?.totalToPay.text = "0.0 €" // set default Value
        footerCell?.totalDiscounts.text = "0.0 €" // set default Value
        
        // bind data and ui
        binding()
    }
    
    
    // MARK: -  SETUP
    fileprivate func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    fileprivate func populateArrayOfItem() {
        // set array of item by default to 1
        if items.count == 0 {
            items.append(EngineDiscountsItem(price: 0, tax: 50))
            items.append(EngineDiscountsItem(price: 0, tax: 50))
        }
    }
    fileprivate func dismissKeyboardButton() {
        // when tap on the view => dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        tableView.reloadData()
    }
    @objc fileprivate func dismissKeyboard() {
        // fire the dismiss
        view.endEditing(true)
        isEditingRow = false
        // MARK: -
        // TODO: calculate price and reduction
        // TODO: reload tableview ( data )
        // MARK: -
    }
    fileprivate func setupDragAndDropCell() {
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
    
    // Combine
    func binding() {
//        $items.receive(on: DispatchQueue.main)
//            .map {[weak self] (myItem) -> String in
//                guard self != nil else { return ""}
//
//
//                var localPrice: Float = 0
//                myItem.forEach { (item) in
//                    localPrice += item.price
//                }
//                return "\(localPrice) €"
//            }
//            .assign(to: \.title, on: self)
//            .store(in: &setOfCancellable)
        
        // MARK: - p: items s:Footer
//        $items
//            .receive(on: DispatchQueue.main)
//            .sink { (fail) in
//                print(fail)
//            } receiveValue: { (arrItem) in
//                print("///////",arrItem)
//                // recois le tableau
//                var price: Float = 0
//                _ = arrItem.map { (engineDiscountsItem)  in
//                    price += engineDiscountsItem.price
//                }
//                self.footerCell?.totalToPay.text = String(price)
//            }
//            .store(in: &setOfCancellable)
        
        $items
            .receive(on: DispatchQueue.main)
            .sink { (fail) in
                print(fail)
            } receiveValue: { [weak self] (arrItem) in
                guard let this = self else { return }
                this.engineDiscount?.calculateTotal(array: this.items)
                
                print(this.totalPrice)
                print(this.totalTaxPrice)
                this.footerCell?.totalDiscounts.text = this.totalTaxPrice == 0.00 ?  "\(this.totalTaxPrice) €" :  "-\(this.totalTaxPrice) €"
                this.footerCell?.totalToPay.text = "\(this.totalPrice) €"
                
                
                // recois le tableau
//                var price: Float = 0
//                _ = arrItem.map { (engineDiscountsItem)  in
//                    price += engineDiscountsItem.price
//                }
//                self.footerCell?.totalToPay.text = String(price)
            }
            .store(in: &setOfCancellable)
        
        
    }
    
}

// MARK: - UITableViewDataSource & Delegate
extension DiscountsViewController {
    // Feed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
     cell.priceTextField.text = items[indexPath.row].price == 0.0 ? "" : String(items[indexPath.row].price)
     cell.taxButton.setTitle(items[indexPath.row].tax == 0.0 ? "0%" : String(items[indexPath.row].tax), for: .normal)
     //        print("██░░░ L\(#line) 🚧🚧 tag : \(cell.tag) 🚧🚧 [ \(type(of: self))  \(#function) ]")
     cell.priceTextField.delegate = self
     cell.contentView.tag = indexPath.row
     return cell
     }
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
        
        cell.priceTextField.text = items[indexPath.row].price == 0.0 ? "" : String(items[indexPath.row].price)
        cell.taxButton.setTitle(items[indexPath.row].tax == 0.0 ? "0%" : String(items[indexPath.row].tax), for: .normal)
        
        // id tag
        cell.priceTextField.delegate = self
        cell.priceTextField.becomeFirstResponder()
        cell.contentView.tag = indexPath.row
        
        // ici creation perform
        // PUBLISHER = SET
        
//        // Combine : PRICE publisher
//        notificationCenter.publisher(for: UITextField.textDidChangeNotification, object: cell.priceTextField)
//            .sink { [weak self] (notification) in
//                guard let this = self else {return}
//                guard let textfield = notification.object as? UITextField,
//                      let text = textfield.text,
//                      let value = Float(text) else {return}
//                // update array
////                print("██░░░ L\(#line) 🚧🚧 value : \(value) 🚧🚧 [ \(type(of: self))  \(#function) ]")
////                print("██░░░ L\(#line) 🚧🚧 array of items : \(this.items) 🚧🚧 [ \(type(of: self))  \(#function) ]")
//            }
//            .store(in: &subscriberCancellable)
//        //MARK: -
//        // FIXME: .store(in: &subscriberCancellable)
//        // verifier que ça ne pose pas de porbleme pour la suppression d'un er row
//        // ajouter un selector pour changer de price
//        // MARK: -
        return cell
    }
    
    // Can Edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if items.count != 1 || isEditingRow == true  {
            return true
        }
        
        return false
    }
    
    // Delete / update
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
        
    }
    
    
    
    // Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // setup a custom view for the footer
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        
        
        // footerCell?.totalToPay.text = String(self.totalPrice)
        // footerCell?.totalToPay.text = "0"

        
//        
//        footerCell?.totalToPay.text = "0"
//        footerCell?.totalDiscounts.text = String(self.totalTaxPrice)
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
        
        // COMBINE
        subscriberCancellable.removeAll()
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
    }
}


// MARK: - cell text field delegate
extension DiscountsViewController: UITextFieldDelegate {
    // BEGIN
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        rightText = ""
    }
    // DURING
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var validatorUserInput:Bool = false
        guard let tagCell = textField.superview?.tag else {return true} // ✔︎ get ID Tag
        
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        
        // SETUP
        let c = NSLocale.current.decimalSeparator ?? "."
        let limitBeforeSeparator = 2
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
                }
            }
            return validatorUserInput
        } else {
            return validatorUserInput
        }
    }
    // AFTER
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(items)
    }
}


//public typealias Binding = Subscriber
//public extension Publisher where Failure == Never {
//    func bind<B: Binding>(subscriber: B) -> AnyCancellable
//    where B.Failure == Never, B.Input == Output {
//
//        handleEvents(receiveSubscription: { subscription in
//            subscriber.receive(subscription: subscription)
//        })
//        .sink { value in
//            _ = subscriber.receive(value)
//        }
//    }
//}
