//
//  MoreEquipmentChoiceViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEquipmentModel.h"
//#import <LifesenseBluetooth/LSBLEDeviceManager.h>

@interface MoreEquipmentChoiceViewController : CommonViewController<MoreEquipmentChoiceModelDelegate>

//@property (nonatomic,strong) LSBLEDeviceManager *lsBleManager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreEquipmentChoiceModel *moreEquipmentChoiceModel;
@end
