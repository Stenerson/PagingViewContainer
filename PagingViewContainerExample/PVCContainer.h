//
//  PVCContainer.h
//  Paging View Container Example
//
//  Created by Matthew Stenerson on 5/20/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PVCContainer : UIView <UIScrollViewDelegate> {
    BOOL pageControlUsed;
}

@property (nonatomic, retain) NSArray *pages;
@property (nonatomic, weak) UIView *currentPage;
@property (nonatomic, retain) UIScrollView *scrollView;
@property NSUInteger currentPageIndex;
@property float animationDuration;

//UI Elements
@property (nonatomic, retain) UIPageControl *pageControl;


//inits
-(id) initWithFrame:(CGRect)frame andPages:(NSArray*)views;
-(id) initScrollWithFrame:(CGRect)frame andPages:(NSArray*)views;


@end
