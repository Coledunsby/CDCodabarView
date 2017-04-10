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
        let encoder = CDCodabarEncoder(code: "")
        XCTAssertNil(encoder)
    }

    func testThat1LetterCodeIsInvalid() {
        let encoder = CDCodabarEncoder(code: "A")
        XCTAssertNil(encoder)
    }

    func testThat2LettersCodeIsInvalid() {
        let encoder = CDCodabarEncoder(code: "A0")
        XCTAssertNil(encoder)
    }

    func testThat3LettersCodeIsValid() {
        let encoder = CDCodabarEncoder(code: "A0B")
        XCTAssertNotNil(encoder)
    }

    func testThat17LettersCodeIsInvalid() {
        let encoder = CDCodabarEncoder(code: "A000000000000000B")
        XCTAssertNil(encoder)
    }

    func testThatCodeWithWrongStartLetterIsInvalid() {
        let encoder = CDCodabarEncoder(code: "E00000000000B")
        XCTAssertNil(encoder)
    }

    func testThatCodeWithWrongStopLetterIsInvalid() {
        let encoder = CDCodabarEncoder(code: "A00000000000E")
        XCTAssertNil(encoder)
    }

    func testThreeCodeWithUnsupportedCharacterIsInvalid() {
        let encoder = CDCodabarEncoder(code: "A!B")
        XCTAssertNil(encoder)
    }

    func testExampleSequance() {
        let encoder = CDCodabarEncoder(code: "A012B")
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
