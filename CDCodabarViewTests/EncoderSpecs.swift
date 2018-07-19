//
//  CDCodabarViewTests.swift
//  CDCodabarViewTests
//
//  Created by Emil Wojtaszek on 10/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import CDCodabarView_Example

class CDCodabarViewTests: XCTestCase {

    func testThatZeroLetterCodeIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "")
        XCTAssertNil(encoder)
    }

    func testThat1LetterCodeIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A")
        XCTAssertNil(encoder)
    }

    func testThat2LettersCodeIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A0")
        XCTAssertNil(encoder)
    }

    func testThat3LettersCodeIsValid() {
        let encoder = try? CDCodabarEncoder(code: "A0B")
        XCTAssertNotNil(encoder)
    }

    func testThat17LettersCodeIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A000000000000000B")
        XCTAssertNil(encoder)
    }

    func testThatCodeWithWrongStartLetterIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "E00000000000B")
        XCTAssertNil(encoder)
    }

    func testThatCodeWithWrongStopLetterIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A00000000000E")
        XCTAssertNil(encoder)
    }

    func testThreeCodeWithUnsupportedCharacterIsInvalid() {
        let encoder = try? CDCodabarEncoder(code: "A!B")
        XCTAssertNil(encoder)
    }

    func testExampleSequance() {
        let encoder = try? CDCodabarEncoder(code: "A012B")
        XCTAssertNotNil(encoder)
        XCTAssertEqual(encoder!.sequence(), [
            1, 0, 1, 1, 0, 0, 1, 0, 0, 1,
            0,
            1, 0, 1, 0, 1, 0, 0, 1, 1,
            0,
            1, 0, 1, 0, 1, 1, 0, 0, 1,
            0,
            1, 0, 1, 0, 0, 1, 0, 1, 1,
            0,
            1, 0, 1, 0, 0, 1, 0, 0, 1, 1])
    }
}
