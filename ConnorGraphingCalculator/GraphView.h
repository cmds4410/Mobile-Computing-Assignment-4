//
//  GraphView.h
//  ConnorGraphingCalculator
//
//  Created by Connor Smith on 10/18/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "AxesDrawer.h"
#import "CalculatorBrain.h"

@class GraphView;
@protocol GraphViewDelegate
- (float)scaleForGraphView:(GraphView *)requestor;
- (CGFloat)yValueForGraphView:(GraphView *)requestor:(CGFloat)xValue;
@end
@interface GraphView : UIView{
    id <GraphViewDelegate> delegate;
}

@property (assign) id <GraphViewDelegate> delegate;

@end
