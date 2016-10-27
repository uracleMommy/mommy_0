//
//  PushMessageDelegate.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/1/14.
//  Copyright © 2016年 Lifesense. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"
#import "LSFlashData.h"

@protocol PushManagerDelegate <NSObject>

@optional

//推送push message 更新通知
-(void)pushManagerDidUpdate:(id)obj type:(PushMessage)messageType;

//根据设备配置信息类型，发出查询设备配置信息的请求
-(void)pushMessageDidQueryOtherRequest:(PushMessage)messageType;

//查询设备Flash info
-(void)pushMessageDidQueryFlashInfoRequest:(LSFlashData *)flashData;

@end
