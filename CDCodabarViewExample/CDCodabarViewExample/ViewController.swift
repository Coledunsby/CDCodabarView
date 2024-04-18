import CDCodabarView
import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var widthLabel: UILabel!
    @IBOutlet private weak var paddingLabel: UILabel!
    @IBOutlet private weak var codabarView: CDCodabarView!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // addProgrammatically()
    }

    // MARK: - Private Functions

    private func randomBarcode() -> String {
        let scalars = "A".unicodeScalars
        let unicode = Int(scalars[scalars.startIndex].value)

        let startChar = Character(UnicodeScalar(unicode + Int(arc4random_uniform(4)))!)  // A, B, C or D
        let stopChar = Character(UnicodeScalar(unicode + Int(arc4random_uniform(4)))!)   // A, B, C or D

        let barcodeLength = Int(arc4random_uniform(6)) + 5  // 5 - 10
        var barcode = ""

        (0 ..< barcodeLength).forEach { _ in
            barcode += String(arc4random_uniform(10))       // 0 - 9
        }

        return String(startChar) + barcode + String(stopChar)
    }

    private func addProgrammatically() {
        let barcode = CDCodabarView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        barcode.code = "A1234B"
        barcode.backgroundColor = .white
        view.addSubview(barcode)
    }

    // MARK: - IBActions

    @IBAction private func heightSliderValueChanged(_ sender: UISlider) {
        heightConstraint.constant = CGFloat(sender.value)
        heightLabel.text = "\(Int(sender.value))"

        codabarView.setNeedsDisplay()
    }

    @IBAction private func widthSliderValueChanged(_ sender: UISlider) {
        widthConstraint.constant = CGFloat(sender.value)
        widthLabel.text = "\(Int(sender.value))"

        codabarView.setNeedsDisplay()
    }

    @IBAction private func paddingSliderValueChanged(_ sender: UISlider) {
        codabarView.padding = CGFloat(sender.value)
        paddingLabel.text = String(format: "%.1f", sender.value)
    }

    @IBAction private func hideCodeSwitchValueChanged(_ sender: UISwitch) {
        codabarView.hideCode = sender.isOn
    }

    @IBAction private func changeColorsButtonTapped(_ sender: UIButton) {
        codabarView.barColor = UIColor.random()
        codabarView.textColor = UIColor.random()
    }

    @IBAction private func changeBarcodeButtonTapped(_ sender: UIButton) {
        codabarView.code = randomBarcode()
    }
}

private extension UIColor {

    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
    }
}
