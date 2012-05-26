//
//  PVCContainer.m
//  Paging View Container Example
//
//  Created by Matthew Stenerson on 5/20/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import "PVCContainer.h"


@interface PVCContainer()
-(void) loadScrollViewWithPage:(int)page;
-(void) setUpViews;
-(void) slideView:(UIView *)viewOne toPosition:(CGPoint)pointOne andView:(UIView *)viewTwo toPosition:(CGPoint)pointTwo;
-(void) swipeLeft;
-(void) swipeRight;
-(void) pageChanged;
-(void) changePageWithSwipe:(NSInteger)indexChange;
-(void) movePageWithNewIndex:(NSInteger)index;
-(BOOL) swipeAllowedWithIndexChange:(NSInteger)indexChange;

@end

@implementation PVCContainer

@synthesize pages,currentPage, scrollView, currentPageIndex, animationDuration;

@synthesize pageControl;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //Defaults
        self.backgroundColor = [UIColor lightGrayColor];

    }
    return self;
}

- (id) initWithFrame:(CGRect)frame andPages:(NSArray*)views
{
    self = [self initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //Defaults
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

-(id) initScrollWithFrame:(CGRect)frame andPages:(NSArray *)views {
    self = [self initWithFrame:frame];
    if (self) {
        
        
        //Setup pages
        self.pages = [NSArray arrayWithArray:views];
        
        //Setup scroll view
        self.scrollView = [[UIScrollView alloc] initWithFrame:
                           CGRectMake(0, 0, self.frame.size.width,
                                      self.frame.size.height)];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * [views count], self.frame.size.height);
        self.scrollView.userInteractionEnabled = YES;
    
        [self loadScrollViewWithPage:0];
        [self addSubview:self.scrollView];
        
        //Create page control
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.frame.size.height-40,
                                                                           self.frame.size.width-20, 36)];
        self.pageControl.numberOfPages = [self.pages count];
        self.pageControl.currentPage = 0;
        self.pageControl.hidesForSinglePage = YES;
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.pageControl];
        
        self.pageControl.numberOfPages = [views count];
        self.pageControl.currentPage = 0;
    
    }
    return self;
}




#pragma mark - Privates
- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= [self.pages count])
        return;
    
    // replace the placeholder if necessary
    UIView *aView = [self.pages objectAtIndex:page];
    if ((NSNull *)aView == [NSNull null])
    {
        NSLog(@"You need to initialize this class with an array of UIViews");
        return;
    }
    
    // add the controller's view to the scroll view
    if (aView.superview == nil)
    {
        CGRect frame = self.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        aView.frame = frame;
        [self.scrollView addSubview:aView];
        
    }
}


-(void) pageChanged {

    int newPageIndex = self.pageControl.currentPage;
    
    [self movePageWithNewIndex:newPageIndex-self.currentPageIndex];
    
    //Update the page indicator (white dot)
    [self.pageControl updateCurrentPageDisplay];
    
}

- (IBAction)changePage:(id)sender
{
    int page = self.pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

-(void) changePageWithSwipe:(NSInteger)indexChange {
    
    [self movePageWithNewIndex:indexChange];
    
    self.pageControl.currentPage = self.pageControl.currentPage+indexChange;
    
}

-(void) movePageWithNewIndex:(NSInteger)indexChange {
    
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


-(void) setUpViews {

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

-(BOOL) swipeAllowedWithIndexChange:(NSInteger)indexChange {
    int proposedIndex = self.currentPageIndex+indexChange;
    
    if (proposedIndex >= 0 && proposedIndex < [self.pages count]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}



@end
