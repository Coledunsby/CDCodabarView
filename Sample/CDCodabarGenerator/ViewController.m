//
//  ViewController.m
//  CDCodabarGenerator
//
//  Created by Cole Dunsby on 2014-04-17.
//  Copyright (c) 2014 Cole Dunsby. All rights reserved.
//

#import "ViewController.h"
#import "CDCodabarView.h"

@interface ViewController ()

@property (nonatomic, strong) CDCodabarView *codabarView;

- (UIColor *)randomColor;
- (NSString *)randomBarcode;

@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.codabarView = [[CDCodabarView alloc] initWithCode:@"123456789"
                                                 startChar:'A'
                                                  stopChar:'B'];
    
    [self changeColorsButtonPressed:nil];
    self.codabarView.hideCode = NO;
    
    self.codabarView.center = self.view.center;
    
    [self.view addSubview:self.codabarView];
}

#pragma mark - Helper Methods

- (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

- (NSString *)randomBarcode
{
    NSMutableString *barcode = [[NSMutableString alloc] init];
    
    for (int i = 0; i < 9; i++)
    {
        [barcode appendString:[NSString stringWithFormat:@"%i", arc4random() % 10]];
    }
    
    return barcode;
}

#pragma mark - IBActions

- (IBAction)heightSliderValueChanged:(id)sender
{
    self.codabarView.barHeight = self.heightSlider.value;
    
    self.heightValueLabel.text = [NSString stringWithFormat:@"%.1f", self.heightSlider.value];
}

- (IBAction)widthSliderValueChanged:(id)sender
{
    self.codabarView.barWidth = self.widthSlider.value;
    
    self.widthValueLabel.text = [NSString stringWithFormat:@"%.1f", self.widthSlider.value];
}

- (IBAction)paddingSliderValueChanged:(id)sender
{
    self.codabarView.padding = self.paddingSlider.value;
    
    self.paddingValueLabel.text = [NSString stringWithFormat:@"%.1f", self.paddingSlider.value];
}

- (IBAction)borderSwitchValueChanged:(id)sender
{
    self.codabarView.layer.borderWidth = (self.codabarView.layer.borderWidth == 1.0) ? 0.0 : 1.0;
    
    for (UIView *view in self.codabarView.subviews)
    {
        view.layer.borderWidth = (view.layer.borderWidth == 1.0) ? 0.0 : 1.0;
    }
}

- (IBAction)changeColorsButtonPressed:(id)sender
{
    self.codabarView.barColor = [self randomColor];
    self.codabarView.textColor = [self randomColor];
}

- (IBAction)changeBarcodeButtonPressed:(id)sender
{
    [self.codabarView setCode:[self randomBarcode]
                    startChar:self.codabarView.startChar
                     stopChar:self.codabarView.stopChar];
    
    self.codabarView.center = self.view.center;
}

@end
