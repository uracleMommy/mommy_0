//
//  DashBoardSegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 18..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "DashBoardSegue.h"
#import "TabbarDashBoardNavController.h"


@implementation DashBoardSegue

- (void) perform {    
    
    TabbarDashBoardNavController *dashboardContainerNavi =  (TabbarDashBoardNavController *)self.sourceViewController;
    UIViewController *DashboardController = (UIViewController *)self.destinationViewController;
    [dashboardContainerNavi pushViewController:DashboardController animated:NO];
}

@end
