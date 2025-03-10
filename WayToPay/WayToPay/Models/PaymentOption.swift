//
//  PaymentOption.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import Foundation
import SwiftData

@Model
final class PaymentOption {
    var title: String
    var attributes: PaymentAttributes
    
    init(
        title: String,
        attributes: PaymentAttributes = []
    ) {
        self.title = title
        self.attributes = attributes
    }
}
