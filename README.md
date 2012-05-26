PagingViewContainer
===================

UIView based container allows you to scroll through multiple UIViews using either a UIScrollView (like the Stocks app) or a less traditional method using UIViews and animation.

To use add PVCContainer.h and PVCContainer.m to your project and initialize like this:

    // Animation method
    NSArray *views = [NSArray arrayWithObjects:
                      //newViewWithTitle just creates a simple UIView with a label
                       [self newViewWithTitle:@"One"]  
                      ,[self newViewWithTitle:@"Two"]
                      ,[self newViewWithTitle:@"Three"]
                      , nil];
    
    //init a container with the array
    PVCContainer *aContainer = [[PVCContainer alloc] 
                                  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) 
                                  andPages:views];
    
    [self.view addSubview:aContainer];
    
or

    // UIScrollView method
    NSArray *views = [NSArray arrayWithObjects:
                      //newViewWithTitle just creates a simple UIView with a label
                       [self newViewWithTitle:@"One"]  
                      ,[self newViewWithTitle:@"Two"]
                      ,[self newViewWithTitle:@"Three"]
                      , nil];
    
    //init a container with the array
    PVCContainer *aContainer = [[PVCContainer alloc] 
                                  initScrollWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) 
                                  andPages:views];
    
    [self.view addSubview:aContainer];
    

Check out the sample project for working examples.


This is a work in progress and more functionality and examples (and cleaner code) will be available in the future.