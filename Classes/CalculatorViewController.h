//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Dominic Chang on 11/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"
#include <math.h>

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	IBOutlet UILabel *displaywaitingOperation;
	IBOutlet UILabel *displayMemory;
	IBOutlet UILabel *displayRadorDeg;
	
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;
}

//digits or decimal points
- (IBAction)digitPressed:(UIButton *)sender;

//operations
- (IBAction)operationPressed:(UIButton *)sender;

//memory operations
- (IBAction)memPressed:(UIButton *)sender;

//Radian / Degree toggle
- (IBAction)raddegToggle:(UIButton *)sender;

@end
