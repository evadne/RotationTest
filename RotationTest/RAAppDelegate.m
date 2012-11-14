//
//  RAAppDelegate.m
//  RotationTest
//
//  Created by Evadne Wu on 11/14/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAAppDelegate.h"
#import "RAThreeKnobsViewController.h"

@implementation RAAppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = [RAThreeKnobsViewController new];
	self.window.backgroundColor = [UIColor blackColor];
	
	[self.window makeKeyAndVisible];
	
	return YES;
	
}

@end
