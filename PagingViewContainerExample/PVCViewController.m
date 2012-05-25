//
//  PVCViewController.m
//  PagingViewContainerExample
//
//  Created by Matt Stenerson on 5/25/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import "PVCViewController.h"

#import "PVCContainer.h"

@interface PVCViewController ()
- (UIView*)newViewWithTitle:(NSString*)title;

@end

@implementation PVCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    //Add a few UIViews to an array
    NSArray *views = [NSArray arrayWithObjects:
                      //newViewWithTitle just creates a simple UIView with a label
                       [self newViewWithTitle:@"One"]  
                      ,[self newViewWithTitle:@"Two"]
                      ,[self newViewWithTitle:@"Three"]
                      , nil];
    
    
    
    //init a container with the arra
    PVCContainer *aContainer = [[PVCContainer alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) andPages:views];
    
    [self.view addSubview:aContainer];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(UIView*)newViewWithTitle:(NSString *)title {
    UIView *aView = [[UIView alloc] init];
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 10, 164, 30)];
    aLabel.textColor = [UIColor blackColor];
    aLabel.backgroundColor = [UIColor clearColor];
    aLabel.font = [UIFont systemFontOfSize:18];    
    aLabel.textAlignment = UITextAlignmentLeft;
    aLabel.text = title;
    [aView addSubview:aLabel];
    
    return aView;
}

@end
