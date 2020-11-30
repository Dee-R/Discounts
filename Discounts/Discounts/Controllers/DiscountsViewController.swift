//
//  ViewController.swift
//  Discounts
//
//  Created by Eddy R on 29/11/2020.
//

import UIKit

class DiscountsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Discounts"
    }
    
    convenience init(items: [Item]) {
        self.init()
        // init parameter from convenience
    }
}

