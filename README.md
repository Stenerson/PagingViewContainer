PagingViewContainer
===================

UIView based container allows you to scroll through multiple UIViews

Add PVCContainer.h and PVCContainer.m to your project and initialize like this:

    NSArray *views = [NSArray arrayWithObjects:
                      //newViewWithTitle just creates a simple UIView with a label
                       [self newViewWithTitle:@"One"]  
                      ,[self newViewWithTitle:@"Two"]
                      ,[self newViewWithTitle:@"Three"]
                      , nil];
    
    //init a container with the arra
    PVCContainer *aContainer = [[PVCContainer alloc] 
                                  initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) 
                                  andPages:views];
    
    [self.view addSubview:aContainer];
    

Check out the sample project for a working example.


This is a work in progress and more functionality and examples will be available in the future.