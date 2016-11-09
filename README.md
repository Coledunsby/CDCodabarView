# CDCodabarView

[![Version](https://img.shields.io/cocoapods/v/CDCodabarView.svg?style=flat)](http://cocoapods.org/pods/CDCodabarView)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://cocoapods.org/pods/CDCodabarView)
[![Platform](https://img.shields.io/cocoapods/p/CDCodabarView.svg?style=flat)](http://cocoapods.org/pods/CDCodabarView)
[![Language](http://img.shields.io/badge/language-swift-orange.svg?style=flat
             )](https://developer.apple.com/swift/)

## What is it?

CDCodabarView is a [Codabar](https://en.wikipedia.org/wiki/Codabar) barcode generator for iOS.

It is written in Swift 3 and uses `IBDesignable`, `IBInspectable` and Core Graphics.


## Installation

CDCodabarView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```
pod 'CDCodabarView'
```

Alternatively, you can install it manually by copying the file `CDCodabarView.swift` into your project.


## Usage (Storyboards)

1. Drag a UIView into your storyboard.
2. Change the class of the UIView to `CDCodabarView`.
3. Customize your barcode using the inspector.

![alt tag](https://github.com/Coledunsby/CDCodabarView/blob/master/Images/Storyboard.png)

## Usage (Programmatically)

1. Import the module:

    ```
    import CDCodabarView
    ```

2. Initialize an instance of `CDCodabarView` using the constructor:

    ```
    let codabarView = CDCodabarView()
    codabarView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
    codabarView.code = "A12345B"
    codabarView.backgroundColor = .white
    ```

3. Customize the barcode:

    ```
    codabarView.barColor = .blue
    codabarView.textColor = .red
    codabarView.padding = 5
    codabarView.hideCode = false
    codabarView.font = UIFont(name: "AvenirNext-Regular", size: 15.0)!
    ```

4. Add the barcode to your view:

    ```
    view.addSubview(codabarView)
    ```

## Author

Cole Dunsby, coledunsby@gmail.com

## License

CDCodabarView is available under the MIT license. See the LICENSE file for more info.
