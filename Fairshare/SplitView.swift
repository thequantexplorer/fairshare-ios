import SwiftUI

struct SplitView: View {
    @Environment(ReceiptStore.self) private var store
    let receiptID: String

    private var receipt: Receipt? { store.receipts.first { $0.id == receiptID } }

    var body: some View {
        if let receipt {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(SplitCalculator.format(cents: receipt.totalCents))
                            .font(.system(size: 40, weight: .semibold, design: .rounded))
                        Text("Each pays \(SplitCalculator.format(cents: SplitCalculator.share(totalCents: receipt.totalCents, participants: receipt.participants)))")
                            .foregroundStyle(.secondary)
                            .accessibilityIdentifier("each-pays")
                    }
                    .padding(.vertical, 8)
                }
                Section("Splitting with") {
                    ForEach(receipt.participants, id: \.self) { name in
                        HStack {
                            Text(name)
                            Spacer()
                            Button("Remove", role: .destructive) {
                                store.removeParticipant(name, from: receipt.id)
                            }
                            .buttonStyle(.borderless)
                            .accessibilityIdentifier("remove-\(name)")
                        }
                    }
                }
                Section("Items") {
                    ForEach(receipt.items) { item in
                        LabeledContent(item.description, value: SplitCalculator.format(cents: item.amountCents))
                    }
                }
            }
            .navigationTitle(receipt.merchant)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
