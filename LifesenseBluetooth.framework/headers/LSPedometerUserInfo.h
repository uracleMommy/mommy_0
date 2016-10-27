//
//  LSPedometerUserInfo.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

typedef enum
{
    EXERCISE_TARGET_STEP = 0x01,
    EXERCISE_TARGET_CALORIES,
    EXERCISE_TARGET_DISTANCE,
    EXERCISE_TARGET_EXCRICISEAMOUNT ,
}EXERCISE_TARGET_TYPE;

//A2手环显示时间的小时制
typedef enum {
    HOUR_12=1,
    HOUR_24=2,
}HOUR_SYSTEM;

//A2手环运动距离长度的计算单位
typedef enum {
    LENGTH_UNIT_KILOMETER=1,
    LENGTH_UNIT_MILE=2,
}LENGTH_UNIT;



#import <Foundation/Foundation.h>
#import "LSProductUserInfo.h"

@interface LSPedometerUserInfo : NSObject

@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic,strong)NSString *memberId; //用户ID；

@property(nonatomic)NSInteger userNo; //productUserNumber
@property(nonatomic)double weight;
@property(nonatomic)double height;
@property(nonatomic)double stride;
@property(nonatomic)EXERCISE_TARGET_TYPE targetType;
@property(nonatomic)NSInteger targetStep;
@property(nonatomic)double targetCalories;
@property(nonatomic)double targetDistance;
@property(nonatomic)double targetExerciseAmount;
@property(nonatomic,strong)NSString *weightUnit;
@property(nonatomic)HOUR_SYSTEM hourSystem;
@property(nonatomic)LENGTH_UNIT lengthUnit;
@property(nonatomic, assign) NSInteger encourageStep;
@property(nonatomic, assign) BOOL isOpenEncourage;

/*
 * Version1.1.0 new change, add age userGender athleteActivityLevel isAthlete
 */
@property(nonatomic,assign)NSInteger age;
@property(nonatomic)UserSexType userGender;
@property(nonatomic,assign)NSInteger athleteActivityLevel;
@property(nonatomic)BOOL isAthlete;
@property(nonatomic,assign)NSInteger weekStart;//1 for Sunday,2 for Monday

#pragma mark 3.5.0以后的A5协议才有
/**
 *  心率检测开关
 */
@property (nonatomic, assign) BOOL isOpenHeartRate;

/**
 *  心率检测关起始时间(时)
 */
@property (nonatomic, assign) unsigned char startHour;

/**
 *  心率检测关起始时间(分)
 */
@property (nonatomic, assign) unsigned char startMinute;

/**
 *  心率检测关结束时间(时)
 */
@property (nonatomic, assign) unsigned char endHour;

/**
 *  心率检测关结束时间(分)
 */
@property (nonatomic, assign) unsigned char endMinute;


-(NSData *)currentStateCommandData;

//new change for version1.1.0

-(NSData*)userMessageCommandData;

-(NSData*)weekTargetCommandData;

-(BOOL)isUserMessageSetting;

-(BOOL)isWeekStartSetting;

-(BOOL)isCurrentStateSetting;

-(NSData*)unitConversionCommandData;

-(BOOL)isUnitConversionSetting;

@end
