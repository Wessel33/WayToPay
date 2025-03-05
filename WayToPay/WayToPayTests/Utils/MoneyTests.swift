//
//  MoneyTests.swift
//  WayToPay
//
//  Created by Wesley Frost on 01/03/2025.
//

import XCTest

@testable import WayToPay

final class MoneyTests: XCTestCase {
    var sut: Money!
        
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    fileprivate struct Constants {
        static let currency: String = "GBP"

        struct Zero {
            static let value: SafeDecimal = 0
            static let money: Money = .init(value)
        }
        
        struct One {
            static let value: SafeDecimal = 1
            static let money: Money = .init(value)
        }
        
        struct OneDollar {
            static let value: SafeDecimal = 1
            static let currency: String = "USD"
            static let money: Money = .init(value, currency: currency)
        }
        
        struct TenPence {
            static let value: SafeDecimal = 0.1
            static let money: Money = .init(value)
        }
        
        struct TwentyOnePence {
            static let value: SafeDecimal = 0.21
            static let money: Money = .init(value)
        }
        
        struct TenPoundsFiftySixPence {
            static let value: SafeDecimal = 10.56
            static let money: Money = .init(value)
        }
        
        struct FourtyFivePoundsTwentyNinePence {
            static let value: SafeDecimal = 45.29
            static let money: Money = .init(value)
        }
        
        struct OneHundredPoundsFiftySixPence {
            static let value: SafeDecimal = 100.56
            static let money: Money = .init(value)
        }
        
        struct ThreeDecimalPlacesRoundUp {
            static let input: SafeDecimal = 1.236
            static let value: SafeDecimal = 1.24
            static let money: Money = .init(input)
        }
        
        struct ThreeDecimalPlacesRoundUpBankers {
            static let input: SafeDecimal = 1.235
            static let value: SafeDecimal = 1.24
            static let money: Money = .init(input)
        }
        
        struct ThreeDecimalPlacesRoundDown {
            static let input: SafeDecimal = 1.284
            static let value: SafeDecimal = 1.28
            static let money: Money = .init(input)
        }
    }
    
    func test_init() {
        // given
        sut = Constants.One.money
        
        // then
        XCTAssertEqual(sut.value, Constants.One.value)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_init_customCurrency() {
        // given
        sut = Constants.OneDollar.money
        
        // then
        XCTAssertEqual(sut.value, Constants.OneDollar.value)
        XCTAssertEqual(sut.currency, Constants.OneDollar.currency)
    }
    
    func test_init_roundUp() {
        // given
        sut = Constants.ThreeDecimalPlacesRoundUp.money
        
        // then
        XCTAssertEqual(sut.value, Constants.ThreeDecimalPlacesRoundUp.value)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_init_roundUp_bankers() {
        // given
        sut = Constants.ThreeDecimalPlacesRoundUpBankers.money
        
        // then
        XCTAssertEqual(sut.value, Constants.ThreeDecimalPlacesRoundUpBankers.value)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_init_roundDown() {
        // given
        sut = Constants.ThreeDecimalPlacesRoundDown.money
        
        // then
        XCTAssertEqual(sut.value, Constants.ThreeDecimalPlacesRoundDown.value)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_addition() {
        // given
        let a = Constants.TenPoundsFiftySixPence.money
        let b = Constants.FourtyFivePoundsTwentyNinePence.money
        
        // when
        sut = a + b
        
        // then
        XCTAssertEqual(sut.value, Constants.TenPoundsFiftySixPence.value + Constants.FourtyFivePoundsTwentyNinePence.value)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_subtraction() {
        // given
        let a = Constants.TenPoundsFiftySixPence.money
        let b = Constants.FourtyFivePoundsTwentyNinePence.money
        
        // when
        sut = a - b
        
        // then
        XCTAssertEqual(sut.value, Constants.TenPoundsFiftySixPence.value - Constants.FourtyFivePoundsTwentyNinePence.value)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_multiplication() {
        // given
        let a = Constants.TenPoundsFiftySixPence.money
        let b: SafeDecimal = 3.6
        let expectedValue: SafeDecimal = 38.02
        
        // when
        sut = a * b
        
        // then
        XCTAssertEqual(sut.value, expectedValue)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_multiplication_commutated() {
        // given
        let a = Constants.TenPoundsFiftySixPence.money
        let b: SafeDecimal = 3.6
        let expectedValue: SafeDecimal = 38.02

        // when
        sut = b * a
        
        // then
        XCTAssertEqual(sut.value, expectedValue)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_division() {
        // given
        let a = Constants.TenPoundsFiftySixPence.money
        let b: SafeDecimal = 3.2
        
        // when
        sut = a / b
        
        // then
        XCTAssertEqual(sut.value, Constants.TenPoundsFiftySixPence.value / b)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_percentageMultiplication_5() {
        // given
        let a = Constants.OneHundredPoundsFiftySixPence.money
        let b: SafeDecimal = 5
        let expectedValue: SafeDecimal = 5.03
        
        // when
        sut = a %* b
        
        // then
        XCTAssertEqual(sut.value, expectedValue)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_percentageMultiplication_10() {
        // given
        let a = Constants.OneHundredPoundsFiftySixPence.money
        let b: SafeDecimal = 10
        
        // when
        sut = a %* b
        
        // then
        XCTAssertEqual(sut.value, 10.06)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_percentageIncrease_10() {
        // given
        let a = Constants.OneHundredPoundsFiftySixPence.money
        let b: SafeDecimal = 10
        
        // when
        sut = a %+ b
        
        // then
        XCTAssertEqual(sut.value, 110.62)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
    
    func test_percentageDecrease_10() {
        // given
        let a = Constants.OneHundredPoundsFiftySixPence.money
        let b: SafeDecimal = 10
        
        // when
        sut = a %- b
        
        // then
        XCTAssertEqual(sut.value, 90.50)
        XCTAssertEqual(sut.currency, Constants.currency)
    }
}
