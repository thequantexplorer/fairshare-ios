import XCTest

final class ReceiptFlowUITests: XCTestCase {
    func testOpensReceipt() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["receipt-r_1001"].tap()
        XCTAssertTrue(app.staticTexts["each-pays"].waitForExistence(timeout: 5))
    }

    // Regression: 2.3.0 (412) crashed after Lyft to SFO -> Remove Maya -> Remove Omar.
    func testRemovingEveryParticipantDoesNotCrash() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["receipt-r_1003"].tap()

        let eachPays = app.staticTexts["each-pays"]
        XCTAssertTrue(eachPays.waitForExistence(timeout: 5))
        XCTAssertTrue(eachPays.label.contains("32.00"))

        app.buttons["remove-Maya"].tap()
        XCTAssertFalse(app.buttons["remove-Maya"].exists)
        XCTAssertTrue(eachPays.label.contains("64.00"))

        let removeOmar = app.buttons["remove-Omar"]
        XCTAssertFalse(removeOmar.isEnabled)
        removeOmar.tap()

        XCTAssertEqual(app.state, .runningForeground)
        XCTAssertTrue(app.staticTexts["Omar"].exists)
        XCTAssertTrue(eachPays.label.contains("64.00"))
    }
}
