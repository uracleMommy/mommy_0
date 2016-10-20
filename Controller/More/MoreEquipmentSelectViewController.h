//
//  MoreEquipmentSelectViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "MoreEquipmentModel.h"
#import <LifesenseBluetooth/LSBLEDeviceManager.h>
#import <LifesenseBluetooth/LSBLEInfoManager.h>
#import <LifesenseBluetooth/LSBleConnector.h>
#import <LifesenseBluetooth/LSSleepRecord.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MoreEquipmentSelectViewController : CommonViewController<MoreEquipmentChoiceModelDelegate, LSBleDataReceiveDelegate,CBCentralManagerDelegate,LSBLEInfoManagerDelegate,CBPeripheralDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MoreEquipmentSelectModel *moreEquipmentSelectModel;

@property (nonatomic,strong)LSBLEDeviceManager *lsBleManager;

@property (nonatomic,strong)LSBleConnector *bleConnector;

@property (assign, nonatomic) SearchDeviceKind deviceKind;

@end
