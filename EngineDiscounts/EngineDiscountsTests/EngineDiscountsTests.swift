//
//  EngineDiscountsTests.swift
//  EngineDiscountsTests
//
//  Created by Eddy R on 29/11/2020.
//

// IGPN test la police

import XCTest
@testable import EngineDiscounts





// IGPN
class EngineDiscountsTests: XCTestCase {
    
    let deviceSpyDelegate = DeviceSpy()
    
    func initSut(items: [Item]) -> EngineDiscounts {
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: items)
        sut.calculateTotal()
        return sut
    }
    
    func test_CalTotalWithZero_() {
//        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [])
//        sut.calculateTotal()
        _ = initSut(items: [])
        XCTAssertEqual(deviceSpyDelegate.total, 0, "current \(deviceSpyDelegate.total), expected : 0")
    }
    func test_calTotalWith__1preTaxPriceOf10_return10() {
        // IGPN test la POLICE
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [Item(price: 10)])
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 10, "current \(deviceSpyDelegate.total), expected : 10")
    }
    func test_calTotalWith__2preTaxPriceOf10_return20() {
        // IGPN test la POLICE
        let rows = [
            Item(price: 10),
            Item(price: 10)
        ]
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: rows)
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 20, "current \(deviceSpyDelegate.total), expected : 20")
    }
    func test_calTotalWith__3preTaxPriceOf10_return30() {
        // IGPN test la POLICE
        let rows = [
            Item(price: 10),
            Item(price: 10),
            Item(price: 10)
        ]
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: rows)
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 30, "current \(deviceSpyDelegate.total), expected : 20")
    }
    
    func test_calTotalWith__1ReductionOf10__and5percentOfTax__return5(){
        let row = Item(price: 10, tax: 50)
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [row])
        
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 5)
    }
    func test_calTotalWith__2ReductionOf10__and5percentOfTax__return10(){
        let row = Item(price: 10, tax: 50)
        let row2 = Item(price: 100, tax: 50)
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [row, row2])
        
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 55)
    }
    
    func test_calTotalWith__1ReductionOf10__and0percentOfTax__return0(){
        let row = Item(price: 10, tax: 0)
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [row])
        
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 10)
    }
    func test_calTotalWith__1ReductionOf0__and0percentOfTax__return10(){
        let row = Item(price: 0, tax: 10)
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [row])
        
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 0)
    }
    func test_calTotalWith__1ReductionOf0__and0percentOfTax__return0(){
        let row = Item(price: 0, tax: 0)
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [row])
        
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 0)
    }
    func test_calTotalWith__2ReductionOf0__and0percentOfTax__return0(){
        let row = Item(price: 0, tax: 0)
        let row2 = Item(price: 0, tax: 0)
        let sut = EngineDiscounts(delegate: deviceSpyDelegate, items: [row, row2])
        
        sut.calculateTotal()
        XCTAssertEqual(deviceSpyDelegate.total, 0)
    }
    
    func test_calDiscWith__1reductionOf10__and5percentOfTax__return5(){
        
    }
    
    // ⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬
    
    // CITOYEN
    class DeviceSpy: EngineDiscountDelegate {
        var total: Float = 0
        
        func showResultWith(sum: Float) {
            total = sum
        }
    }
}
