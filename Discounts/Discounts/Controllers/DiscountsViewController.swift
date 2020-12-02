//
//  ViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.
//

import Foundation
import UIKit

class DiscountsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        
        // hide navigation bar image
        hideNavigationBar()
    }
    
    fileprivate func hideNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - UITableViewDataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscountCell", for: indexPath) as! DiscountCell
        print(cell.priceTextField.text)
        return cell
    }
    // footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierFooter) as? DiscountsFooterCell
        return footerCell
    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 60
//    }

    // MARK: - Helper
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell) {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifierCell)
        
    }
    
}

