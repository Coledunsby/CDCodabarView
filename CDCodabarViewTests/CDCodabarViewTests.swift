@testable import CDCodabarViewExample
import XCTest

final class CDCodabarViewTests: XCTestCase {

    func testEmptyCodeInvalid() {
        let encoder = try? CDCodabarEncoder(code: "")
        XCTAssertNil(encoder)
    }

    func test1LetterCodeInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A")
        XCTAssertNil(encoder)
    }

    func test2LetterCodeInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A0")
        XCTAssertNil(encoder)
    }

    func test3LetterCodeValid() {
        let encoder = try? CDCodabarEncoder(code: "A0B")
        XCTAssertNotNil(encoder)
    }

    func test17LetterCodeInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A000000000000000B")
        XCTAssertNil(encoder)
    }

    func testStartLetterInvalid() {
        let encoder = try? CDCodabarEncoder(code: "E00000000000B")
        XCTAssertNil(encoder)
    }

    func testStopLetterInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A00000000000E")
        XCTAssertNil(encoder)
    }

    func testUnsupportedCharacterInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A!B")
        XCTAssertNil(encoder)
    }

    func testExampleSequence() throws {
        let encoder = try CDCodabarEncoder(code: "A012B")
        let expected = [
            1, 0, 1, 1, 0, 0, 1, 0, 0, 1,
            0,
            1, 0, 1, 0, 1, 0, 0, 1, 1,
            0,
            1, 0, 1, 0, 1, 1, 0, 0, 1,
            0,
            1, 0, 1, 0, 0, 1, 0, 1, 1,
            0,
            1, 0, 1, 0, 0, 1, 0, 0, 1, 1
        ]
        XCTAssertEqual(encoder.sequence(), expected)
    }
}
