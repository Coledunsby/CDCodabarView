//
//  CDCodabarView.m
//  CDCodabarGenerator
//
//  Created by Cole Dunsby on 2014-04-17.
//  Copyright (c) 2014 Cole Dunsby. All rights reserved.
//

#import "CDCodabarView.h"
#import <ctype.h>

/* 
 
 CODABAR ENCODING TABLE
 
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
 
*/

#define BAR_WIDTH 2.0f
#define PADDING 10.0f
#define HEIGHT 40.0f

@interface CDCodabarView ()
@property (nonatomic, strong) NSMutableArray *barViews;
@end

@implementation CDCodabarView

- (id)initWithCode:(NSString *)code startChar:(char)start stopChar:(char)stop
{
    self = [super init];
    
    if (self) {
        
        /* - - - - - - - - - - - - – VALIDATION - - - - - - - - - - - - -  */
        
        start = toupper(start);
        stop = toupper(stop);
        
        BOOL validStart = (start == 'A' || start == 'B' || start == 'C' || start == 'D');
        BOOL validStop = (stop == 'A' || stop == 'B' || stop == 'C' || stop == 'D');
        BOOL validCode = (code && code.length <= 16);
        
        if (!validStart) {
            NSLog(@"ERROR - Invalid start character '%c'! (must be A, B, C, or D)", toupper(start));
        }
        
        if (!validStop) {
            NSLog(@"ERROR - Invalid stop character '%c'! (must be A, B, C, or D)", toupper(stop));
        }
        
        if (!code) {
            code = @"0000000000000000";
        } else if (code.length > 16) {
            NSLog(@"ERROR - Invalid codabar code '%@'! (must be ≤ 16 characters)", code);
        }
        
        if (validStart && validStop && validCode) {
            self.backgroundColor = [UIColor whiteColor];
            self.barColor = [UIColor blackColor];
            self.barViews = [[NSMutableArray alloc] init];
            self.showCode = YES;
            
            NSDictionary *bars = @{@"0": @"101010011",
                                   @"1": @"101011001",
                                   @"2": @"101001011",
                                   @"3": @"110010101",
                                   @"4": @"101101001",
                                   @"5": @"110101001",
                                   @"6": @"100101011",
                                   @"7": @"100101101",
                                   @"8": @"100110101",
                                   @"9": @"110100101",
                                   @"-": @"101001101",
                                   @"$": @"101100101",
                                   @":": @"1101011011",
                                   @"/": @"1101101011",
                                   @".": @"1101101101",
                                   @"+": @"101100110011",
                                   @"A": @"1011001001",
                                   @"B": @"1010010011",
                                   @"C": @"1001001011",
                                   @"D": @"1010011001"};
            
            UIView *barcodeView = [[UIView alloc] init];
            NSString *newCode = [NSString stringWithFormat:@"%c%@%c", start, code, stop];
            NSMutableString *string = [[NSMutableString alloc] initWithString:@""];
            
            for (int i = 0; i < [newCode length]; i++) {
                [string appendString:[bars objectForKey:[NSString stringWithFormat:@"%C", [newCode characterAtIndex:i]]]];
                
                if (i < [newCode length] - 1) {
                    [string appendString:@"0"];
                }
            }
            
            int x = 0;
            
            for (int i = 0; i < [string length]; i++) {
                char character = [string characterAtIndex:i];
                
                if (character == '0') {
                    x += BAR_WIDTH;
                } else {
                    float barWidth = BAR_WIDTH;
                    
                    if (i < [string length] - 1)
                    {
                        if ([string characterAtIndex:i+1] == '1')
                        {
                            barWidth *= 1.25;
                        }
                    }
                    
                    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(x, 0, barWidth, HEIGHT)];
                    bar.backgroundColor = [UIColor blackColor];
                    [barcodeView addSubview:bar];
                    [self.barViews addObject:bar];
                    
                    x += barWidth;
                }
            }
            
            UILabel *label = [[UILabel alloc] init];
            label.text = code;
            [label sizeToFit];
            label.center = CGPointMake(0, HEIGHT + PADDING + (label.frame.size.height / 2) + 5);
            
            barcodeView.frame = CGRectMake(0, 0, x, HEIGHT);
            
            self.frame = CGRectMake(0, 0, barcodeView.frame.size.width + (2 * PADDING), label.frame.origin.y + label.frame.size.height + PADDING);
            
            barcodeView.center = CGPointMake(self.center.x, barcodeView.center.y + PADDING);
            label.center = CGPointMake(barcodeView.center.x, HEIGHT + PADDING + (label.frame.size.height / 2) + 5);
            
            [self addSubview:barcodeView];
            [self addSubview:label];
        }
    }
    
    return self;
}

- (void)setBarColor:(UIColor *)barColor
{
    _barColor = barColor;
    
    for (UIView *view in self.barViews) {
        view.backgroundColor = self.barColor;
    }
}

@end
