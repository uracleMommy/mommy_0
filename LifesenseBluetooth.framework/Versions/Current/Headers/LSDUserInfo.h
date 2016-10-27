//
//  LSDUserInfo.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"
#import "LSConst.h"

@interface LSDUserInfo : LSDBaseModel
//public double weight;

@property (nonatomic, assign) double weight;


@property (nonatomic, assign) double height;
@property (nonatomic, assign) LSWeekTarget target;
@property (nonatomic, assign) double targetValue;
@property (nonatomic, assign) int startHour;
@property (nonatomic, assign) int startMinute;
@property (nonatomic, assign) int endHour;
@property (nonatomic, assign) int endMinute;

@end
