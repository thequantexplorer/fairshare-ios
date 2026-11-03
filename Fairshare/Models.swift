import Foundation
import Observation

struct LineItem: Identifiable, Hashable {
    let id = UUID()
    var description: String
    var amountCents: Int
}

struct Receipt: Identifiable, Hashable {
    let id: String
    var merchant: String
    var date: String
    var items: [LineItem]
    var participants: [String]

    var totalCents: Int { items.reduce(0) { $0 + $1.amountCents } }
}

@Observable
final class ReceiptStore {
    var receipts: [Receipt] = [
        Receipt(id: "r_1001", merchant: "Blue Bottle Coffee", date: "Oct 28",
                items: [LineItem(description: "Oat latte", amountCents: 675),
                        LineItem(description: "Cold brew", amountCents: 550),
                        LineItem(description: "Almond croissant", amountCents: 495)],
                participants: ["Maya", "Omar", "Lena"]),
        Receipt(id: "r_1002", merchant: "Team offsite dinner", date: "Oct 30",
                items: [LineItem(description: "Tasting menu x3", amountCents: 28500),
                        LineItem(description: "Wine pairing", amountCents: 9000),
                        LineItem(description: "Service", amountCents: 6751)],
                participants: ["Maya", "Omar", "Lena"]),
        Receipt(id: "r_1003", merchant: "Lyft to SFO", date: "Oct 31",
                items: [LineItem(description: "Ride", amountCents: 6400)],
                participants: ["Maya", "Omar"]),
    ]

    /// Removes `name` from the receipt, unless that would leave it with no one to split with.
    func removeParticipant(_ name: String, from receiptID: String) {
        guard let index = receipts.firstIndex(where: { $0.id == receiptID }) else { return }
        let remaining = receipts[index].participants.filter { $0 != name }
        guard !remaining.isEmpty else { return }
        receipts[index].participants = remaining
    }
}
