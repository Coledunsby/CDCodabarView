CDCodabarView
==================

Using Storyboards
------------------

1. Copy the CDCodabarView folder into your project.
2. Drag a UIView into your storyboard.
3. Change the class of the UIView to CDCodabarView.
4. Customize your barcode using the inspector.

![alt tag](https://github.com/Coledunsby/CDCodabarView/blob/master/Images/Storyboard.png)

Programmatically
------------------

1. Copy the CDCodabarView folder into your project.

2. Initialize an instance of CDCodaBarViewController using the constructor:

    ```
    let codabarView = CDCodabarView()
    codabarView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
    codabarView.code = "A12345B"
    codabarView.backgroundColor = .whiteColor()
    ```

4. Customize the barcode.

    ```
    codabarView.barColor = .blueColor()
    codabarView.textColor = .redColor()
    codabarView.padding = 5
    codabarView.hideCode = false
    codabarView.font = UIFont(name: "AvenirNext-Regular", size: 15.0)!
    ```

5. Add the barcode to your view.

    ```
    view.addSubview(codabarView)
    ```
