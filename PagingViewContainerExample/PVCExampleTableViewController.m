//
//  PVCExampleTableViewController.m
//  PagingViewContainer
//
//  Created by Matt Stenerson on 5/26/12.
//  Copyright (c) 2012 Techapolis. All rights reserved.
//

#import "PVCExampleTableViewController.h"
#import "PVCContainer.h"
#import "PVCAppDelegate.h"

@interface PVCExampleTableViewController ()
- (PVCContainer*)exampleAnimationContainer;
- (PVCContainer*)exampleScrollContainer;
@end

@implementation PVCExampleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
               
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
}

- (PVCContainer*)exampleAnimationContainer {
    NSArray *animationArray = [NSArray arrayWithObjects:
                               //newViewWithTitle just creates a simple UIView with a label
                               [PVCAppDelegate newViewWithTitle:@"One"]  
                               ,[PVCAppDelegate newViewWithTitle:@"Two"]
                               ,[PVCAppDelegate newViewWithTitle:@"Three"]
                               , nil];
    
    //init an animation container with the array
    PVCContainer *animationContainer = [[PVCContainer alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) andPages:animationArray];
    animationContainer.animationDuration = 0.25f; //Default is 0.75f
    
    return animationContainer;
}

- (PVCContainer*)exampleScrollContainer {
    NSArray *scrollArray = [NSArray arrayWithObjects:
                        //newViewWithTitle just creates a simple UIView with a label
                        [PVCAppDelegate newViewWithTitle:@"Uno"]  
                        ,[PVCAppDelegate newViewWithTitle:@"Dos"]
                        ,[PVCAppDelegate newViewWithTitle:@"Thes"]
                        , nil];
    
    //init a scroll container with the array
    PVCContainer *scrollContainer = [[PVCContainer alloc] initScrollWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) andPages:scrollArray];
    
    return scrollContainer;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Animation Style";
            break;
        case 1:
            return @"Scroll Style";
            break;
        default:
            return @"";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        UITableViewCell *aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = aCell;
    }
    
    
    // Configure the cell...
    if (indexPath.section == 0) {
        [cell addSubview:[self exampleAnimationContainer]];    
    } else {
        [cell addSubview:[self exampleScrollContainer]];
    }
    
    
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 154;
}

@end
