//
//  LSBleDataParsingTools.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-4.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleManagerProfiles.h"

@interface LSBleDataParsingTools : NSObject

+(LSWeightData*)parseWeightAppendDataWithNormalWeight:(LSWeightData *) normalWeightDdata sourceData:(NSData*)data;

+(LSWeightAppendData*)parseWeightAppendData:(NSData*)data;

+(LSWeightData*)parseWeightScaleMeasurementData:(NSData*)data;

+(LSSphygmometerData*)parseSphygmometerMeasurementData:(NSData*)data;

+(LSPedometerData*)parsePedometerScaleMeasurementData:(NSData*)data;

+(LSKitchenScaleData*)parseKitchenMeasurementData:(NSData*)data;

+(LSHeightData*)parseHeightMeasurementData:(NSData*)data;

+(double)translateToSFloat:(uint16_t)data;

//new change for protofol a4 pedometer

+(NSArray *)parsePedometerHourlyDatasForC9:(NSString *)string withTimezone:(int) zone deviceInfo:(LSDeviceInfo *)deviceInfo;

+(NSArray *)parsePedometerEveryDayDatasForCA:(NSString *)string  withTimezone:(int)zone deviceInfo:(LSDeviceInfo *)deviceInfo;

+(void)parsePedometerCommandRequestForC7:(NSString *)dataStr;

+(NSInteger)parseDeviceTimeZoneFromCommandRequestC7:(NSString *)c7String;

+(NSArray *)parsePedometerSleepInfoForCE:(NSString *)sourceData  withTimezone:(int)zone deviceInfo:(LSDeviceInfo *)deviceInfo;
@end
