//
//  LSPedometerProtocolDelegate.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 15/11/24.
//  Copyright © 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSBleDataReceiveDelegate.h"
#import "model.h"
#import "LSScanResults.h"



@class LSPedometerProtocolHandler;

@protocol LSPedometerProtocolDelegate <NSObject>

@required

//上层管理器的工作状态改变
-(void)pedometerProtocolDidWorkStatusChange:(NSInteger)workStatus;

//发现设备的详细信息，适用于没有配对过程的设备，如通用脂肪秤,厨房秤
-(void)pedometerProtocolDidDiscoverdDeviceInfo:(LSDeviceInfo *)deviceInfo;

//设备连接状态改变
-(void)pedometerProtocolDidConnectStatusChange:(DeviceConnectState)connnectState broadcastId:(NSString *)broadcastId device:(LSDeviceInfo *)deviceInfo;


-(void)pedometerProtocolDidFailToConnectDevice:(LSDeviceInfo *)lsDevice;



/*
 * 收到数据解析完后回调给外部
 *
 */
//-(void)pedometerProtocolDidReceiveModel:(id)model type:(PacketType)packetType;


/**
 *  发送回调
 *
 */
- (void)didSendStatus:(LSPedometerProtocolHandler *)handler isSuccess:(BOOL)isSuccess cmdId:(int)cmdId;
/**
 * 收到设备信息回调
 */
- (void)didReceiveDeviceInfo:(LSPedometerProtocolHandler *)handler info:(LSUDeviceInfo *)info srcData:(NSData *)srcData;
- (void)didReceiveBloodOxygen:(LSPedometerProtocolHandler *)handler info:(LSUBloodOxygen *)info srcData:(NSData *)srcData;
- (void)didReceiveHeartRate:(LSPedometerProtocolHandler *)handler info:(LSUHearRate *)info srcData:(NSData *)srcData;
- (void)didReceiveSportHeartRate:(LSPedometerProtocolHandler *)handler info:(LSUSportHeartRate *)info srcData:(NSData *)srcData;
- (void)didReceiveMeasureData:(LSPedometerProtocolHandler *)handler info:(NSArray<LSUMeasureData *> *)info srcData:(NSData *)srcData;
- (void)didReceiveSleepData:(LSPedometerProtocolHandler *)handler info:(LSUSleepData *)info srcData:(NSData *)srcData;
- (void)didReceiveSportData:(LSPedometerProtocolHandler *)handler info:(LSUSportData *)info srcData:(NSData *)srcData;
- (void)didReceiveSwimingData:(LSPedometerProtocolHandler *)handler info:(LSUSwimData *)info srcData:(NSData *)srcData;
- (void)didReceiveGetDeviceInfo:(LSPedometerProtocolHandler *)handler info:(LSUGetDeviceInfo *)info srcData:(NSData *)srcData;
- (void)didReceiveSuccessfulbool:(BOOL)successful andVoltageModel:(LSUVoltageModel *)model handler:(LSPedometerProtocolHandler *)handler;
@end

