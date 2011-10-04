//
//  CourtCoverageAppDelegate.h
//  CourtCoverage
//
//  Created by Adam on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourtCoverageViewController;

@interface CourtCoverageAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CourtCoverageViewController *viewController;

@end
