//
//  PushMessageManager.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/1/14.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushManagerDelegate.h"
#import "PushMessageProfiles.h"


@interface PushMessageManager : NSObject

//获取实例对象
+(instancetype)defaultPushManager;

//设置代理
-(void)setDelegate:(id<PushManagerDelegate>)pushDelegate macAddress:(NSString *)macAddress;


//-(void)queryFlashInfo:
@end
