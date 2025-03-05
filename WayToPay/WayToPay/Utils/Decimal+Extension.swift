//
//  Decimal+Extension.swift
//  WayToPay
//
//  Created by Wesley Frost on 01/03/2025.
//

import Foundation

extension Decimal {
    
    init(safe value: Any) {
        if let stringValue = value as? String, let decimal = Decimal(string: stringValue) {
            self = decimal
        } else if let decimalValue = value as? Decimal {
            self = decimalValue
        } else if let doubleValue = value as? Double {
            self = Decimal(string: "\(doubleValue)") ?? Decimal(0)
        } else if let intValue = value as? Int {
            self = Decimal(intValue)
        } else {
            self = Decimal(0)
        }
    }
    
    func rounded(toPlaces places: Int = 2) -> Decimal {
        let handler = NSDecimalNumberHandler(
            roundingMode: .bankers,
            scale: Int16(places),
            raiseOnExactness: false,
            raiseOnOverflow: false,
            raiseOnUnderflow: false,
            raiseOnDivideByZero: false
        )
        return NSDecimalNumber(decimal: self).rounding(accordingToBehavior: handler).decimalValue
    }
}
