//
//  ViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.
//

import UIKit
import EngineDiscounts

class DiscountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var items = [Item]()
    var vc: DiscountsViewController!
    private let reuseIdentifierCell = "cell"
    private let reuseIdentifierFooter = "DiscountFooter"
    
    static func initItemsVC(items: [Item]) -> DiscountsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiscountsViewController") as! DiscountsViewController
        vc.items = items
        return vc
    }
    
    // MARK: - cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Discounts"
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        
        setupItemsArr()
        hideNavigationBar()
        dismissingKeyboard()
        
        
    }
    
    
    // MARK: - <#explication#>
    fileprivate func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    fileprivate func setupItemsArr() {
        // set array of item by default to 1
        if items.count == 0 {
            items.append(Item())
            items.append(Item())
            items.append(Item())
            items.append(Item())
        }
    }
    fileprivate func dismissingKeyboard() {
        // when tap on the view => dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        // fire the dismiss
        view.endEditing(true)
        // MARK: -
        // TODO: calculate price and reduction
        // TODO: reload tableview ( data )
        // MARK: -
    }
    
    // MARK: - UITableViewDataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
//        cell.textLabel?.text = String(items[indexPath.row].price)
        cell.priceTextField.text = String(items[indexPath.row].price)
        return cell
    }
    
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
                items.remove(at: indexPath.row)
                // update the tableview
                // tableView.reloadData() // not the best way
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
    }
    
    // footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // setup a custom view for the footer
        let footerCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierFooter) as? DiscountsFooterCell
        // return content View prevents footer from delete
        return footerCell?.contentView
    }
    
    // moving cells
     func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // drag and drop
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = items[sourceIndexPath.row]
        //move the item to the destination
        items.insert(itemToMove, at: destinationIndexPath.row)
        //        remove
        items.remove(at: sourceIndexPath.row)
    }


    // MARK: - Helper
    //MARK: -
    // FIXME: to delete
    // MARK: -
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifierCell)
        
    }
    
    
    // ⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬ test
    
    

    
}


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

