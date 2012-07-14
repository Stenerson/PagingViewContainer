PagingViewContainer
===================

UIView based container allows you to scroll through multiple UIViews using either a UIScrollView (like the Stocks app) or a less traditional method using UIViews and animation.

To use add `PVCContainer.h` and `PVCContainer.m` to your project, `#import "PVCContainer.h"` and initialize like this:

```objc
// Animation method
NSArray *views = [NSArray arrayWithObjects:
  //newViewWithTitle just creates a simple UIView with a label
   [self newViewWithTitle:@"One"]  
  ,[self newViewWithTitle:@"Two"]
  ,[self newViewWithTitle:@"Three"]
  , nil];

//init an animation container with the array
PVCContainer *aContainer = [[PVCContainer alloc] 
              initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) 
              andPages:views];

[self.view addSubview:aContainer];
```
or
```obj
// UIScrollView method
NSArray *views = [NSArray arrayWithObjects:
  //newViewWithTitle just creates a simple UIView with a label
   [self newViewWithTitle:@"Uno"]  
  ,[self newViewWithTitle:@"Dos"]
  ,[self newViewWithTitle:@"Tres"]
  , nil];
    
    //init a scroll container with the array
    PVCContainer *aContainer = [[PVCContainer alloc] 
                                  initScrollWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 154) 
                                  andPages:views];
    
    [self.view addSubview:aContainer];
```

Check out the sample project for working examples in both a `UIViewController` and a `UITableViewController`.


If the pageControl is getting in your way you can hide it using `scrollContainer.pageControl.hidden = YES;`


If you have suggestions and/or improvements please fork and submit a pull request.  This is by no means optimized but I appreciate any and all feedback.