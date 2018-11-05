import XCTest
@testable import Hyperscan

final class HyperscanTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Hyperscan().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
