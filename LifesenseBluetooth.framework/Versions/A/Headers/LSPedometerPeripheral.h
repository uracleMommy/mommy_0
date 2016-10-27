//
//  LSPedometerPeripheral.h
//  LSBluetooth-Library
//
//  Created by lifesense on 15/8/12.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
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
#import "LSPedometerPeripheralDelegate.h"

@interface LSPedometerPeripheral : NSObject

@property(nonatomic,strong)LSBleConnector *bleConnector;
@property(nonatomic,strong)id<LSPedometerPeripheralDelegate> bleProtocolDelegate;
@property(nonatomic,strong)LSPedometerUserInfo *pedometerUserInfo;
@property(nonatomic)ApplicationState currentApplicationState;

/*
 * 连接设备
 */
-(void)connectWithDevice:(LSDeviceInfo *)pairedDevice peripheral:(CBPeripheral *)peripheral protocolProcesses:(NSArray *)uploadingProtocolQueue count:(NSUInteger)connectCount;


/*
 * 中断正在执行的任务
 */
-(void)interruptCurrentTask;

/*
 * 中断正在执行的任务
 */
- (void)addResponse:(NSArray *)datas;

/*
 * 当应用重新从后台返回到前台时，重新使能通道
 */
- (void)reSetNofityCharacteristic;

/*
 * 当应用重新从前台返回到后台时，关闭Fee7的通信通道
 */
- (void)closeNotifyCharacteristic;
@end
