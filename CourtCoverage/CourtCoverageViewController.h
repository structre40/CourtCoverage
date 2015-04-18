//
//  CourtCoverageViewController.h
//  CourtCoverage
//
//  Created by Adam on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtCoverageViewController : UIViewController {
    
    
    UIBarButtonItem *ballButtonOutlet;
    UIBarButtonItem *playerButtonOutlet;
    IBOutlet UIButton *ballUIButton;
    UIView *MovementOnCourtView;
    BOOL ballButton;
    BOOL playerButton;
   
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *ballButtonOutlet;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *playerButtonOutlet;
@property (nonatomic, retain) IBOutlet UIView *MovementOnCourtView;

- (IBAction) BallButtonPressed:(id)sender;
- (IBAction) PlayerButtonPressed:(id)sender;
- (IBAction) ResetButtonPressed:(id)sender;


@end
