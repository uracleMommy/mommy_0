//
//  LSDAlarmClock.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"
#import "LSConst.h"


@interface LSAlarmClock : NSObject

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, readonly) NSArray *weeks;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) LSShockType shockType;
@property (nonatomic, assign) int shockTime;
@property (nonatomic, assign) int shockLevel1;
@property (nonatomic, assign) int shockLevel2;

/**
 *  添加提醒的日期,如果没有设置，将会提醒一次，最后一个一定得是LSWeekNone
 *
 *  @param week1 LSWeek 星期几
 */
- (void)addWeek:(LSWeek)week1,...;

/**
 *  删除提醒日期，最后一个一定得是LSWeekNone
 *
 *  @param week1 LSWeek 星期几
 */
- (void)removeWeek:(LSWeek)week1,...;

@end


@interface LSDAlarmClock : LSDBaseModel
@property (nonatomic, assign) BOOL isOpenAlert;

@property (nonatomic, readonly) NSArray<LSAlarmClock*> *alarms;

- (void)addClock:(LSAlarmClock *)clock;

@end
