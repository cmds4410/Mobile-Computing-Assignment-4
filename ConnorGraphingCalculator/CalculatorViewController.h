//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Connor Smith on 9/11/11.
//  Copyright 2011 Bowdoin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
    IBOutlet UILabel *display;
    IBOutlet UILabel *memDisplay;
    //Now I can disable multiple decimals
    IBOutlet UIButton *decimal;
    CalculatorBrain *brain;
    BOOL userIsInTheMiddleOfTypingANumber;
    NSDictionary *variableDictionary;
    IBOutlet UIImageView *imageView;
    
}

@property (assign) IBOutlet UILabel *display;
@property (assign) IBOutlet UILabel *memDisplay;
@property (assign) IBOutlet UIButton *decimal;
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;


    - (IBAction)digitPressed:(UIButton *)sender;
    - (IBAction)operationPressed:(UIButton *)sender;
    //for all memory functionality(sto, rec, mem+)
    - (IBAction)memoryPressed:(UIButton *)sender;
    //just for 'C'
    - (IBAction)clearPressed:(UIButton *)sender;
    //just for vars
    - (IBAction)varPressed:(UIButton *)sender;
    //Solve wth variable(s)!! 
    - (IBAction)solvePressed:(UIButton *)sender;

@end
