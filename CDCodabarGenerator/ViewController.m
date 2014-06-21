//
//  ViewController.m
//  CDCodabarGenerator
//
//  Created by Cole Dunsby on 2014-04-17.
//  Copyright (c) 2014 Cole Dunsby. All rights reserved.
//

#import "ViewController.h"
#import "CDCodabarView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CDCodabarView *codabarView = [[CDCodabarView alloc] initWithCode:@"0" startChar:'A' stopChar:'B'];
    codabarView.center = self.view.center;
    codabarView.barColor = [UIColor blueColor];
    [self.view addSubview:codabarView];
}

@end
