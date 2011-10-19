//
//  GraphView.m
//  ConnorGraphingCalculator
//
//  Created by Connor Smith on 10/18/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //Draw the axes
    
    CGPoint midPoint;
	midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat scale = [self.delegate scaleForGraphView:self];
    
    [AxesDrawer drawAxesInRect:(CGRect) rect originAtPoint:(CGPoint) midPoint scale:(CGFloat) scale];
    
    //Draw the graph!
    
    //id expression = [self.delegate expressionForGraphView:self];
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(contextRef, .20, .45, .7, .7);
    for (CGFloat i = 0; i < self.bounds.size.width; i++){
        //give x value to graphViewController and expect a y value in return
        //pixels * points/pixel * units/point
        CGFloat xValue = (i/scale) - (midPoint.x/scale);
        CGFloat yValue = [self.delegate yValueForGraphView:self:(xValue)];
        
        CGContextFillEllipseInRect(contextRef, CGRectMake(i, midPoint.y - (scale * yValue), (CGFloat) 1.5, (CGFloat) 1.5));
    }
    
    
}


@end
