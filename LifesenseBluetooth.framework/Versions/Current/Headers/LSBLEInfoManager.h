//
//  LSBLEInfoManager.h
//  LSBluetooth-Library
//
//  Created by lifesense on 15/12/28.
//  Copyright © 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol LSBLEInfoManagerDelegate <NSObject>

- (void)infoManagerWithMacAddr:(NSString *)macAddr peripheral:(CBPeripheral *)peripheral services:(NSArray *)gattServices;

- (void)infoManagerFinished;

@end

/**
 *  用于处理系统已连接设备
 */
@interface LSBLEInfoManager : NSObject

@property (nonatomic, weak) id<LSBLEInfoManagerDelegate> delegate;

+ (instancetype)shared;

- (BOOL)getAllDeviceMacAddress:(NSArray *)targetServices devices:(NSDictionary *)connectedDeviceMap;

- (void)setCentralMgr:(CBCentralManager *)central;

@end
