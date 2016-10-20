//
//  MoreEquipmentSearchingViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEquipmentModel.h"
#import "FLAnimatedImage.h"

@interface MoreEquipmentSearchingViewController : CommonViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreEquipmentSearchingModel *moreEquipmentSearchingModel;

@property (weak, nonatomic) IBOutlet UIView *imageContainerView;

@property (nonatomic, strong) FLAnimatedImageView *gifImageView;

@property (assign, nonatomic) SearchDeviceKind deviceKind;

@end
