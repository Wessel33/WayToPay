//
//  PaymentOptionRow.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import SwiftUI

struct PaymentOptionRow: View {
    var option: PaymentOption
    var cost: Double
    
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
                ForEach(option.attributes.names(), id: \.self) { attribute in
                    Text(attribute)
                        .font(.caption)
                        .padding(6)
                        .background(Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            
            Text("Saving: £\(cost, specifier: "%.2f")") // TODO: Make this localized currency
                .font(.subheadline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color(UIColor.darkGray))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    PaymentOptionRow(
        option: PaymentOption(
            title: "Option 1",
            attributes: .cashback
        ),
        cost: 10.00
    )
}

fileprivate extension PaymentAttributes {
    static var cashback: PaymentAttributes {
        var option: PaymentAttributes = .cashbackEnabled
        option.cashbackAmount = 5
        
        return option
    }
}
