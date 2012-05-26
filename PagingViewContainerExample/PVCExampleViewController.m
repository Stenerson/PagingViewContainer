//
//  PVCExampleViewController.m
//  PagingViewContainer
//
//  Created by Matt Stenerson on 5/26/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import "PVCExampleViewController.h"
#import "PVCAppDelegate.h"
#import "PVCContainer.h"

@interface PVCExampleViewController ()

@end

@implementation PVCExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    /*
     
     Animated view switching
     
     */
    //Add a few UIViews to an array
    NSArray *views = [NSArray arrayWithObjects:
                      //newViewWithTitle just creates a simple UIView with a label
                      [PVCAppDelegate newViewWithTitle:@"One"]  
                      ,[PVCAppDelegate newViewWithTitle:@"Two"]
                      ,[PVCAppDelegate newViewWithTitle:@"Three"]
                      , nil];
    
    
    
    //init a container with the array
    PVCContainer *aContainer = [[PVCContainer alloc] initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 154) andPages:views];
    aContainer.animationDuration = 0.25f; //Default is 0.75f
    
    [self.view addSubview:aContainer];
    
    /*
     
     Scrolling view switching
     
     */
    //Add a few UIViews to an array
    NSArray *moreViews = [NSArray arrayWithObjects:
                          //newViewWithTitle just creates a simple UIView with a label
                          [PVCAppDelegate newViewWithTitle:@"Uno"]  
                          ,[PVCAppDelegate newViewWithTitle:@"Dos"]
                          ,[PVCAppDelegate newViewWithTitle:@"Tres"]
                          , nil];
    
    
    
    //init a container with the array
    PVCContainer *aScrollContainer = [[PVCContainer alloc] initScrollWithFrame:CGRectMake(0, 306, self.view.frame.size.width, 154) andPages:moreViews];
    
    [self.view addSubview:aScrollContainer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
