//
//  PaymentAttributes.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import Foundation

struct PaymentAttributes: OptionSet, Codable {
    let rawValue: Int
    var cashbackAmount: Double = 0
    
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let cashbackEnabled = PaymentAttributes(rawValue: 1 << 0)
    
    func names() -> [String] {
        var names: [String] = []
        
        if self.contains(.cashbackEnabled) {
            names.append("Cashback: \(cashbackAmount)%")
        }
        
        return names
    }
}
