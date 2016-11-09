//
//  CDCodabarView.swift
//  CDCodabarViewSample
//
//  Created by Cole Dunsby on 2015-12-21.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

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

import UIKit

@IBDesignable
public class CDCodabarView: UIView {

    private let barcodeEncoding = [
        "0": "101010011",
        "1": "101011001",
        "2": "101001011",
        "3": "110010101",
        "4": "101101001",
        "5": "110101001",
        "6": "100101011",
        "7": "100101101",
        "8": "100110101",
        "9": "110100101",
        "-": "101001101",
        "$": "101100101",
        ":": "1101011011",
        "/": "1101101011",
        ".": "1101101101",
        "+": "101100110011",
        "A": "1011001001",
        "B": "1010010011",
        "C": "1001001011",
        "D": "1010011001"
    ]

    @IBInspectable public var code: String = "A123456789B" { didSet { setNeedsDisplay() }}
    @IBInspectable public var barColor: UIColor = .black { didSet { setNeedsDisplay() }}
    @IBInspectable public var textColor: UIColor = .black { didSet { setNeedsDisplay() }}
    @IBInspectable public var padding: CGFloat = 2.0 { didSet { setNeedsDisplay() }}
    @IBInspectable public var hideCode: Bool = false { didSet { setNeedsDisplay() }}
    
    public var font = UIFont(name: "AvenirNext-Regular", size: 15.0)! { didSet { setNeedsDisplay() }}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func draw(_ rect: CGRect) {
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .center
        
        let attributes = [
            NSFontAttributeName: font,
            NSForegroundColorAttributeName: textColor,
            NSParagraphStyleAttributeName: paragraphStyle,
        ] as [String : Any]
        
        if !isCodeValid() {
            let text = "Invalid Code"
            let textSize = text.boundingRect(with: CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
            
            text.draw(at: CGPoint(x: bounds.size.width / 2 - textSize.width / 2, y: bounds.size.height / 2 - textSize.height / 2), withAttributes: attributes)
            
            return
        }
        
        barColor.setFill()
        
        let multiplier: CGFloat = 1.25
        let labelHeight = ceil(code.boundingRect(with: CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil).height)
        let barHeight = bounds.size.height - (hideCode ? 0 : labelHeight + padding)
        let sequence = barSequence()
        
        var narrow = 0
        var wide = 0
        
        for i in 0 ..< sequence.characters.count {
            if sequence[i] == "0" {
                narrow += 1
            } else {
                if i < sequence.characters.count - 1 {
                    if sequence[i + 1] == "1" {
                        wide += 1
                    } else {
                        narrow += 1
                    }
                } else {
                    narrow += 1
                }
            }
        }
        
        let barWidth: CGFloat = bounds.size.width / (CGFloat(narrow) + multiplier * CGFloat(wide))
        
        var x: CGFloat = 0.0
        
        for i in 0 ..< sequence.characters.count {
            if sequence[i] == "0" {
                x += barWidth
            } else {
                var customBarWidth = barWidth
                
                if i < sequence.characters.count - 1 {
                    if sequence[i + 1] == "1" {
                        customBarWidth *= multiplier
                    }
                }
                
                UIRectFill(CGRect(x: x, y: 0, width: customBarWidth, height: barHeight))
                
                x += customBarWidth
            }
        }
        
        if !hideCode {
            (code as NSString).draw(in: CGRect(x: 0, y: barHeight + padding, width: x, height: labelHeight), withAttributes: attributes)
        }
    }
    
    private func barSequence() -> String {
        var barSequence = ""
        
        for i in 0 ..< code.characters.count {
            barSequence += barcodeEncoding[String(code[i])]!
            if i < code.characters.count - 1 {
                barSequence += "0"
            }
        }
        
        return barSequence
    }
    
    private func isCodeValid() -> Bool {
        guard code.characters.count >= 3 && code.characters.count <= 16 else { return false }
        
        let startChar = code[0].toUpper()
        let stopChar = code[code.characters.count - 1].toUpper()
        let middleString = String(code.characters.dropFirst().dropLast())
        
        let isValidStart = startChar >= "A" && startChar <= "D"
        let isValidStop = stopChar >= "A" && stopChar <= "D"
        var isValidMiddle = true
        
        for char in middleString.characters {
            if !barcodeEncoding.keys.contains(String(char)) {
                isValidMiddle = false
                break
            }
        }
        
        return isValidStart && isValidStop && isValidMiddle
    }
}

private extension String {
    
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substring(with: (characters.index(startIndex, offsetBy: r.lowerBound) ..< characters.index(startIndex, offsetBy: r.upperBound)))
    }
}

private extension Character {
    
    func toUpper() -> Character {
        return String(self).uppercased().characters.first!
    }
}
