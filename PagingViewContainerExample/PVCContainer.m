//
//  PVCContainer.m
//  Paging View Container Example
//
//  Created by Matthew Stenerson on 5/20/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import "PVCContainer.h"


@interface PVCContainer()
-(void)setUpViews;
-(void) slideView:(UIView *)viewOne toPosition:(CGPoint)pointOne andView:(UIView *)viewTwo toPosition:(CGPoint)pointTwo;
-(void) swipeLeft;
-(void) swipeRight;
-(void)pageChanged;
-(void)changePageWithSwipe:(NSInteger)indexChange;
-(void)movePageWithNewIndex:(NSInteger)index;
-(BOOL)swipeAllowedWithIndexChange:(NSInteger)indexChange;

@end

@implementation PVCContainer

@synthesize pages,currentPage,currentPageIndex, animationDuration;

@synthesize pageControl;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray*)views
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Defaults
        self.backgroundColor = [UIColor lightGrayColor];
        self.animationDuration = 0.75f;
        
        //Setup pages
        self.pages = [NSArray arrayWithArray:views];
        [self setUpViews];
        
        //Create page control
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.frame.size.height-40,
                                                                           self.frame.size.width-20, 36)];
        self.pageControl.numberOfPages = [self.pages count];
        self.pageControl.currentPage = 0;
        self.pageControl.hidesForSinglePage = YES;
        
        //if you set defersCurrentPageDisplay make sure to call updateCurrentPageDisplay when ready
        self.pageControl.defersCurrentPageDisplay = YES;
        [self.pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.pageControl];
        
        
        //Create gestures recognizers
        UISwipeGestureRecognizer *leftRecognizer;
        leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
        [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:leftRecognizer];
        
        UISwipeGestureRecognizer *rightRecognizer;
        rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
        [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:rightRecognizer];
    }
    return self;
}


#pragma mark - Privates
-(void)pageChanged {

    int newPageIndex = self.pageControl.currentPage;
    
    [self movePageWithNewIndex:newPageIndex-self.currentPageIndex];
    
    //Update the page indicator (white dot)
    [self.pageControl updateCurrentPageDisplay];
    
}

-(void)changePageWithSwipe:(NSInteger)indexChange {
    
    [self movePageWithNewIndex:indexChange];
    
    self.pageControl.currentPage = self.pageControl.currentPage+indexChange;
    
}

-(void)movePageWithNewIndex:(NSInteger)indexChange {
    
    int newPageIndex = self.currentPageIndex+indexChange;
    
    if (indexChange > 0) {
        //slide left
        [self slideView:[self.pages objectAtIndex:newPageIndex] toPosition:CGPointMake(0, 0) 
                andView:self.currentPage toPosition:CGPointMake((self.frame.size.width*-1), 0)];
    } else {
        //slide right
        [self slideView:[self.pages objectAtIndex:newPageIndex] toPosition:CGPointMake(0, 0) 
                andView:self.currentPage toPosition:CGPointMake(self.frame.size.width, 0)];
    }
    
    self.currentPage = [self.pages objectAtIndex:newPageIndex];
    self.currentPageIndex = newPageIndex;

}


-(void)setUpViews {

    int i = 0;
    
    for (UIView *aView in self.pages) {
        
        //If this is the first time through the loop the frame is already set
        if (i==0) {
                aView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }
        else {
            // if not create it off screen 
            aView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        }
        
        [self addSubview:aView];
        
        i++;
    }
    
    self.currentPageIndex = 0;
    self.currentPage = [self.pages objectAtIndex:0];
     
}


-(void) slideView:(UIView *)viewOne toPosition:(CGPoint)pointOne andView:(UIView *)viewTwo toPosition:(CGPoint)pointTwo {
    
    CGRect frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:self.animationDuration];
    
    if (viewOne) {
        frame = CGRectMake(pointOne.x, pointOne.y, viewOne.frame.size.width, viewOne.frame.size.height);
        [viewOne setFrame:frame];
    }
    
    if (viewTwo) {
        frame = CGRectMake(pointTwo.x, pointTwo.y, viewTwo.frame.size.width, viewTwo.frame.size.height);
        [viewTwo setFrame:frame];
    }
    
    [UIView commitAnimations];
    
}


-(void) swipeLeft {
    //NSLog(@"Swipe Left");
    if ([self swipeAllowedWithIndexChange:1]) {
        [self changePageWithSwipe:1];        
    }
}

-(void) swipeRight {
    //NSLog(@"Swipe Right");
    if ([self swipeAllowedWithIndexChange:-1]) {
        [self changePageWithSwipe:-1];        
    }
}

-(BOOL)swipeAllowedWithIndexChange:(NSInteger)indexChange {
    int proposedIndex = self.currentPageIndex+indexChange;
    
    if (proposedIndex >= 0 && proposedIndex < [self.pages count]) {
        return YES;
    } else {
        return NO;
    }
}


@end
