//
//  MoreEquipmentSelectViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentSelectViewController.h"

@interface MoreEquipmentSelectViewController ()

@end

@implementation MoreEquipmentSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    
    _moreEquipmentSelectModel = [[MoreEquipmentSelectModel alloc] init];
    _moreEquipmentSelectModel.delegate = self;
    _tableView.dataSource = _moreEquipmentSelectModel;
    _tableView.delegate = _moreEquipmentSelectModel;
    
    // 밴드일때
    if (_deviceKind == SearchDeviceBand) {
        
        
    }
    // 체중계일때
    else {
        [self.lsBleManager setDebugModeWithPermissions:@"sky"];
        
        self.bleConnector = [[LSBleConnector alloc] init];
        
        
//        [_lsBleManager searchLsBleDevice:[NSArray arrayWithObjects:@(LS_WEIGHT_SCALE), @(LS_SPHYGMOMETER), @(LS_FAT_SCALE), @(LS_HEIGHT_MIRIAM), @(LS_KITCHEN_SCALE), @(LS_PEDOMETER),  nil] ofBroadcastType:BROADCAST_TYPE_PAIR searchCompletion:^(LSDeviceInfo *lsDevice){
//
//            NSLog(@"%@", lsDevice);
//        }];
        
//        _lsBleManager.isBluetoothPowerOn = YES;
//        [_lsBleManager setIsBluetoothPowerOn:YES];
//        NSLog(@"%d", _lsBleManager.isBluetoothPowerOn);
//        
//        
//        [_lsBleManager searchLsBleDevice:[NSArray arrayWithObjects:@(LS_WEIGHT_SCALE), @(LS_SPHYGMOMETER), @(LS_FAT_SCALE), @(LS_HEIGHT_MIRIAM), @(LS_KITCHEN_SCALE), @(LS_PEDOMETER),  nil] ofBroadcastType:BROADCAST_TYPE_PAIR searchCompletion:^(LSDeviceInfo *lsDevice){
//            
//            NSLog(@"%@", lsDevice);
//        }];
//        
//        [_lsBleManager checkBluetoothStatus:^(BOOL isSupportFlags,BOOL isOpenFlags){
//            
//            NSLog(@"%d %d", isSupportFlags, isOpenFlags);
//        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView MoreEquipmentChoiceSelectedRow:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"goEquipmentParing" sender:nil];
}

-(LSBLEDeviceManager *)lsBleManager {
    if (!_lsBleManager)
    {
        _lsBleManager=[LSBLEDeviceManager defaultLsBleManager];
    }
    return _lsBleManager;
}

- (void)infoManagerWithMacAddr:(NSString *)macAddr peripheral:(CBPeripheral *)peripheral services:(NSArray *)gattServices {
    
}

- (void) infoManagerFinished {
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

@end
