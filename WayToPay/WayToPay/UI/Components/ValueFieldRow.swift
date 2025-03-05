//
//  ValueFieldRow.swift
//  WayToPay
//
//  Created by Wesley Frost on 25/02/2025.
//

import SwiftUI

struct ValueFieldRow: View {
    @Binding var value: String
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = Locale.current.currencySymbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        HStack(spacing: 12) {
            Text("Price:")
                .font(.headline)
                .foregroundColor(.white)
            
            TextField("£0.00", value: $value, formatter: Self.formatter)
                .keyboardType(.decimalPad)
                .padding(10)
                .background(Color(UIColor.darkGray))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(12)
        .padding([.horizontal, .top])
    }
}

#Preview {
    @Previewable @State var cost = "2"
    ValueFieldRow(value: $cost)
}
