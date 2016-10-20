//
//  LSPedometerPeripheralDelegate.h
//  LSBluetooth-Library
//
//  Created by lifesense on 15/8/12.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSScanResults.h"

@protocol LSPedometerPeripheralDelegate <NSObject>

@required

//上层管理器的工作状态改变
-(void)pedometerPeripheralDidWorkStatusChange:(NSInteger)workStatus;

//发现设备的详细信息，适用于没有配对过程的设备，如通用脂肪秤,厨房秤
-(void)pedometerPeripheralDidDiscoverdDeviceInfo:(LSDeviceInfo *)deviceInfo;

//设备连接状态改变
-(void)pedometerPeripheralDidConnectStatusChange:(DeviceConnectState)connnectState broadcastId:(NSString *)broadcastId device:(LSDeviceInfo *)deviceInfo;

//about A4 pedometer
//接收A4设备上传的命令请求信息
-(void)pedometerPeripheralDidReceivePedometerCommandRequest:(id)commandRequest commandCode:(CommandRequestCode)commandCode deviceInfo:(LSDeviceInfo *)deviceInfo characteristic:(NSInteger)characteristicUuid;


//数据上传完成标记
-(void)pedometerPeripheralDidDataReceiveComplete:(NSUInteger)completedFlag deviceId:(NSString *)deviceId;

@end
