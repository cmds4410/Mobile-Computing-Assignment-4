//
//  GraphViewController.h
//  ConnorGraphingCalculator
//
//  Created by Connor Smith on 10/13/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"
#import "CalculatorBrain.h"

@interface GraphViewController : UIViewController <GraphViewDelegate>
{
    GraphView *graphView;
    CGFloat graphScale;
    NSString *zoomChange;
    id expression;
    
}

@property (retain) IBOutlet GraphView *graphView;
@property (nonatomic) IBOutlet CGFloat graphScale;
@property (retain) id expression;

- (IBAction)scaleChanged:(id)sender;

@end
