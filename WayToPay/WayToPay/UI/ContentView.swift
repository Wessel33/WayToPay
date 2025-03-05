//
//  ContentView.swift
//  WayToPay
//
//  Created by Wesley Frost on 24/02/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var paymentOptions: [PaymentOption]
    
    @State var cost: String = "0"

    var body: some View {
        NavigationSplitView {
            VStack {
                ValueFieldRow(value: $cost)
                List {
                    ForEach(paymentOptions) { paymentOption in
                        PaymentOptionRow(
                            option: paymentOption,
                            cost: Money(100.10)
                        )
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add payment option", systemImage: "plus")
                        }
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = PaymentOption(title: "New payment option", attribute: .cashback(rate: 0))
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(paymentOptions[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PaymentOption.self, inMemory: true)
}
