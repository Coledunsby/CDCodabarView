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
@end

@implementation ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.codabarView = [[CDCodabarView alloc] initWithCode:@"123456789"
                                                 startChar:'A'
                                                  stopChar:'B'];
    self.codabarView.center = self.view.center;
    self.codabarView.barColor = [UIColor blueColor];
    self.codabarView.textColor = [UIColor blueColor];
    self.codabarView.hideCode = NO;
    [self.view addSubview:self.codabarView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeColor) userInfo:nil repeats:YES];
}

#pragma mark - Private Methods

- (void)changeColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.codabarView.barColor = color;
    }];
}

- (NSString *)reverseString:(NSString *)str
{
    NSMutableString *reversed = [NSMutableString string];
    NSInteger charIndex = [str length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subRange = NSMakeRange(charIndex, 1);
        [reversed appendString:[str substringWithRange:subRange]];
    }
    return reversed;
}

#pragma mark - IBActions

- (IBAction)reverseButtonPressed:(id)sender
{
    [self.codabarView setCode:[self reverseString:self.codabarView.code]
                    startChar:self.codabarView.startChar
                     stopChar:self.codabarView.stopChar];
    
    self.codabarView.center = self.view.center;
}

@end
