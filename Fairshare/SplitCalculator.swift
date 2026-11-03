import Foundation

enum SplitCalculator {
    /// Each participant's share of the receipt, in cents.
    /// A receipt with no participants has no one to split with, so the payer owes the full total.
    static func share(totalCents: Int, participants: [String]) -> Int {
        guard !participants.isEmpty else { return totalCents }
        return totalCents / participants.count
    }

    static func format(cents: Int) -> String {
        (Double(cents) / 100).formatted(.currency(code: "USD"))
    }
}
