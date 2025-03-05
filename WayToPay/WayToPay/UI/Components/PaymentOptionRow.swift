//
//  PaymentOptionRow.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import SwiftUI

struct PaymentOptionRow: View {
    var option: PaymentOption
    var cost: Money
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(option.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Used")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            
            HStack(spacing: 8) {
                ForEach(option.attribute.names(), id: \.self) { attribute in
                    Text(attribute)
                        .font(.caption)
                        .padding(6)
                        .background(Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            Text("Saving: \(option.attribute.calculateSavings(for: cost).formatted())") // TODO: Make this localized currency
                .font(.subheadline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color(UIColor.darkGray))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
//        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var cost = Money(100.10)
    PaymentOptionRow(
        option: PaymentOption(
            title: "Option 1",
            attribute: .cashback(rate: 5.0)
        ),
        cost: cost
    )
    
    PaymentOptionRow(
        option: PaymentOption(
            title: "Option 2",
            attribute: .roundUp(factor: 2, rate: 6)
        ),
        cost: cost
    )
    
    PaymentOptionRow(
        option: PaymentOption(
            title: "Option 3",
            attribute: .roundUp(factor: 2, rate: 6, years: 2)
        ),
        cost: cost
    )
    
    PaymentOptionRow(
        option: PaymentOption(
            title: "Option 4",
            attribute: .cashbackSaving(cashbackRate: 5, savingsRate: 4.85, years: 1)
        ),
        cost: cost
    )
    
    PaymentOptionRow(
        option: PaymentOption(
            title: "Option 4",
            attribute: .cashbackSaving(cashbackRate: 5, savingsRate: 4.85, years: 2)
        ),
        cost: cost
    )
}
