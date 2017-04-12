//
//  CDCodabarView.swift
//  CDCodabarViewSample
//
//  Created by Cole Dunsby on 2015-12-21.
//  Copyright © 2016 Cole Dunsby. All rights reserved.
//

import UIKit

@IBDesignable
public class CDCodabarView: UIView {

    @IBInspectable public var barColor: UIColor = .black { didSet { setNeedsDisplay() }}
    @IBInspectable public var textColor: UIColor = .black { didSet { setNeedsDisplay() }}
    @IBInspectable public var padding: CGFloat = 2.0 { didSet { setNeedsDisplay() }}
    @IBInspectable public var hideCode: Bool = false { didSet { setNeedsDisplay() }}
    @IBInspectable public var code: String = "A123456789B" {
        didSet {
            encoder = CDCodabarEncoder(code: code)
            setNeedsDisplay()
        }
    }
    
    private var encoder: CDCodabarEncoder?
    public var font = UIFont.systemFont(ofSize: 15.0) { didSet { setNeedsDisplay() }}
    
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
        
        guard let encoder = encoder else {
           
            
            let text = "Invalid Code"
            let textSize = text.boundingRect(with: CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil)
            
            text.draw(at: CGPoint(x: bounds.size.width / 2 - textSize.width / 2, y: bounds.size.height / 2 - textSize.height / 2), withAttributes: attributes)
            
            return
        }

        
        barColor.setFill()
        
        let multiplier: CGFloat = 1.25
        let labelHeight = ceil(code.boundingRect(with: CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil).height)
        let barHeight = bounds.size.height - (hideCode ? 0 : labelHeight + padding)
        let sequence = encoder.sequence()
        
        var narrow = 0
        var wide = 0
        
        for i in 0 ..< sequence.count {
            if sequence[i] == 0 {
                narrow += 1
            } else {
                if i < sequence.count - 1 {
                    if sequence[i + 1] == 1 {
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
        
        for i in 0 ..< sequence.count {
            if sequence[i] == 0 {
                x += barWidth
            } else {
                var customBarWidth = barWidth
                
                if i < sequence.count - 1 {
                    if sequence[i + 1] == 1 {
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
}
