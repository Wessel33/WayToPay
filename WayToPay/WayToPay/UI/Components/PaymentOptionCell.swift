//
//  PaymentOptionCell.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import SwiftUI

struct PaymentOptionCell: View {
    var paymentOption: PaymentOption
    
    var body: some View {
        Text(paymentOption.title)
    }
}

#Preview {
    PaymentOptionCell(paymentOption: PaymentOption(title: "Option 1"))
}
