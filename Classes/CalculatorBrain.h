//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Dominic Chang on 11/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
@private
	double operand;	
	NSString *waitingOperation;
	double waitingOperand;
	BOOL waitingForOperand;

	//memory functions
	double memOperand;
	
	//Radian or Degree
	BOOL radian;
}

@property BOOL radian;
@property(readonly) double memOperand;
@property(readonly) BOOL memOption;
@property double operand;
@property(readonly) NSString * waitingOperation;


- (double)performOperation:(NSString *)operation;
- (void)notwaitingForOperand;
- (void)memClear;
- (void)memAdd:(double )memNum;
- (void)memSub:(double )memNum;

@end
