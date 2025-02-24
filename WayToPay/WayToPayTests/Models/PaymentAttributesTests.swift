//
//  PaymentAttributesTests.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import XCTest

@testable import WayToPay

final class PaymentAttributesTests: XCTestCase {
    func test_empty() {
        // given
        let sut: PaymentAttributes = []
        
        // then
        XCTAssertEqual(sut.rawValue, 0)
        
        // when
        let names = sut.names()
        
        // then
        XCTAssertEqual(names, [])
    }
    
    func test_all() {
        // given
        let sut: PaymentAttributes = [
            .cashbackEnabled
        ]
        
        // then
        XCTAssertEqual(sut.rawValue, 1)
        
        // when
        let names = sut.names()
        
        // then
        XCTAssertEqual(names, [
            "Cashback: 0.0%"
        ])
    }
    
    func test_cashback() {
        // given
        var sut: PaymentAttributes = [
            .cashbackEnabled
        ]
        sut.cashbackAmount = 5.0
        
        // then
        XCTAssertTrue(sut.contains(.cashbackEnabled))
        
        // when
        let names = sut.names()
        
        // then
        XCTAssertEqual(names, [
            "Cashback: 5.0%"
        ])
    }
}
