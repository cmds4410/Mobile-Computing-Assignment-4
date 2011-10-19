//
//  GraphViewController.m
//  ConnorGraphingCalculator
//
//  Created by Connor Smith on 10/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "GraphViewController.h"

@implementation GraphViewController

@synthesize graphView, graphScale, expression;
    
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.graphView.delegate = self;
    self.graphScale = 4;
	[self.graphView setNeedsDisplay];
    //NSLog(@"GraphViewController Expression: %@\n", self.expression);
}

- (IBAction)scaleChanged:(id)sender
{
	zoomChange = [[sender titleLabel] text];
    if ([zoomChange isEqual:@"+"])
        self.graphScale = self.graphScale * 2;
    
    if ([zoomChange isEqual:@"-"])
        self.graphScale = self.graphScale / 2;
    
    [self.graphView setNeedsDisplay];
    
}

- (float)scaleForGraphView:(GraphView *)requestor
{
	return self.graphScale;
}

- (CGFloat)yValueForGraphView:(GraphView *)requestor:(CGFloat)xValue
{
	//calcviewcontroller evaluateExpression
    CGFloat temp = [CalculatorBrain evaluateExpression:self.expression usingVariable:xValue];
     NSLog(@"at x: %f, expression is: %f", xValue, temp);
    return temp;
}


@end
