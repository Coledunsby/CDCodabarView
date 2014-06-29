//
//  ViewController.h
//  CDCodabarGenerator
//
//  Created by Cole Dunsby on 2014-04-17.
//  Copyright (c) 2014 Cole Dunsby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *heightValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *widthValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *paddingValueLabel;
@property (nonatomic, weak) IBOutlet UISlider *heightSlider;
@property (nonatomic, weak) IBOutlet UISlider *widthSlider;
@property (nonatomic, weak) IBOutlet UISlider *paddingSlider;
@property (nonatomic, weak) IBOutlet UISwitch *bordersSwitch;

- (IBAction)heightSliderValueChanged:(id)sender;
- (IBAction)widthSliderValueChanged:(id)sender;
- (IBAction)paddingSliderValueChanged:(id)sender;
- (IBAction)borderSwitchValueChanged:(id)sender;
- (IBAction)changeColorsButtonPressed:(id)sender;
- (IBAction)changeBarcodeButtonPressed:(id)sender;

@end
