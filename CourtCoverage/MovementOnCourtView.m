//
//  MovementOnCourt.m
//  CourtCoverage
//
//  Created by Adam on 10/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovementOnCourtView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MovementOnCourtView
@synthesize ballView;
@synthesize trailView;
@synthesize leadView;
@synthesize centerView;
@synthesize a1;
@synthesize a2;
@synthesize a3;
@synthesize a4;
@synthesize a5;
@synthesize b1;
@synthesize b2;
@synthesize b3;
@synthesize b4;
@synthesize b5;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [ballView release];
    [trailView release];
    [ballView release];
    [trailView release];
    [leadView release];
    [centerView release];
    [a1 release];
    [a2 release];
    [a3 release];
    [a4 release];
    [a5 release];
    [b1 release];
    [b2 release];
    [b3 release];
    [b4 release];
    [b5 release];

    
    [super dealloc];
}


- (void)viewDidUnload
{
    [self setBallView:nil];
    [self setTrailView:nil];
    [self setBallView:nil];
    [self setTrailView:nil];
    [self setLeadView:nil];
    [self setCenterView:nil];
    [self setA1:nil];
    [self setA2:nil];
    [self setA3:nil];
    [self setA4:nil];
    [self setA5:nil];
    [self setB1:nil];
    [self setB2:nil];
    [self setB3:nil];
    [self setB4:nil];
    [self setB5:nil];
    
}

// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIImageView *)piece
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
    [piece addGestureRecognizer:rotationGesture];
    [rotationGesture release];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [piece addGestureRecognizer:pinchGesture];
    [pinchGesture release];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    //[panGesture setMaximumNumberOfTouches:2];
    //[panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    [panGesture release];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showResetMenu:)];
    [piece addGestureRecognizer:longPressGesture];
    [longPressGesture release];
    piece.userInteractionEnabled = YES;
    
}

- (void)awakeFromNib
{
    [self addGestureRecognizersToPiece:leadView];
    [self addGestureRecognizersToPiece:trailView];
    [self addGestureRecognizersToPiece:centerView];
    [self addGestureRecognizersToPiece:ballView];
    [self addGestureRecognizersToPiece:a1];
    [self addGestureRecognizersToPiece:a2];
    [self addGestureRecognizersToPiece:a3];
    [self addGestureRecognizersToPiece:a4];
    [self addGestureRecognizersToPiece:a5];
    [self addGestureRecognizersToPiece:b1];
    [self addGestureRecognizersToPiece:b2];
    [self addGestureRecognizersToPiece:b3];
    [self addGestureRecognizersToPiece:b4];
    [self addGestureRecognizersToPiece:b5];
    
}
#pragma mark -
#pragma mark === Utility methods  ===
#pragma mark

// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

// display a menu with a single item to allow the piece's transform to be reset
- (void)showResetMenu:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        UIMenuItem *resetMenuItem = [[UIMenuItem alloc] initWithTitle:@"Reset" action:@selector(resetPiece:)];
        CGPoint location = [gestureRecognizer locationInView:[gestureRecognizer view]];
        
        [self becomeFirstResponder];
        [menuController setMenuItems:[NSArray arrayWithObject:resetMenuItem]];
        [menuController setTargetRect:CGRectMake(location.x, location.y, 0, 0) inView:[gestureRecognizer view]];
        [menuController setMenuVisible:YES animated:YES];
        
        pieceForReset = [gestureRecognizer view];
        
        [resetMenuItem release];
    }
}

// animate back to the default anchor point and transform
- (void)resetPiece:(UIMenuController *)controller
{
    CGPoint locationInSuperview = [pieceForReset convertPoint:CGPointMake(CGRectGetMidX(pieceForReset.bounds), CGRectGetMidY(pieceForReset.bounds)) toView:[pieceForReset superview]];
    
    [[pieceForReset layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
    [pieceForReset setCenter:locationInSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [pieceForReset setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
}


- (void)resetPieces:(UIImageView *) uiView
 {
 CGPoint locationInSuperview = [uiView convertPoint:CGPointMake(CGRectGetMidX(uiView.bounds), CGRectGetMidY(uiView.bounds)) toView:[uiView superview]];
 
 [[uiView layer] setAnchorPoint:CGPointMake(0.5, 0.5)];
 [uiView setCenter:locationInSuperview];
 
 [UIView beginAnimations:nil context:nil];
 [uiView setTransform:CGAffineTransformIdentity];
 [UIView commitAnimations];
 }

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark

// shift the piece's center by the pan amount
// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}



// rotate the piece by the current rotation
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current rotation
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

// scale the piece by the current scale
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
}

// ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously
// prevent other gesture recognizers from recognizing simultaneously
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // if the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition
    if (gestureRecognizer.view != leadView && gestureRecognizer.view != centerView && gestureRecognizer.view != trailView)
        return NO;
    
    // if the gesture recognizers are on different views, don't allow simultaneous recognition
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    
    // if either of the gesture recognizers is the long press, don't allow simultaneous recognition
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    
    return YES;
}

//Switch Functions
-(BOOL) BallSwitchValueChanged{
    
    NSLog(@"Ball switch called");
    ballView.hidden = !(ballView.hidden);
    return ballView.hidden;
}

//Switch Functions
-(BOOL) PlayerSwitchValueChanged {
    
    NSLog(@"Player switch called");  
    //Loop through the list of player views to hide
        a1.hidden = !a1.hidden;
        a2.hidden = !a2.hidden;
        a3.hidden = !a3.hidden;
        a4.hidden = !a4.hidden;
        a5.hidden = !a5.hidden;
        b1.hidden = !b1.hidden;
        b2.hidden = !b2.hidden;
        b3.hidden = !b3.hidden;
        b4.hidden = !b4.hidden;
        b5.hidden = !b5.hidden;
    return a1.hidden;
    
}

- (void) ResetButtonPressed;

{
    NSLog(@"Reset switch called");
    [self resetPieces:a1];
    a1.frame = (CGRect){{43, 126}, a1.frame.size}; 
    [self resetPieces:a2];
    a2.frame = (CGRect){{234,178 }, a2.frame.size}; 
    [self resetPieces:a3];
    a3.frame = (CGRect){{20,294 }, a3.frame.size}; 
    [self resetPieces:a4];
    a4.frame = (CGRect){{194,328 }, a4.frame.size}; 
    [self resetPieces:a5];
    a5.frame = (CGRect){{75,328 }, a5.frame.size};
    [self resetPieces:b1];
    b1.frame = (CGRect){{55,178}, b1.frame.size};  
    [self resetPieces:b2];
    b2.frame = (CGRect){{178,223 }, b2.frame.size}; 
    [self resetPieces:b3];
    b3.frame = (CGRect){{55,294 }, b3.frame.size}; 
    [self resetPieces:b4];
    b4.frame = (CGRect){{156,305 }, b4.frame.size}; 
    [self resetPieces:b5];
    b5.frame = (CGRect){{108,328 }, b5.frame.size};
    [self resetPieces:leadView];
    leadView.frame = (CGRect){{58,386}, leadView.frame.size};
    [self resetPieces:trailView];
    trailView.frame = (CGRect){{17,107}, trailView.frame.size};
    [self resetPieces:centerView];
    centerView.frame = (CGRect){{284,211}, centerView.frame.size};
    [self resetPieces:ballView];
    ballView.frame = (CGRect){{55,126}, ballView.frame.size};
    
}



@end
