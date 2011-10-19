//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Connor Smith on 9/12/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject{
    double operand;
    double store;
    NSString *waitingOperation;
    NSString *variable;
    double waitingOperand;
    NSMutableArray *internalExpression;
    NSMutableArray *myCopy;
    NSNumber *operandSet;
}
@property (nonatomic) double operand;
@property (nonatomic) double store;
@property (copy) NSString *waitingOperation;
@property (nonatomic) double waitingOperand;
@property (readonly) id expression;
@property (readonly, nonatomic)  NSDictionary *variableDictionary;



- (void) setOperand:(double)aDouble;
- (double) performOperation:(NSString *)operation;
- (double) doMem:(NSString *)memOperation;
- (void) setVariableAsOperand:(NSString *)variableName;

+ (double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables;
+ (double)evaluateExpression:(id)anExpression usingVariable:(CGFloat)variable;

+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression;
+ (id)propertyListForExpression:(id)anExpression; 
+ (id)experessionForPropertyList:(id)propertyList;

@end
