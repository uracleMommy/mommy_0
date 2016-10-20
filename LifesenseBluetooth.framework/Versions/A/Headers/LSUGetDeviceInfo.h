//
//  LSUGetDeviceInfo.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/20.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSUBaseModel.h"
#import "LSDAlarmClock.h"
#import "LSDCallReminder.h"
#import "LSDWeekTarget.h"
#import "LSDHeartRate.h"
#import "LSDSedentary.h"
#import "LSConst.h"

@interface LSFlashInfo : NSObject

@property (nonatomic, assign) int flashType;
@property (nonatomic, assign) int beginAddr;
@property (nonatomic, assign) int endAddr;
@property (nonatomic, copy) NSString *flashContent;

@end

@interface LSUGetDeviceInfo : LSUBaseModel

@property (nonatomic, strong) LSFlashInfo *flashInfo;
@property (nonatomic, strong) LSDAlarmClock *alarmClock;
@property (nonatomic, strong) LSDWeekTarget *weekTarget;
@property (nonatomic, strong) LSDCallReminder *callReminder;
@property (nonatomic, strong) LSDHeartRate *heartRate;
@property (nonatomic, strong) LSDSedentary *sedentary;
@property (nonatomic, assign) BOOL isOpenPreventLost;

/**
 * 读取信息的类型
 */
@property (nonatomic, assign) LSGetDeviceInfoType type;




@end
