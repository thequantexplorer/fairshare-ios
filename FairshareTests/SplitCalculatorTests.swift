import XCTest
@testable import Fairshare

final class SplitCalculatorTests: XCTestCase {
    func testEvenSplit() {
        XCTAssertEqual(SplitCalculator.share(totalCents: 900, participants: ["Maya", "Omar", "Lena"]), 300)
    }

    func testFormatsUSD() {
        XCTAssertTrue(SplitCalculator.format(cents: 6400).contains("64.00"))
    }
}
