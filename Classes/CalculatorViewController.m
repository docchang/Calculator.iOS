//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Dominic Chang on 11/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property(readonly) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

- (CalculatorBrain *)brain {
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
		brain.radian = YES;
	}
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender{
	NSString *digit = sender.titleLabel.text;

	//prevent unnecessary leading zeros "00000"
	if ([@"0" isEqual:digit] && [@"0" isEqual:display.text]){
		userIsInTheMiddleOfTypingANumber = NO;
		return;
	}	
	
	if (userIsInTheMiddleOfTypingANumber) {	
		//if it's not a decimal or decimal is pressed but no decimal exist in the display value
		if (![@"." isEqual:digit] || ([@"." isEqual:digit] && [display.text rangeOfString:@"."].location == NSNotFound)){			
			display.text = [display.text stringByAppendingString:digit];
		}
	} else {
		display.text = digit;		 	
		userIsInTheMiddleOfTypingANumber = YES; 
		[self.brain notwaitingForOperand]; //reset not waiting for operand
	}
}

- (IBAction)operationPressed:(UIButton *)sender{
	
	//getting the NSString of the operation: +, -, *, /, =, sqrt, etc...
	NSString *operation = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber || [@"=" isEqual:operation]) {		
		self.brain.operand = display.text.doubleValue;
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	double result = [self.brain performOperation:operation];
	
	if ( isnan(result) || isinf(result) ) {
		display.text = @"Overflow";	
	} else {
		if ([@"=" isEqual:operation]){
			displaywaitingOperation.text = @"";
		}else {
			displaywaitingOperation.text = self.brain.waitingOperation;
		}		
		display.text = [NSString stringWithFormat:@"%2.15g", result];		
	}
}

- (IBAction)memPressed:(UIButton *)sender{
	NSString *operation = sender.titleLabel.text; //Operation: MC, M+, M-, MR
	
	if ([@"M+" isEqual:operation]) {
		[self.brain memAdd:display.text.doubleValue];
		displayMemory.text = @"M";
	}else if ([@"M-" isEqual:operation]) {
		[self.brain memSub:display.text.doubleValue];
		displayMemory.text = @"M";
	}else if ([@"MR" isEqual:operation]) {
		self.brain.operand = self.brain.memOperand;
		display.text = [NSString stringWithFormat:@"%2.15g", self.brain.memOperand];		
	}else if ([@"M" isEqual:displayMemory.text] && [@"MC" isEqual:operation]){
		[self.brain memClear];
		displayMemory.text = @"";
	}
}

- (IBAction)raddegToggle:(UIButton *)sender{
	self.brain.radian = self.brain.radian ^ 1;
	if (self.brain.radian){
		displayRadorDeg.text = @"Rad";
		[sender setTitle:@"Deg" forState:UIControlStateNormal];
	}else {
		displayRadorDeg.text = @"Deg";
		[sender setTitle:@"Rad" forState:UIControlStateNormal];
	}
}

@end
