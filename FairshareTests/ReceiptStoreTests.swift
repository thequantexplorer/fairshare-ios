import XCTest
@testable import Fairshare

final class ReceiptStoreTests: XCTestCase {
    private func participants(_ store: ReceiptStore, _ id: String) -> [String] {
        store.receipts.first { $0.id == id }!.participants
    }

    func testRemovesParticipantWhenOthersRemain() {
        let store = ReceiptStore()
        store.removeParticipant("Maya", from: "r_1003")
        XCTAssertEqual(participants(store, "r_1003"), ["Omar"])
    }

    // Regression: 2.3.0 (412) crashed with "Division by zero" after removing Maya then Omar from "Lyft to SFO".
    func testCannotRemoveLastParticipant() {
        let store = ReceiptStore()
        store.removeParticipant("Maya", from: "r_1003")
        store.removeParticipant("Omar", from: "r_1003")
        XCTAssertEqual(participants(store, "r_1003"), ["Omar"])
        let receipt = store.receipts.first { $0.id == "r_1003" }!
        XCTAssertEqual(SplitCalculator.share(totalCents: receipt.totalCents, participants: receipt.participants), 6400)
    }

    func testRemovingDuplicateNamesCannotEmptyReceipt() {
        let store = ReceiptStore()
        store.receipts[2].participants = ["Maya", "Maya"]
        store.removeParticipant("Maya", from: "r_1003")
        XCTAssertEqual(participants(store, "r_1003"), ["Maya", "Maya"])
    }
}
