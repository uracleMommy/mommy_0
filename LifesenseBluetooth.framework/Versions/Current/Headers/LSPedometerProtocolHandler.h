//
//  LSPedometerProtocolHandler.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 15/11/24.
//  Copyright © 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBPeripheral.h>
#import <CoreBluetooth/CBService.h>
#import "BleManagerProfiles.h"
#import "LSBleGattServicesConstants.h"
#import "BleDebugLogger.h"
#import "LSFormatConverter.h"
#import "LSBleConnector.h"
#import "LSBleDataParsingTools.h"
#import "LSPedometerAlarmClock.h"
#import "NSMutableArray+QueueAdditions.h"
#import "LSProtocolMessage.h"
#import "LSPedometerProtocolDelegate.h"
@class LSDBaseModel;
@interface LSPedometerProtocolHandler : NSObject
@property(nonatomic,strong)LSBleConnector *bleConnector;
@property(nonatomic,strong)id<LSPedometerProtocolDelegate> pedometerProtocolDelegate;
@property(nonatomic)BOOL enableLongConnect; //允许与A4设备建立长连接
@property(nonatomic,strong)LSPedometerUserInfo *pedometerUserInfo;
//@property(nonatomic,strong) LSRespPedometerUserInfo *pedometerUserInfoA5;
@property(nonatomic, strong) LSDeviceInfo *currentConnectedDevice;
/**
 * 是否接收数据
 */
@property(nonatomic, assign) BOOL isForbidRecvData;

//执行测量数据上传协议流程
-(void)connectWithDevice:(LSDeviceInfo *)pairedDevice peripheral:(CBPeripheral *)peripheral protocolProcesses:(NSArray *)uploadingProtocolQueue count:(NSUInteger)connectCount;


//中断正在执行的任务
-(void)interruptCurrentTask;

- (void)addResponse:(LSDBaseModel *)model;
//获取电压
- (void)getVoltageInfor;
@end
