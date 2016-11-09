//
//  MoreEuipmentManagementViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEquipmentListViewController.h"
#import "MoreEquipmentEmptyViewController.h"

@interface MoreEquipmentManagementViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) MoreEquipmentListViewController *moreEquipmentListViewController;

@property (strong, nonatomic) MoreEquipmentEmptyViewController *moreEquipmentEmptyViewController;


@end
