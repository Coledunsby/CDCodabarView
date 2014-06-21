//
//  CDCodabarView.h
//  CDCodabarGenerator
//
//  Created by Cole Dunsby on 2014-04-17.
//  Copyright (c) 2014 Cole Dunsby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDCodabarView : UIView

- (id)initWithCode:(NSString *)code startChar:(char)start stopChar:(char)stop;

@property (nonatomic, retain) UIColor *barColor;
@property (nonatomic, assign) BOOL showCode;

@end
