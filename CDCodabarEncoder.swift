//
//  CDCodabarEncoder.swift
//  CDCodabarViewExample
//
//  Created by Emil Wojtaszek on 10/04/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

/*********************************************************************
 
 CODABAR ENCODING TABLE (http://www.barcodeisland.com/codabar.phtml)
 
 0 => space
 1 => bar
 
 -------------------------------------------------------
 |  ASCII           |   WIDTH      |   BARCODE         |
 |  CHARACTER       |   ENCODING   |   ENCODING        |
 -------------------------------------------------------
 |  0               |   0000011    |   101010011       |
 |  1               |   0000110    |   101011001       |
 |  2               |   0001001    |   101001011       |
 |  3               |   1100000    |   110010101       |
 |  4               |   0010010    |   101101001       |
 |  5               |   1000010    |   110101001       |
 |  6               |   0100001    |   100101011       |
 |  7               |   0100100    |   100101101       |
 |  8               |   0110000    |   100110101       |
 |  9               |   1001000    |   110100101       |
 |  - (Dash)        |   0001100    |   101001101       |
 |  $               |   0011000    |   101100101       |
 |  : (Colon)       |   1000101    |   1101011011      |
 |  / (Slash)       |   1010001    |   1101101011      |
 |  . (Point)       |   1010100    |   1101101101      |
 |  + (Plus)        |   0011111    |   101100110011    |
 |  Start/Stop A    |   0011010    |   1011001001      |
 |  Start/Stop B    |	0001011    |   1010010011      |
 |  Start/Stop C    |   0101001    |   1001001011      |
 |  Start/Stop D    |	0001110    |   1010011001      |
 -------------------------------------------------------
 
*********************************************************************/

public struct CDCodabarEncoder {
    
    private struct Constants {
        
        static let minLength = 3
        static let maxLength = 16
        
        static let encodings: [Character: [Int]] = [
            "0": [1, 0, 1, 0, 1, 0, 0, 1, 1],
            "1": [1, 0, 1, 0, 1, 1, 0, 0, 1],
            "2": [1, 0, 1, 0, 0, 1, 0, 1, 1],
            "3": [1, 1, 0, 0, 1, 0, 1, 0, 1],
            "4": [1, 0, 1, 1, 0, 1, 0, 0, 1],
            "5": [1, 1, 0, 1, 0, 1, 0, 0, 1],
            "6": [1, 0, 0, 1, 0, 1, 0, 1, 1],
            "7": [1, 0, 0, 1, 0, 1, 1, 0, 1],
            "8": [1, 0, 0, 1, 1, 0, 1, 0, 1],
            "9": [1, 1, 0, 1, 0, 0, 1, 0, 1],
            "-": [1, 0, 1, 0, 0, 1, 1, 0, 1],
            "$": [1, 0, 1, 1, 0, 0, 1, 0, 1],
            ":": [1, 1, 0, 1, 0, 1, 1, 0, 1, 1],
            "/": [1, 1, 0, 1, 1, 0, 1, 0, 1, 1],
            ".": [1, 1, 0, 1, 1, 0, 1, 1, 0, 1],
            "+": [1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1],
            "A": [1, 0, 1, 1, 0, 0, 1, 0, 0, 1],
            "B": [1, 0, 1, 0, 0, 1, 0, 0, 1, 1],
            "C": [1, 0, 0, 1, 0, 0, 1, 0, 1, 1],
            "D": [1, 0, 1, 0, 0, 1, 1, 0, 0, 1]
        ]
    }
    
    enum Error: Swift.Error {
        
        case invalidLength
        case invalidStartCharacter
        case invalidEndCharacter
        case invalidIntermediateCharacter
    }
    
    private let code: String
    
    public init(code: String) throws {
        let code = code.uppercased()
        
        guard (Constants.minLength ... Constants.maxLength) ~= code.characters.count else {
            throw Error.invalidLength
        }
        
        guard let startChar = code.characters.first, ("A" ... "D") ~= startChar else {
            throw Error.invalidStartCharacter
        }
        
        guard let stopChar = code.characters.last, ("A" ... "D") ~= stopChar else {
            throw Error.invalidEndCharacter
        }
        
        guard code.characters.filter({ !Constants.encodings.keys.contains($0) }).isEmpty else {
            throw Error.invalidIntermediateCharacter
        }
        
        self.code = code
    }

    /// Return sequence of bits representing Codabar
    /// Each character is separated by `0`.
    ///
    /// - Returns: Returns array of integer representing bits
    public func sequence() -> [Int] {
        return code.characters
            .map { Constants.encodings[$0]! }
            .joined(separator: [0])
            .flatMap { $0 }
    }
}
