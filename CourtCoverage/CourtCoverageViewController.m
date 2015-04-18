//
//  CourtCoverageViewController.m
//  CourtCoverage
//
//  Created by Adam on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "CourtCoverageViewController.h"

@implementation CourtCoverageViewController

@synthesize ballButtonOutlet;
@synthesize MovementOnCourtView;
@synthesize playerButtonOutlet;

- (void)dealloc
{
    
    [ballButtonOutlet release];
    [MovementOnCourtView release];
    [ballUIButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    ballButton = true;
    playerButton = true;
    
}


- (void)viewDidUnload
{
    [self setBallButtonOutlet:nil];
    [self setMovementOnCourtView:nil];
    [ballUIButton release];
    ballUIButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
        return YES;
    return NO;
    
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




- (IBAction) BallButtonPressed:(id)sender {
    
    NSLog(@"Ball lbutton pressed");
    [MovementOnCourtView  BallSwitchValueChanged];
    if ( ballButton )
    {
        NSLog(@"Show");
        ballButtonOutlet.title = @"Show Ball";
        ballButton = false;
    }
    else
    {
        NSLog(@"Hide");
        ballButtonOutlet.title = @"Hide Ball";
        ballButton = true;
    }
}
- (IBAction) ResetButtonPressed:(id)sender {
    
    NSLog(@"Ball lbutton pressed");
    [MovementOnCourtView ResetButtonPressed];
}
- (IBAction) PlayerButtonPressed:(id)sender {
    
    NSLog(@"Ball lbutton pressed");
    [MovementOnCourtView PlayerSwitchValueChanged];
    if ( playerButton )
    {
        NSLog(@"Show");
        playerButtonOutlet.title = @"Show Players";
        playerButton = false;
    }
    else
    {
        NSLog(@"Hide");
        playerButtonOutlet.title = @"Hide Players";
        playerButton = true;
    }
}
@end
