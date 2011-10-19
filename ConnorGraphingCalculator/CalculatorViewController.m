//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Connor Smith on 9/11/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "CalculatorViewController.h"
#import "GraphViewController.h"

@implementation CalculatorViewController
@synthesize display, memDisplay, decimal, userIsInTheMiddleOfTypingANumber, expression;
- (CalculatorBrain *) brain
{
    if (!brain) brain = [[CalculatorBrain alloc] init];
    return brain;
}
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [[sender titleLabel] text];
    if (userIsInTheMiddleOfTypingANumber)
    {
        [display setText:[[display text] 
                        stringByAppendingString:digit]];
        }
    //adds a digit to an expression of that is what is being displayed currently    
    else if ([CalculatorBrain variablesInExpression:[brain expression]]){
        [display setText:[[display text]stringByAppendingString: digit]];
        [[self brain] setOperand:[digit doubleValue]];
        
    }
    else
    {
        [display setText:digit];
        userIsInTheMiddleOfTypingANumber = YES;
    }
    if ([digit isEqual: @"."]){
        //disable decimal button now that we have used it
        [decimal setEnabled: NO];
    }
    //pi button calls built-in M_PI constant
    if ([digit isEqual:@"π"]){
        [display setText:[NSString stringWithFormat:@"%f", M_PI]];
    }
    
}
- (IBAction)operationPressed:(UIButton *)sender
{
    if (userIsInTheMiddleOfTypingANumber) {
        [[self brain]setOperand:[[display text] doubleValue]];
        [brain retain];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    [brain retain];
    NSString *operation = [[sender titleLabel] text];
    double result = [[self brain] performOperation:operation];
    
    [display setText:[NSString stringWithFormat:@"%g", result]];
    if ([CalculatorBrain variablesInExpression:([brain expression])]){
        NSString *temp = [CalculatorBrain descriptionOfExpression:[brain expression]];
        [display setText:temp];
    }
    //after an operation has been pressed decimal can be used on the next number
    [decimal setEnabled: YES];
    
}

//For sto, rec, and mem+
- (IBAction)memoryPressed:(UIButton *)sender
{
    if (userIsInTheMiddleOfTypingANumber) {
        [[self brain]setOperand:[[display text] doubleValue]];
        [brain retain];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    [brain retain];
    NSString *memOperation = [[sender titleLabel] text];
    double memResult = [[self brain] doMem:memOperation];
    //we'll need this for rec
    [display setText:[NSString stringWithFormat:@"%g", memResult]];
    [memDisplay setText:[NSString stringWithFormat:@"%g", memResult]];
}

//For CLR and CLR MEM buttons
- (IBAction)clearPressed:(UIButton *)sender
{
    NSString *memOperation = [[sender titleLabel] text];
    
    
    //only for regular clear button
    if ([memOperation isEqual:@"CLR"]){
    [[self brain] performOperation:memOperation];
    userIsInTheMiddleOfTypingANumber = NO;
    [display setText:[NSString stringWithFormat:@"0"]];
    }
    //memory is always cleared so we don't need to specify CLR vs CLR MEM
    [memDisplay setText:[NSString stringWithFormat:@"0"]];
    //now that we have cleared, decimal is enabled again
    [decimal setEnabled: YES];
    [[self brain] doMem:memOperation];
    
}
//for a, y, x buttons
- (IBAction)varPressed:(UIButton *)sender{
    if (userIsInTheMiddleOfTypingANumber) {
        [[self brain]setOperand:[[display text] doubleValue]];
        [brain retain];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    NSString *variable = [[sender titleLabel] text];
    [[self brain] setVariableAsOperand:variable];
    NSString *temp = [CalculatorBrain descriptionOfExpression:[brain expression]];
    [display setText:temp];
    
    
}
//creates a dictionary, grabs the expression, sends those to the model which evaluates it and returns the answer, then sets the display text to the answer
- (IBAction)solvePressed:(UIButton *)sender{
    //if user doesn't hit = before solve
    [[self brain] performOperation:@"="];
    
    variableDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:4], @"varx", [NSNumber numberWithDouble:10], @"vary", [NSNumber numberWithDouble:6], @"vara", nil];
    expression = [brain expression];
    double result = [CalculatorBrain evaluateExpression:expression usingVariableValues:variableDictionary];
    [display setText:[NSString stringWithFormat:@"%g", result]];
}

//add the graph to the navcontroller and display
- (IBAction)graphPressed:(UIButton *)sender{
    if (userIsInTheMiddleOfTypingANumber) {
        [[self brain]setOperand:[[display text] doubleValue]];
        [brain retain];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    //if user doesn't hit = before solve
    [[self brain] performOperation:@"="];
    
    GraphViewController *gvc = [[GraphViewController alloc] init];
    expression = [[self brain] expression];
    gvc.expression = expression;
    gvc.title = [[CalculatorBrain descriptionOfExpression:expression] stringByAppendingString:@"y"];
    [self.navigationController pushViewController:gvc animated:YES];
    [gvc release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Calculator";
    // Do any additional setup after loading the view from its nib.
}
- (void) dealloc
{
    [super dealloc];
    [brain release];
}
@end
