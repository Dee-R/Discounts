//
//  DiscountsViewControllerTest.swift
//  DiscountsViewControllerTest
//
//  Created by Eddy R on 30/11/2020.
//

import XCTest
@testable import Discounts

class DiscountsViewControllerTest: XCTestCase {

//    var sut : DiscountsViewController!
//    override func setUp() {
//        super.setUp()
//        //*** For storyboard
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        sut = storyboard.instantiateViewController(identifier: "DiscountsViewController") as! DiscountsViewController
////        _ = sut.view
//    }
//    
//    // start ViewLifeCycle
//    func test_viewDidLoad_renderTitleNavigationItem() {
//        
//        XCTAssertEqual(sut.title, "Discounts")
//    }
//    func test_viewDidLoad_renderTableView() {
//        
//        XCTAssertNotNil(sut.tableView)
//    }
////    func test_viewDidLoad_renderTableView_Empty() {
////        let sut = makeSut(items: [])
////        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
////    }
//    func test_viewDidLoad_renderTableView_OneRow() {
//        
//        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
//    }
////    func test_viewDidLoad_renderPrice_OneRow() {
////        let sut = makeSut(items: [Item(price: 0, tax: 0)])
////        let cell = sut.tableView.cell(at: 0)
////        XCTAssertEqual(cell?.textLabel?.text, "0.0")
////    }
//
//    
//    
//    
//    // MARK: - Footer
//    func test_footer_setValueOfPriceAndTaxBy_nothing() {
//        
//        let cell = sut.tableView.cell(at: 0) as! DiscountCell
//        XCTAssertEqual(cell.priceTextField.text, "")
//    }
//    
//    // ?
//    // quoi qui ou quand comment
//    func test_footer_setValueDiscountAndPriceTo_zero() {
//             
//        let f = sut.tableView.dequeueReusableCell(withIdentifier: "DiscountFooter") as! DiscountsFooterCell
//        XCTAssertEqual(f.totalToPay.text, "0.00 €")
//        XCTAssertEqual(f.totalDiscounts.text, "0.00 €")
//    }
//    
//    
   
}
//
//private extension UITableView {
//    func cell(at row: Int) -> UITableViewCell? {
//        return self.dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
//    }
//}
