//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Dominic Chang on 11/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//	

#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize radian;
@synthesize operand;
@synthesize waitingOperation;
@synthesize memOperand;
@synthesize memOption;

//private method
- (void)performWaitingOperation:(BOOL )equal {
	if ([@"+" isEqual:waitingOperation]) {
		operand = waitingOperand + operand; 
	} else if ([@"x" isEqual:waitingOperation]) {
		operand = waitingOperand * operand; 
	} else if ([@"-" isEqual:waitingOperation]) {
		if (waitingForOperand){
			operand = operand - waitingOperand; 
		}else {
			operand = waitingOperand - operand; 
		}		
	} else if ([@"/" isEqual:waitingOperation]) {
		if (waitingForOperand){
			operand = operand / waitingOperand;		
		}else {
			operand = waitingOperand / operand;
		}
	} else {
		waitingForOperand = YES;
	}
}

- (void)memClear{
	memOperand = 0;
}
- (void)memAdd:(double )memNum{
	memOperand = memOperand + memNum;
}
- (void)memSub:(double )memNum{
	memOperand = memOperand - memNum;
}

//reset BOOL waitingForOperand
- (void)notwaitingForOperand{
	waitingForOperand = NO;
}

- (double)performOperation:(NSString *)operation{
	
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if ([@"+/-" isEqual:operation]) {
		if (operand != 0) {
			operand = -operand;
		}
	}
	else if ([@"1/x" isEqual:operation]) {
		operand = 1/operand;
	}
	else if ([@"x^2" isEqual:operation]) {
		operand = pow(operand , 2);
	}
	else if ([@"x^3" isEqual:operation]) {
		operand = pow(operand , 3);
	}
	else if ([@"sin" isEqual:operation]) {		
		if (radian){
			operand = sin(operand);
		}else {//Degree
			operand = sin(operand * M_PI / 180);
		}	
	}
	else if ([@"cos" isEqual:operation]) {
		if (radian){
			operand = cos(operand);
		}else {//Degree
			operand = cos(operand * M_PI / 180);
		}
	}
	else if ([@"tan" isEqual:operation]) {
		if (radian){
			operand = tan(operand);
		}else {//Degree
			operand = tan(operand * M_PI / 180);
		}
	}
	
	//clear
	else if ([@"C" isEqual:operation]){
		operand = 0;
		waitingOperation = @"";
		waitingOperand = 0;
	}
	
	else if ([@"=" isEqual:operation]){
		double originalOperand = operand;		
		[self performWaitingOperation:YES];
		if (!waitingForOperand){
			waitingOperand = originalOperand;			
			waitingForOperand = YES;			
		}
	}
	
	//two operand operations e.g. +,-,*,/ 
	else {
		//perform operation if it is not waiting for an operand
		if (!waitingForOperand){
			[self performWaitingOperation:NO];			
		}
		waitingOperand = operand;
		waitingOperation = operation;		
	}
	
	return operand;
}


@end
									