//
//  LSBleReportCentreDelegate.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/3/28.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"
#import "LSBleStatistic.h"
#import "LSErrorRecord.h"

@protocol LSBleReportCentreDelegate <NSObject>

@optional

-(void)onStatisticReport:(NSString* )macAddress statistic:(LSBleStatistic *)bleStatistic statisticType:(BleStatisticType)type;

-(void)onErrorRecordReports:(NSString* )macAddress errorRecords:(NSArray *)errorRecords;

-(void)onErrorRecordReport:(NSString *)macAddress errorRecord:(LSErrorRecord *) errorRecord;
@end
