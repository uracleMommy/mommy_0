//
//  MoreEquipmentSelectViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentSelectViewController.h"
#import "MoreEquipmentParingViewController.h"

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
        
//        _lsBleManager=[LSBLEDeviceManager defaultLsBleManager];
        [self.lsBleManager setDebugModeWithPermissions:@"sky"];
//        self.bleConnector = [[LSBleConnector alloc] init];
        
//        [_lsBleManager searchLsBleDevice:[NSArray arrayWithObjects:@(LS_WEIGHT_SCALE), @(LS_FAT_SCALE), @(LS_HEIGHT_MIRIAM), @(LS_PEDOMETER), nil] ofBroadcastType:BROADCAST_TYPE_PAIR searchCompletion:^(LSDeviceInfo *lsDevice){
//
//            NSLog(@"%@", lsDevice);
//        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView MoreEquipmentChoiceSelectedRow:(NSIndexPath *)indexPath {
  
    [_lsBleManager stopSearch];
    
    LSDeviceInfo *deviceInfo = _moreEquipmentSelectModel.arrayList[indexPath.row];
//    [_lsBleManager pairWithLsDeviceInfo:deviceInfo pairedDelegate:self];
    
    // 여기서 페어링
    [self performSegueWithIdentifier:@"goEquipmentParing" sender:deviceInfo];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"goEquipmentParing"]) {
        
        MoreEquipmentParingViewController *moreEquipmentParingViewController = (MoreEquipmentParingViewController *)segue.destinationViewController;
        
        moreEquipmentParingViewController.lsDeviceInfo = sender;
        
    }
}

-(void)bleManagerDidPairedResults:(LSDeviceInfo *)lsDevice pairStatus:(PairedResults)pairStatus {
    
    
}

-(LSBLEDeviceManager *)lsBleManager {
    
    if (!_lsBleManager) {
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

- (IBAction)connectBluethoo:(id)sender {
    
    [_lsBleManager searchLsBleDevice:[NSArray arrayWithObjects:@(LS_WEIGHT_SCALE), @(LS_FAT_SCALE), @(LS_HEIGHT_MIRIAM), @(LS_PEDOMETER), nil] ofBroadcastType:BROADCAST_TYPE_PAIR searchCompletion:^(LSDeviceInfo *lsDevice){
        
        if (![lsDevice.rssi isEqualToNumber:@127]) {
            
            if ([lsDevice.protocolType isEqualToString:@"A2"]) {
                
                NSLog(@"디바이스 아이디 : %@, 디바이스 이름 : %@ 디바이스 프로토콜 : %@", lsDevice.deviceId, lsDevice.deviceName, lsDevice.protocolType);
                
                [_moreEquipmentSelectModel.arrayList addObject:lsDevice];
                [_tableView reloadData];
            }
        }
    }];
}

@end
