//
//  DiscountsViewControllerTest.swift
//  DiscountsViewControllerTest
//
//  Created by Eddy R on 30/11/2020.
//

import XCTest
@testable import Discounts

class DiscountsViewControllerTest: XCTestCase {

    var sut : DiscountsViewController!
    override func setUp() {
        super.setUp()
        //*** For storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        sut = storyboard.instantiateViewController(identifier: "DiscountsViewController") as! DiscountsViewController
//        _ = sut.view
    }
    
    // start ViewLifeCycle
    func test_viewDidLoad_renderTitleNavigationItem() {
        sut = DiscountsViewController.initItemsVC(items: [])
        _ = sut.view // call viewDidLoad
        XCTAssertEqual(sut.title, "Discounts")
    }
    func test_viewDidLoad_renderTableView() {
        sut = DiscountsViewController.initItemsVC(items: [])
        _ = sut.view // call viewDidLoad
        XCTAssertNotNil(sut.tableView)
    }
    func test_viewDidLoad_renderTableView_Empty() {
        sut = DiscountsViewController.initItemsVC(items: [])
        _ = sut.view // call viewDidLoad
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    func test_viewDidLoad_renderTableView_OneRow() {
        sut = DiscountsViewController.initItemsVC(items: [
            Item(price: 0, tax: 0),
        ])
        _ = sut.view // call viewDidLoad
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    func test_viewDidLoad_renderPrice_OneRow() {
        sut = DiscountsViewController.initItemsVC(items: [
            Item(price: 0, tax: 0),
        ])
        _ = sut.view // call viewDidLoad
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertEqual(cell?.textLabel?.text, "0.0")
    }
}
 
