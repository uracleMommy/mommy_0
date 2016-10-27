//
//  LSBleDataReceiveDelegate.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-12.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleManagerProfiles.h"
//#import "LSOTAManager.h"
//#import "LSPedometerProtocolHandler.h"
#import "model.h"
#import "LSErrorRecord.h"
//@class LSPedometerProtocolHandler;

@protocol LSBleDataReceiveDelegate <NSObject>

@optional

//接收体重测量数据
-(void)bleManagerDidReceiveWeightMeasuredData:(LSWeightData*)data device:(LSDeviceInfo *)device;

//接收计步器测量数据
-(void)bleManagerDidReceivePedometerMeasuredData:(LSPedometerData*)data device:(LSDeviceInfo *)device;

//接收血压计测量数据
-(void)bleManagerDidReceiveSphygmometerMeasuredData:(LSSphygmometerData *)data device:(LSDeviceInfo *)device;

//接收身高测量数据
-(void)bleManagerDidReceiveHeightMeasuredData:(LSHeightData*)data device:(LSDeviceInfo *)device;

//接收脂肪秤测量数据
-(void)bleManagerDidReceiveWeightAppendMeasuredData:(LSWeightAppendData*)data device:(LSDeviceInfo *)device;

//接收产品用户信息
-(void)bleManagerDidReceiveProductUserInfo:(LSProductUserInfo *)userInfo device:(LSDeviceInfo *)device;

//接收产品用户信息写成功回调
-(void)bleManagerDidWriteSuccessForProductUserInfo:(NSString *)deviceId memberId:(NSString *)memberId device:(LSDeviceInfo *)device;

//接收计步器用户信息写成功回调
-(void)bleManagerDidWriteSuccessForPedometerUserInfo:(NSString *)deviceId memberId:(NSString *)memberId device:(LSDeviceInfo *)device;

//接收计步器闹钟设置成功回调
-(void)bleManagerDidWriteSuccessForAlarmClock:(NSString *)deviceId memberId:(NSString *)memberId device:(LSDeviceInfo *)device;
/*
 *新增加接口部分，支持厨房秤
 */
//接收设备的详细信息
-(void)bleManagerDidDiscoveredDeviceInfo:(LSDeviceInfo *)deviceInfo;

//接收厨房秤的测量数据
-(void)bleManagerDidReceiveKitchenScaleMeasuredData:(LSKitchenScaleData *)kitchenData device:(LSDeviceInfo *)device;

//连接状态改变
-(void)bleManagerDidConnectStateChange:(DeviceConnectState)connectState deviceName:(NSString *)deviceName device:(LSDeviceInfo *)device;

//接收Ａ4设备的运动测量数据
-(void)bleManagerDidReceivePedometerMeasuredDataForA4:(NSArray *)dataList commandCode:(CommandRequestCode)code device:(LSDeviceInfo *)device;

//接收Ａ4设备的睡眠测量数据
-(void)bleManagerDidReceivePedometerSleepInfoForA4:(NSArray *)sleepInfoList  device:(LSDeviceInfo *)device;

//接收A5手环上传的测量数据，根据packet type 进行转换
//-(void)bleManagerDidReceivePedometerMeasuredDataForA5:(id)dataObject type:(PacketType)packetType;



/**
 *  收到设备信息,这个是设备主动上传
 *
 *  @param info 设备信息模型
 */
- (void)bleManagerDidReceiveDeviceInfo:(LSUDeviceInfo *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  收到血氧数据
 *
 *  @param info 血氧数据模型
 */
- (void)bleManagerDidReceiveBloodOxygen:(LSUBloodOxygen *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  收到心率数据
 *
 *  @param info 心率数据模型
 */
- (void)bleManagerDidReceiveHeartRate:(LSUHearRate *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  收到运动心率数据
 *
 *  @param info 运动心率数据模型
 */
- (void)bleManagerDidReceiveSportHeartRate:(LSUSportHeartRate *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  收到测量数据
 *
 *  @param info 测量数据模型
 */
- (void)bleManagerDidReceiveMeasureData:(NSArray<LSUMeasureData *> *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  收到睡眠数据
 *
 *  @param info 睡眠数据模型
 */
- (void)bleManagerDidReceiveSleepData:(LSUSleepData *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;
/**
 *  收到跑步数据
 *
 *  @param info 跑步数据模型
 */
- (void)bleManagerDidReceiveSportData:(LSUSportData *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  收到游泳数据
 *
 *  @param info 游泳数据模型
 */
- (void)bleManagerDidReceiveSwimingData:(LSUSwimData *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  获取到设备信息,这个是需要向设备发送获取设备信息指令才会执行
 *
 *  @param info 获取到的设备信息数据
 */
- (void)bleManagerDidReceiveGetDeviceInfo:(LSUGetDeviceInfo *)info srcData:(NSData *)srcData device:(LSDeviceInfo *)device;

/**
 *  电量信息回调
 *
 *  @param info 电量信息,如果获取不到，则info = nil
 *  @param device 设备
 */
- (void)bleManagerDidReceiveBatteryInfo:(LSUVoltageModel *)info device:(LSDeviceInfo *)device;

-(void)bleManagerDidReceiveErrorRecord:(LSErrorRecord *)errorRecord targetDevice:(NSString *)broadcastId;


-(void)bleManagerDidReceiveErrorRecords:(NSArray *)errorRecords targetDevice:(NSString *)broadcastId;

/**
 *  获取到时区
 *
 *  @param timezone 时区
 *  @param device   设备
 */
- (void)bleManagerDidReceiveDeviceTimeZone:(NSInteger)timezone device:(LSDeviceInfo *)device;

/*
#pragma mark OTA
- (void)otaMgrState:(LSOTAManagerCode)state;
- (void)otaMgrUpgradePercent:(NSInteger)percent;
*/
@end
