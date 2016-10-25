//
//  MoreEquipmentListViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 21..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentListViewController.h"

@interface MoreEquipmentListViewController ()

@end

@implementation MoreEquipmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _arrayList = [[NSMutableArray alloc] init];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    // 페어링된 체중계
    /*
    NSString *deviceName = lsDevice.deviceName;
    NSString *deviceID = lsDevice.deviceId;
    NSString *deviceSN = lsDevice.deviceSn;
    NSString *deviceType = [NSString stringWithFormat:@"%d",lsDevice.deviceType];
    NSString *password = lsDevice.password;
    NSString *broadcastID = lsDevice.broadcastId;
    NSString *hardwareVersion = lsDevice.hardwareVersion;
    NSString *firmwareVersion = lsDevice.firmwareVersion;
    NSString *softwareVersion = lsDevice.softwareVersion;
    NSString *protocolType = lsDevice.protocolType;
    NSString *identifier = lsDevice.peripheralIdentifier;
    NSString *modelNumber = lsDevice.modelNumber;
    NSNumber *deviceUserNumber = [NSNumber numberWithUnsignedLong:lsDevice.deviceUserNumber];
     */
    
    // 체중계 딕셔너리
    NSDictionary *weightDic = [userDefault objectForKey:@"pairedWeightScale"];
    
    // 밴드 딕셔너리
    // 추후에 추가 예정
    
    // 공통 딕셔너리
    NSDictionary *commonDic;
    
    if (weightDic != nil) {
        
        commonDic = [NSDictionary dictionaryWithObjectsAndKeys:@"체중계", @"deviceName", weightDic[@"deviceName"], @"modelName", nil];
        [_arrayList addObject:commonDic];
        
        
    }
    
    _moreEquipmentListModel = [[MoreEquipmentListModel alloc] init];
    _moreEquipmentListModel.arrayList = _arrayList;
    _tableView.dataSource = _moreEquipmentListModel;
    _tableView.delegate = _moreEquipmentListModel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
