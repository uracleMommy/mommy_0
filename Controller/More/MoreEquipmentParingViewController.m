//
//  MoreEquipmentParingViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 9. 22..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MoreEquipmentParingViewController.h"

@interface MoreEquipmentParingViewController ()


@end

@implementation MoreEquipmentParingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showIndicator];
    
    _equipmentImageView.layer.cornerRadius = 10;
    _lsBleManager = [LSBLEDeviceManager defaultLsBleManager];
    [_lsBleManager pairWithLsDeviceInfo:_lsDeviceInfo pairedDelegate:self];
}

-(void)bleManagerDidPairedResults:(LSDeviceInfo *)lsDevice pairStatus:(PairedResults)pairStatus {
    
    // 성공
    if (pairStatus == PAIRED_SUCCESS) {
        
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
        
        NSDictionary *devicedic = [NSDictionary dictionaryWithObjectsAndKeys:deviceName, @"deviceName", deviceID, @"deviceID", deviceSN, @"deviceSN", deviceType, @"deviceType", password, @"password", broadcastID, @"broadcastID", hardwareVersion, @"hardwareVersion", firmwareVersion, @"firmwareVersion", softwareVersion, @"softwareVersion", protocolType, @"protocolType", identifier, @"identifier", modelNumber, @"modelNumber", deviceUserNumber, @"deviceUserNumber", nil];
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:devicedic forKey:@"pairedWeightScale"];
        
        [userDefault synchronize];
        
        // 루트 페이지로 이동
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    // 실패
    else {
        
        // 검색 페이지로 이동 / 검색 페이지 초기화
    }
    
    [self hideIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
