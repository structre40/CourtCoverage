//
//  MovementOnCourt.h
//  CourtCoverage
//
//  Created by Adam on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MovementOnCourtView : UIView <UIGestureRecognizerDelegate> {
    UIImageView *ballView;
    UIImageView *trailView;
    UIImageView *leadView;
    UIImageView *centerView;
    UIImageView *a1;
    UIImageView *a2;
    UIImageView *a3;
    UIImageView *a4;
    UIImageView *a5;
    UIImageView *b1;
    UIImageView *b2;
    UIImageView *b3;
    UIImageView *b4;
    UIImageView *b5;
    UIBarButtonItem *ballButtonOutlet;
    
    BOOL piecesOnTop;  // Keeps track of whether or not two or more pieces are on top of each other
	int touchCount;
    
    UIView *pieceForReset;
    
	CGPoint startTouchPosition; 
}
@property (nonatomic, retain) IBOutlet UIImageView *ballView;
@property (nonatomic, retain) IBOutlet UIImageView *trailView;
@property (nonatomic, retain) IBOutlet UIImageView *leadView;
@property (nonatomic, retain) IBOutlet UIImageView *centerView;
@property (nonatomic, retain) IBOutlet UIImageView *a1;
@property (nonatomic, retain) IBOutlet UIImageView *a2;
@property (nonatomic, retain) IBOutlet UIImageView *a3;
@property (nonatomic, retain) IBOutlet UIImageView *a4;
@property (nonatomic, retain) IBOutlet UIImageView *a5;
@property (nonatomic, retain) IBOutlet UIImageView *b1;
@property (nonatomic, retain) IBOutlet UIImageView *b2;
@property (nonatomic, retain) IBOutlet UIImageView *b3;
@property (nonatomic, retain) IBOutlet UIImageView *b4;
@property (nonatomic, retain) IBOutlet UIImageView *b5;

@end
