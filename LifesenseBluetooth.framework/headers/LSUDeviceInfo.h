//
//  LSUDeviceInfo.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSUBaseModel.h"

@interface LSUDeviceInfo : LSUBaseModel
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *softVer;
@property (nonatomic, copy) NSString *hardVer;
@property (nonatomic, assign) BOOL isOpenHR;
@property (nonatomic, assign)  int startHour;
@property (nonatomic, assign)  int startMinute;
@property (nonatomic, assign)  int endHour;
@property (nonatomic, assign)  int endMinute;
@property (nonatomic, copy)  NSString *timeZone;

@end
