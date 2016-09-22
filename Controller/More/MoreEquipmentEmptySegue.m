//
//  MoreEquipmentEmptySegue.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentEmptySegue.h"
#import "MoreEquipmentManagementViewController.h"

@implementation MoreEquipmentEmptySegue

- (void) perform {
    
    MoreEquipmentManagementViewController *moreEquipmentManagementViewController = (MoreEquipmentManagementViewController *)self.sourceViewController;
    moreEquipmentManagementViewController.moreEquipmentEmptyViewController = (MoreEquipmentEmptyViewController *)self.destinationViewController;
    
    [moreEquipmentManagementViewController.moreEquipmentEmptyViewController.view setFrame:CGRectMake(0, 0, moreEquipmentManagementViewController.containerView.frame.size.width, moreEquipmentManagementViewController.containerView.frame.size.height)];
    [moreEquipmentManagementViewController.containerView addSubview:moreEquipmentManagementViewController.moreEquipmentEmptyViewController.view];
}

@end
