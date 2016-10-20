//
//  LSBLEConnector.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBCharacteristic.h>
#import <CoreBluetooth/CBPeripheral.h>
#import "LSBLEConnectorDelegate.h"
#import "LSFormatConverter.h"
#import "LSBleStatusChangeDelegate.h"
#import "CBUUID+Ext.h"

@interface LSBleConnector : NSObject

@property(nonatomic,strong)id<LSBleConnectorDelegate> bleConnectorDelegate;
@property(nonatomic,readonly)BOOL isScanning;
@property(nonatomic,strong)dispatch_queue_t dispatchQueue;

- (CBCentralManager *)getCentralMgr;
- (void)reinit;

-(void)checkBluetoothStatus:(id<LSBleStatusChangeDelegate>)bleStateDelegate;

-(BOOL)scanWithServices:(NSArray *)services;

-(void)stopScan;

-(void)connectPeripheral:(CBPeripheral *)lsPeripheral targetDevice:(NSString *)macAddress;

-(void)disConnectPeripheral:(CBPeripheral *)peripheral notifyCharacter:(NSMutableArray *)notifyCharacters targetDevice:(NSString *)macAddress;

//new change for version 1.1.0
-(void)setCustomDispathQueue:(dispatch_queue_t)dispathQueue;

//new change for version 2.0.4,根据传入的service uuid 检索该目标设备是否已建立了蓝牙连接
-(NSArray *)checkConnectedPeripheralsWithServices:(NSArray *)targetServices;


-(void)addDelegateObject:(id<LSBleConnectorDelegate>)objDelegate peripheral:(CBPeripheral *)peripheral;
@end
