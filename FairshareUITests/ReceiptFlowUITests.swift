import XCTest

final class ReceiptFlowUITests: XCTestCase {
    func testOpensReceipt() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["receipt-r_1001"].tap()
        XCTAssertTrue(app.staticTexts["each-pays"].waitForExistence(timeout: 5))
    }
}
