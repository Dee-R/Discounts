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
    var items: [Item] = []
    var vc: DiscountsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // Do any additional setup after loading the view.
        self.title = "Discounts"
    }
    
    static func initItemsVC(items: [Item]) -> DiscountsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DiscountsViewController") as! DiscountsViewController
        vc.items = items
        print(items)
        return vc
    }
//    convenience init(items: [Item]) {
//        self.init()
//        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
//        // init parameter from convenience
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(items[indexPath.row].price)
        return cell
    }
    
}

