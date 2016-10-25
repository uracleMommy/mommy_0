//
//  MoreEquipmentParingViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import <LifesenseBluetooth/LSBLEDeviceManager.h>
#import <LifesenseBluetooth/LSBLEInfoManager.h>
#import <LifesenseBluetooth/LSBleConnector.h>
#import <LifesenseBluetooth/LSSleepRecord.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MoreEquipmentParingViewController : CommonViewController<LSBlePairingDelegate>

@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@property (weak, nonatomic) IBOutlet UIImageView *equipmentImageView;

@property (nonatomic,strong) LSBLEDeviceManager *lsBleManager;

@property (strong, nonatomic) LSDeviceInfo *lsDeviceInfo;

@end
