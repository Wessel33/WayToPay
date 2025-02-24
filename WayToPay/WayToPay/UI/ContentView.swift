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

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(paymentOptions) { paymentOption in
                    NavigationLink {
                        Text(paymentOption.title)
                    } label: {
                        PaymentOptionCell(paymentOption: paymentOption)
                    }
                }
                .onDelete(perform: deleteItems)
            }
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
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = PaymentOption(title: "New payment option")
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
