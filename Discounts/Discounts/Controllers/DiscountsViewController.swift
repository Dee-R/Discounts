//
//  ViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.
//

import Foundation
import UIKit

class DiscountsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var items = [Item]()
    var vc: DiscountsViewController!
    private let reuseIdentifierCell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Discounts"
    }
    
    static func initItemsVC(items: [Item]) -> DiscountsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiscountsViewController") as! DiscountsViewController
        vc.items = items
        return vc
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = dequeueCell(in: tableView)
//        cell.textLabel?.text = String(items[indexPath.row].price)
//        return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
        print(cell.priceTextField.text)
        return cell
    }
    
    // MARK: - Helper
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifierCell)
        
    }
    
}

