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
        let sut = makeSut(items: [])
        XCTAssertEqual(sut.title, "Discounts")
    }
    func test_viewDidLoad_renderTableView() {
        let sut = makeSut(items: [])
        XCTAssertNotNil(sut.tableView)
    }
    func test_viewDidLoad_renderTableView_Empty() {
        let sut = makeSut(items: [])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    func test_viewDidLoad_renderTableView_OneRow() {
        let sut = makeSut(items: [Item(price: 0, tax: 0)])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    func test_viewDidLoad_renderPrice_OneRow() {
        let sut = makeSut(items: [Item(price: 0, tax: 0)])
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.textLabel?.text, "0.0")
    }
    
    // MARK: - Helpers
    func makeSut(items: [Item]) -> DiscountsViewController {
        let sut = DiscountsViewController.initItemsVC(items: items)
        _ = sut.view // call viewDidLoad
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return self.dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
}
