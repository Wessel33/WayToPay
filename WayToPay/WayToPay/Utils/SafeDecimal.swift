//
//  SafeDecimal.swift
//  WayToPay
//
//  Created by Wesley Frost on 01/03/2025.
//

import Foundation

struct SafeDecimal: ExpressibleByIntegerLiteral,
                    ExpressibleByFloatLiteral,
                    ExpressibleByStringLiteral,
                    Equatable,
                    Comparable,
                    Codable {
    
    let value: Decimal
    
    init(_ safeDecimal: SafeDecimal) {
        self.value = safeDecimal.value
    }
    
    init(_ string: String) {
        self.value = Decimal(string: string) ?? Decimal()
    }
    
    init(_ decimal: Decimal) {
        self.value = decimal
    }
    
    init(_ double: Double) {
        self.value = Decimal(string: "\(double)") ?? Decimal()
    }
    
    init(_ int: Int) {
        self.value = Decimal(int)
    }

    // Ensures safe initialization from integer literals
    init(integerLiteral value: Int) {
        self.init(value)
    }

    // Ensures safe initialization from float literals
    init(floatLiteral value: Double) {
        self.init(value)
    }

    // Ensures safe initialization from string literals
    init(stringLiteral value: String) {
        self.init(value)
    }
    
    // MARK: Arithmitic
    
    static func + (lhs: SafeDecimal, rhs: SafeDecimal) -> SafeDecimal {
        return SafeDecimal(lhs.value + rhs.value)
    }
    
    static func + (lhs: Int, rhs: SafeDecimal) -> SafeDecimal {
        let lhsSD = SafeDecimal(lhs)
        
        return SafeDecimal(lhsSD + rhs)
    }
    
    static func - (lhs: SafeDecimal, rhs: SafeDecimal) -> SafeDecimal {
        return SafeDecimal(lhs.value - rhs.value)
    }
    
    static func * (lhs: SafeDecimal, rhs: SafeDecimal) -> SafeDecimal {
        return SafeDecimal(lhs.value * rhs.value)
    }
    
    static func / (lhs: SafeDecimal, rhs: SafeDecimal) -> SafeDecimal {
        return SafeDecimal(lhs.value / rhs.value)
    }
    
    static func / (lhs: SafeDecimal, rhs: Decimal) -> SafeDecimal {
        return SafeDecimal(lhs.value / rhs)
    }
    
    // MARK: Equatable
    
    static func == (lhs: SafeDecimal, rhs: SafeDecimal) -> Bool {
        return lhs.value == rhs.value
    }
    
    // MARK: Comparable
    
    static func < (lhs: SafeDecimal, rhs: SafeDecimal) -> Bool {
        return lhs.value < rhs.value
    }
}
