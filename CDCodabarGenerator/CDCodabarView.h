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
- (void)setCode:(NSString *)code startChar:(char)start stopChar:(char)stop;

@property (nonatomic, strong, readonly) NSString *code;
@property (nonatomic, assign, readonly) char startChar;
@property (nonatomic, assign, readonly) char stopChar;

@property (nonatomic, strong) UIColor *barColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL hideCode;

@end
