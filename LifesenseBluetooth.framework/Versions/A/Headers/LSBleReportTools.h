//
//  LSBleReportTools.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/3/29.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"

@interface LSBleReportTools : NSObject

+(NSString *)parseActionEventType:(BleActionEventType)eventType;


+(NSString *)currentHourSystemTime;


+(NSString *)currentDefaultSystemTime;

+(NSString *)currentPhoneMessage;
@end
