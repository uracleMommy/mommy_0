//
//  PlusOTAMananger.h
//  LSBluetooth-Demo
//
//  Created by pengtao on 16/2/20.
//  Copyright © 2016年 Lifesense. All rights reserved.
#import <Foundation/Foundation.h>
#import "PlusOTAMangerDlegate.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "LSBleConnector.h"
#import "LSDeviceInfo.h"

@interface PlusOTAMananger : NSObject
@property (nonatomic,strong)id<PlusOTAMangerDlegate>plushdelegate;
@property (nonatomic,strong)LSDeviceInfo *currentDevice;
@property (nonatomic,assign)BOOL upgrade;
+ (instancetype)defaultLsBleManager;

-(void)GetPeripheral:(CBPeripheral *)periphera Bluthelegate:(id)delegate andfileUrl:(NSURL *)fileurl andbleconectdelegate:(LSBleConnector *)bleconect notifyCharacters:(NSArray *)notifys;
-(void)getUrl:(NSString *)urlStr;
-(void)cancel;

@end
