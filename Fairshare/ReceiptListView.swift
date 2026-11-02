import SwiftUI

struct ReceiptListView: View {
    @Environment(ReceiptStore.self) private var store

    var body: some View {
        NavigationStack {
            List(store.receipts) { receipt in
                NavigationLink(value: receipt.id) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(receipt.merchant).font(.headline)
                        Text("\(receipt.date) · \(SplitCalculator.format(cents: receipt.totalCents))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                .accessibilityIdentifier("receipt-\(receipt.id)")
            }
            .navigationTitle("Receipts")
            .navigationDestination(for: String.self) { id in
                SplitView(receiptID: id)
            }
        }
    }
}
