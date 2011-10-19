//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Connor Smith on 9/12/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "CalculatorBrain.h"
#define VARIABLE_PREFIX @"var"

@implementation CalculatorBrain
@synthesize operand, store, waitingOperand, waitingOperation, expression, variableDictionary;
- (id)init
{
    self = [super init];
    internalExpression = [[NSMutableArray alloc] init];
    
    
    return self;
}
- (void) dealloc
{
    [variableDictionary release];
    [internalExpression release];
    [super dealloc];
}
- (id) expression{
    myCopy = [internalExpression copy];
    [myCopy autorelease];
    return myCopy;
}
//sets the operand, as well as appending the expression    
- (void) setOperand:(double)aDouble{
    operand = aDouble;
    [internalExpression addObject:[NSNumber numberWithDouble:operand]];
}
//adds a var to the expression
- (void) setVariableAsOperand:(NSString *)variableName{
    variable = [VARIABLE_PREFIX stringByAppendingString:variableName];
    [internalExpression addObject:(NSString *)variable];
    
}
//called by solve button, evaluates expressions with variable(s)
+ (double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables
{
    CalculatorBrain *brain = [[CalculatorBrain alloc] init];
    for (id element in anExpression) {
        //adds digit to new operation
        if ([element isKindOfClass:[NSNumber class]])
            [brain setOperand:[element doubleValue]];
        //if it's a variable, add it's true value
        else if ([element isKindOfClass:[NSString class]])
            if ([element rangeOfString:@"var"].location!=NSNotFound){
                double varValue = [[variables objectForKey:element] doubleValue];
                [brain setOperand:varValue];
            }
        //otherwise it's a string so it must be an operation
            else [brain performOperation: element];
        
    }
    [brain autorelease];
    return brain.operand;
    
}

+ (double)evaluateExpression:(id)anExpression usingVariable:(CGFloat)variable
{
    CalculatorBrain *brain = [[CalculatorBrain alloc] init];
    for (id element in anExpression) {
        //adds digit to new operation
        if ([element isKindOfClass:[NSNumber class]])
            [brain setOperand:[element doubleValue]];
        //if it's a variable, add it's true value
        else if ([element isKindOfClass:[NSString class]])
            if ([element rangeOfString:@"var"].location!=NSNotFound){
                double varValue = variable;
                [brain setOperand:varValue];
            }
        //otherwise it's a string so it must be an operation
            else [brain performOperation: element];
        
    }
    [brain autorelease];
    return brain.operand;
    
}

//returns number of vars in expression, or nil of there are none
+ (NSSet *)variablesInExpression:(id)anExpression{
    NSMutableSet *tempSet = [[NSMutableSet alloc] init];
    for (id element in anExpression) {
        if ([element isKindOfClass:[NSString class]])
            if ([element rangeOfString:@"var"].location!=NSNotFound){
                [tempSet addObject:element];
            }
    }
    if ([tempSet count] == 0) {
        return nil;
    }
    [tempSet autorelease];
    return tempSet;
}
//returns string version of expression array
+ (NSString *)descriptionOfExpression:(id)anExpression{
    //String that we return, even though it's mutable...?
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (id element in anExpression) {
        //add string version of double to string
        if ([element isKindOfClass:[NSNumber class]]){
           [tempString appendString:[NSString stringWithFormat:@"%g", [element doubleValue]]];
        }
        //add string, but strip off the prefix constant if it is a variable
       else if([element isKindOfClass:[NSString class]]){
           if ([element hasPrefix:@"var"])
               element = [element substringFromIndex:3];
           [tempString appendString:element];
       }
    }           
    return [tempString autorelease];
}
//for all memory functionality
- (double) doMem:(NSString *)memOperation{
    //store the display operand in a variable called 'store'
    if ([memOperation isEqual:@"sto"]) {
        store = operand;
    }
    if ([memOperation isEqual:@"mem+"]) {
        store += operand;
    }
    if ([memOperation isEqual:@"CLR"]) {
        store = 0;
        [internalExpression removeAllObjects];
    }
    if ([memOperation isEqual:@"CLR MEM"]) {
        store = 0;
    }
    //Rec's only functionality is to return 'store' so we don't need an if-claus for it
    return store;
    
}
- (void)performWaitingOperation
{
    if ([@"+" isEqual:waitingOperation]) {
        operand = waitingOperand + operand; }
    else if ([@"*" isEqual:waitingOperation]) {
        operand = waitingOperand * operand; }
    else if ([@"-" isEqual:waitingOperation]) {
        operand = waitingOperand - operand; }
    else if ([@"/" isEqual:waitingOperation]) {
        if (operand) {
            operand = waitingOperand / operand;
        } 
    }
}


- (double) performOperation:(NSString *)operation{
    [internalExpression addObject:(NSString *) operation];
    if ([operation isEqual:@"sqrt"]) {
        operand = sqrt(operand);
    }
    //I added all of the following operations:
    else if ([operation isEqual:@"1/x"] && operand != 0)
    {
        operand = 1/(operand);
    }
    else if ([operation isEqual:@"+/-"])
    {
        operand = -1*(operand);
    }
    else if ([operation isEqual:@"sin"])
    {
        operand = sin(operand);
    }
    else if ([operation isEqual:@"cos"])
    {
        operand = cos(operand);
    }
    else if ([operation isEqual:@"CLR"])
    {
        operand = 0;
        waitingOperand = 0;
        waitingOperation = nil;
        
        
    }
    else
    {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    return operand;
}
//not quite sure why we have these, maybe they're for later
+ (id)propertyListForExpression:(id)anExpression{
    return anExpression;
}
+ (id)experessionForPropertyList:(id)propertyList{
    return propertyList;
}
@end
