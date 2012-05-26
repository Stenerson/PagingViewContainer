//
//  PVCAppDelegate.h
//  PagingViewContainerExample
//
//  Created by Matt Stenerson on 5/25/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PVCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (UIView*)newViewWithTitle:(NSString*)title;
+ (UIColor *) randomColor;

@end
