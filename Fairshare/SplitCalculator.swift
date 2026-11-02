import Foundation

enum SplitCalculator {
    /// Each participant's share of the receipt, in cents.
    static func share(totalCents: Int, participants: [String]) -> Int {
        totalCents / participants.count
    }

    static func format(cents: Int) -> String {
        (Double(cents) / 100).formatted(.currency(code: "USD"))
    }
}
