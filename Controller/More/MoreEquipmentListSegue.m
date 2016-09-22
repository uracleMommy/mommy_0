//
//  MoreEquipmentListSegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentListSegue.h"
#import "MoreEquipmentManagementViewController.h"

@implementation MoreEquipmentListSegue

- (void) perform {
    
    MoreEquipmentManagementViewController *moreEquipmentManagementViewController = (MoreEquipmentManagementViewController *)self.sourceViewController;
    moreEquipmentManagementViewController.moreEquipmentListViewController = (MoreEquipmentListViewController *)self.destinationViewController;
    
    [moreEquipmentManagementViewController.moreEquipmentListViewController.view setFrame:CGRectMake(0, 0, moreEquipmentManagementViewController.containerView.frame.size.width, moreEquipmentManagementViewController.containerView.frame.size.height)];
    [moreEquipmentManagementViewController.containerView addSubview:moreEquipmentManagementViewController.moreEquipmentListViewController.view];
}

@end
