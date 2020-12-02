//
//  ItemsTest.swift
//  DiscountsViewControllerTest
//
//  Created by Eddy R on 02/12/2020.
//

import XCTest
@testable import Discounts

class ItemsTest: XCTestCase {
    
    var sut : DiscountsViewController!
    override func setUp() {
        super.setUp()
    }
    
    func test_emptyItemsArray_return1Item() {
        sut = makeSut(items: [])
        XCTAssertEqual(sut.items.count, 1)
    }
    
    // MARK: - Helpers
    func makeSut(items: [Item]) -> DiscountsViewController {
        let sut = DiscountsViewController.initItemsVC(items: items)
        _ = sut.view // call viewDidLoad
        return sut
    }
    
}
