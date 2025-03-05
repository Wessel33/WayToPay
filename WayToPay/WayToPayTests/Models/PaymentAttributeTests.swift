//
//  PaymentAttributeTests.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import XCTest

@testable import WayToPay

final class PaymentAttributeTests: XCTestCase {
    var sut: PaymentAttribute!
    
    private let money0 = Money(0)
    private let money0_02 = Money(0.02)
    private let money0_05 = Money(0.05)
    private let money0_07 = Money(0.07)
    private let money0_09 = Money(0.09)
    private let money1_1 = Money(1.10)
    private let money1_3 = Money(1.30)
    private let money1_50 = Money(1.50)
    private let money5 = Money(5)
    private let money10_5 = Money(10.50)
    private let money15_25 = Money(15.25)
    private let money20_01 = Money(20.01)
    private let money30_70 = Money(30.70)
    private let money100 = Money(100)
    private let money100_5 = Money(100.50)
    private let money134_92 = Money(134.92)
    private let money173_27 = Money(173.27)
    private let money200_1 = Money(200.1)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Cashback
    
    func test_cashback() {
        // given
        sut = .cashback(rate: 5)
        
        // then
        XCTAssertEqual(sut.names(), [
            "Cashback",
            "5%"
        ])
    }
    
    func test_cashback_noCost() {
        // given
        let cost = money0
        sut = .cashback(rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0)
    }
    
    func test_cashback_noCashbackAmount() {
        // given
        let cost = money100
        sut = .cashback(rate: 0)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0)
    }
    
    func test_cashback_5perCent() {
        // given
        let cost = money100
        sut = .cashback(rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money5)
    }
    
    func test_cashback_10perCent() {
        // given
        let cost = money200_1
        sut = .cashback(rate: 10)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money20_01)
    }
    
    func test_cashback_11and3perCent() {
        // given
        let cost = money134_92
        sut = .cashback(rate: 11.3)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money15_25)
    }
    
    func test_cashback_17and72perCent() {
        // given
        let cost = money173_27
        sut = .cashback(rate: 17.72)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money30_70)
    }
    
    // MARK: Round Up
    
    func test_roundUp_wholeFactor() {
        // given
        sut = .roundUp(factor: 1, rate: 4.8)

        // then
        XCTAssertEqual(sut.names(), [
            "Round up",
            "AER 4.8%"
        ])
    }
    
    func test_roundUp_CurrencyFactor() {
        // given
        sut = .roundUp(factor: 1.5, rate: 6)

        // then
        XCTAssertEqual(sut.names(), [
            "Round up",
            "1.5x",
            "AER 6%"
        ])
    }
    
    func test_roundUp_1yearProvided() {
        // given
        sut = .roundUp(factor: 2, rate: 3.49, years: 1)

        // then
        XCTAssertEqual(sut.names(), [
            "Round up",
            "2x",
            "AER 3.49%"
        ])
    }
    
    func test_roundUp_2yearProvided() {
        // given
        sut = .roundUp(factor: 2.54, rate: 1, years: 2)

        // then
        XCTAssertEqual(sut.names(), [
            "Round up",
            "2.54x",
            "AER 1%",
            "2yrs"
        ])
    }
        
    func test_roundUp_noCost() {
        // given
        let cost = money0
        sut = .roundUp(factor: 1, rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0)
    }
    
    func test_roundUp_noFactor() {
        // given
        let cost = money100
        sut = .roundUp(factor: 0, rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0)
    }
    
    func test_roundUp_noAER() {
        // given
        let cost = money100
        sut = .roundUp(factor: 1, rate: 0)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0)
    }
    
    func test_roundUp_noCurrencyCost() {
        // given
        let cost = money100
        sut = .roundUp(factor: 1, rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0)
    }
    
    func test_roundUp_1x_5perCent_150() {
        // given
        let cost = money1_50
        sut = .roundUp(factor: 1, rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0_02)
    }
    
    func test_roundUp_1x_5perCent_1050() {
        // given
        let cost = money10_5
        sut = .roundUp(factor: 1, rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0_02)
    }
    
    func test_roundUp_1x_5perCent_10050() {
        // given
        let cost = money100_5
        sut = .roundUp(factor: 1, rate: 5)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0_02)
    }
    
    func test_roundUp_2x_485perCent_150() {
        // given
        let cost = money1_50
        sut = .roundUp(factor: 2, rate: 4.85)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0_05)
    }
    
    func test_roundUp_2x_485perCent_110() {
        // given
        let cost = money1_1
        sut = .roundUp(factor: 2, rate: 4.85)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0_09)
    }
    
    func test_roundUp_2x_485perCent_130() {
        // given
        let cost = money1_3
        sut = .roundUp(factor: 2, rate: 4.85)
        
        // when
        let savings = sut.calculateSavings(for: cost)
        
        // then
        XCTAssertEqual(savings, money0_07)
    }
}
