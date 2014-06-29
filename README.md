CDCodabarGenerator
==================

Codabar Barcode Generator for iOS.

---

How to use...
------------------

1. Copy the CDCodabarView folder into your project.

2. Import the CDCodabarView header file in the view controller you want to show the barcode.

    ```
    #import "CDCodabarView.h"
    ```

3. Initialize an instance of CDCodaBarViewController using the constructor:

    ```
    CDCodabarView *codabarView = [[CDCodabarView alloc] initWithCode:@"123456789"
                                                       startChar:'A'
                                                        stopChar:'B'];
    ```

4. Customize the barcode.

    ```
    codabarView.barColor = [UIColor blueColor];
    codabarView.textColor = [UIColor redColor];
    codabarView.hideCode = NO;
    ```

5. Add the barcode to your view.

    ```
    [self.view addSubview:self.codabarView];
    ```

---

See the sample app for a complete example.
