//
//  Money.swift
//  WayToPay
//
//  Created by Wesley Frost on 27/02/2025.
//

import Foundation

// Custom operator for multipling by percentage
infix operator %*
infix operator %+
infix operator %-

enum MoneyError: Error {
    case inconsistentCurencies
    case divideByZero
}

struct Money: Equatable, Comparable, Codable {
    let value: SafeDecimal
    let currency: String
    
    init(_ value: SafeDecimal, currency: String = "GBP") {
        self.value = Money.round(value, mode: .bankers)
        self.currency = currency
    }
    
    init(_ value: String, currency: String = "GBP") {
        self.value = Money.round(SafeDecimal(value), mode: .bankers)
        self.currency = currency
    }
    
    init(_ value: Decimal, currency: String = "GBP") {
        self.value = Money.round(SafeDecimal(value), mode: .bankers)
        self.currency = currency
    }
    
    init(_ value: Double, currency: String = "GBP") {
        self.value = Money.round(SafeDecimal(value), mode: .bankers)
        self.currency = currency
    }
    
    init(_ value: Int, currency: String = "GBP") {
        self.value = Money.round(SafeDecimal(value), mode: .bankers)
        self.currency = currency
    }
    
    // MARK: Arithmitic
    
    static func + (lhs: Money, rhs: Money) -> Money {
        guard lhs.currency == rhs.currency else {
            fatalError("Cannot compare different currencies")
        }
                
        return Money(lhs.value + rhs.value, currency: lhs.currency)
    }
    
    static func - (lhs: Money, rhs: Money) -> Money {
        guard lhs.currency == rhs.currency else {
            fatalError("Cannot compare different currencies")
        }
        
        return Money(lhs.value - rhs.value, currency: lhs.currency)
    }
    
    static func * (lhs: Money, rhs: SafeDecimal) -> Money {
        return Money(lhs.value * rhs, currency: lhs.currency)
    }
    
    static func * (lhs: SafeDecimal, rhs: Money) -> Money {
        return Money(lhs * rhs.value, currency: rhs.currency)
    }
    
    static func / (lhs: Money, rhs: SafeDecimal) -> Money {
        guard rhs.value != 0 else {
            fatalError("Cannot divide by zero")
        }
        
        return Money(lhs.value / rhs.value, currency: lhs.currency)
    }
    
    static func %* (lhs: Money, rhs: SafeDecimal) -> Money {
        return lhs * (rhs / 100)
    }
    
    static func %+ (lhs: Money, rhs: SafeDecimal) -> Money {
        return lhs * ((100 + rhs) / 100)
    }
    
    static func %- (lhs: Money, rhs: SafeDecimal) -> Money {
        return lhs * ((100 - rhs) / 100)
    }
    
    func roundUpToPound() -> Money {
        return Money(Money.round(value, mode: .up, scale: 0), currency: currency)
    }
    
    func roundUp() -> Money {
        return Money(Money.round(value, mode: .up), currency: currency)
    }
    
    func roundDown() -> Money {
        return Money(Money.round(value, mode: .down), currency: currency)
    }
    
    private static func round(_ value: SafeDecimal, mode: NSDecimalNumber.RoundingMode, scale: Int16 = 2) -> SafeDecimal {
        let handler = NSDecimalNumberHandler(
            roundingMode: mode,
            scale: scale,
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        
        return SafeDecimal(NSDecimalNumber(decimal: value.value).rounding(accordingToBehavior: handler).decimalValue)
    }
    
    // MARK: String formatting
    
    func formatted(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.locale = locale
        return formatter.string(from: value.value as NSDecimalNumber) ?? "\(value) \(currency)"
    }
    
    // MARK: Equatable
    
    static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.value == rhs.value && lhs.currency == rhs.currency
    }
    
    // MARK: Comparable
    
    static func < (lhs: Money, rhs: Money) -> Bool {
        guard lhs.currency == rhs.currency else {
            fatalError("Cannot compare different currencies")
        }
        
        return lhs.value < rhs.value
    }
}
