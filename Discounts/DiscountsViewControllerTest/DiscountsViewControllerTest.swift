//
//  DiscountsViewControllerTest.swift
//  DiscountsViewControllerTest
//
//  Created by Eddy R on 30/11/2020.
//

import XCTest
@testable import Discounts

class DiscountsViewControllerTest: XCTestCase {

    
    // start ViewLifeCycle
    func test_viewDidLoad_renderTitleNavigationItem() {
        let sut = DiscountsViewController()
        _ = sut.view // load view by call the view
        XCTAssertEqual(sut.title, "Discounts")
    }
}
 
