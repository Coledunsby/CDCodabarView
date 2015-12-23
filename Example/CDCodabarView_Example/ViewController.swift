//
//  ViewController.swift
//  CDCodabarViewSample
//
//  Created by Cole Dunsby on 2015-12-21.
//  Copyright © 2015 Cole Dunsby. All rights reserved.
//

import UIKit
import CDCodabarView

class ViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var paddingLabel: UILabel!
    @IBOutlet weak var codabarView: CDCodabarView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Adding barcode programmatically
        let barcode = CDCodabarView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        barcode.code = "A1234B"
        barcode.backgroundColor = .whiteColor()
        view.addSubview(barcode)
        */
    }
    
    // MARK: - Private Functions
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
    
    func randomBarcode() -> String {
        let scalars = "A".unicodeScalars
        let unicode = Int(scalars[scalars.startIndex].value)
        
        let startChar = Character(UnicodeScalar(unicode + Int(arc4random_uniform(4))))  // A, B, C or D
        let stopChar = Character(UnicodeScalar(unicode + Int(arc4random_uniform(4))))   // A, B, C or D
        
        let barcodeLength = Int(arc4random_uniform(6)) + 5  // 5 - 10
        var barcode = ""
        
        for var i = 0; i < barcodeLength; i++ {
            barcode += String(arc4random_uniform(10))   // 0 - 9
        }
        
        return String(startChar) + barcode + String(stopChar)
    }
    
    // MARK: - IBActions
    
    @IBAction func heightSliderValueChanged(sender: UISlider) {
        heightConstraint.constant = CGFloat(sender.value)
        heightLabel.text = "\(Int(sender.value))"
        
        codabarView.setNeedsDisplay()
    }
    
    @IBAction func widthSliderValueChanged(sender: UISlider) {
        widthConstraint.constant = CGFloat(sender.value)
        widthLabel.text = "\(Int(sender.value))"
        
        codabarView.setNeedsDisplay()
    }
    
    @IBAction func paddingSliderValueChanged(sender: UISlider) {
        codabarView.padding = CGFloat(sender.value)
        paddingLabel.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction func hideCodeSwitchValueChanged(sender: UISwitch) {
        codabarView.hideCode = sender.on
    }
    
    @IBAction func changeColorsButtonTapped(sender: UIButton) {
        codabarView.barColor = randomColor()
        codabarView.textColor = randomColor()
    }
    
    @IBAction func changeBarcodeButtonTapped(sender: UIButton) {
        codabarView.code = randomBarcode()
    }

}

