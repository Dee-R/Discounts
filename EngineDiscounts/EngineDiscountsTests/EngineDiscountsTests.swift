//
//  EngineDiscountsTests.swift
//  EngineDiscountsTests
//
//  Created by Eddy R on 29/11/2020.
//

import XCTest
@testable import EngineDiscounts

class EngineDiscountsTests: XCTestCase {
    
    let deviceSpyDelegate = DeviceSpy()
    
    func initSut(items: [Item]) -> EngineDiscounts {
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: items)
        sut.calculateTotal()
        return sut
    }
    
    func test_CalTotalWithZero_() {
        _ = initSut(items: [])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 0, "current \(deviceSpyDelegate.totalPrice), expected : 0")
    }
    func test_calTotalWith__1preTaxPriceOf10_return10() {
        _ = initSut(items: [Item(price: 10)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 10, "current \(deviceSpyDelegate.totalPrice), expected : 10")
    }
    func test_calTotalWith__2preTaxPriceOf10_return20() {
        _ = initSut(items: [Item(price: 10),Item(price: 10)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 20, "current \(deviceSpyDelegate.totalPrice), expected : 20")
    }
    func test_calTotalWith__3preTaxPriceOf10_return30() {
        // IGPN test la POLICE
        let rows = [
            Item(price: 10),
            Item(price: 10),
            Item(price: 10)
        ]
        _ = initSut(items: rows)
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 30, "current \(deviceSpyDelegate.totalPrice), expected : 20")
    }
    
    func test_calTotalWith__1ReductionOf10__and5percentOfTax__return5(){
        _ = initSut(items: [Item(price: 10, tax: 50)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 5)
    }
    func test_calTotalWith__2ReductionOf10__and5percentOfTax__return10(){
        _ = initSut(items: [Item(price: 100, tax: 50), Item(price: 10, tax: 50)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 55)
    }
    
    func test_calTotalWith__1ReductionOf10__and0percentOfTax_ _return0(){
        _ = initSut(items: [Item(price: 10, tax: 0)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 10)
    }
    func test_calTotalWith__1ReductionOf0__and0percentOfTax__return10(){
        _ = initSut(items: [Item(price: 0, tax: 10)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 0)
    }
    func test_calTotalWith__1ReductionOf0__and0percentOfTax__return0(){
        _ = initSut(items: [Item(price: 0, tax: 0)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 0)
    }
    func test_calTotalWith__2ReductionOf0__and0percentOfTax__return0(){
        _ = initSut(items: [Item(price: 0, tax: 0), Item(price: 0, tax: 0)])
        XCTAssertEqual(deviceSpyDelegate.totalPrice, 0)
    }
    
    func test_calDiscWith__2DifferentreductionOf50and100__and90and50percentOfTax__return95(){
        _ = initSut(items: [
            Item(price: 50, tax: 90),
            Item(price: 100, tax: 50),
        ])
        XCTAssertEqual(deviceSpyDelegate.totalTaxPrice, 95)
    }
    func test_calDiscWith__2DifferentreductionOf50and100and100__and90and50and0percentOfTax__return95(){
        _ = initSut(items: [
            Item(price: 50, tax: 90),
            Item(price: 100, tax: 50),
            Item(price: 100, tax: 100),
        ])
        XCTAssertEqual(deviceSpyDelegate.totalTaxPrice, 195)
    }
    
    
    // ⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬
    class DeviceSpy: EngineDiscountDelegate {
        var totalPrice: Float = 0
        var totalTaxPrice: Float = 0
        
        func showResultWith(sum: Float, sumTax: Float) {
            totalPrice = sum
            totalTaxPrice = sumTax
        }
    }
}
