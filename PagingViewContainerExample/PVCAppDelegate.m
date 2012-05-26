//
//  PVCAppDelegate.m
//  PagingViewContainerExample
//
//  Created by Matt Stenerson on 5/25/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import "PVCAppDelegate.h"

@implementation PVCAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (UIView*)newViewWithTitle:(NSString *)title {
    UIView *aView = [[UIView alloc] init];
    //Randomly set the background color so we can see the frame bounds
    aView.backgroundColor = [self randomColor];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 164, 30)];
    aLabel.textColor = [UIColor blackColor];
    aLabel.backgroundColor = [UIColor clearColor];
    aLabel.font = [UIFont systemFontOfSize:18];    
    aLabel.textAlignment = UITextAlignmentLeft;
    aLabel.text = title;
    [aView addSubview:aLabel];
    
    return aView;
}

+ (UIColor *) randomColor {
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
