//
//  LSConst.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/13.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef NS_ENUM(NSUInteger, LSProtocolVer) {
//    LSProtocolVerA4 = 4, // 暂不支持
//    LSProtocolVerA5_80, // 0x80xx
//    LSProtocolVerA5_AA, // 0xAAxx
//};

typedef NS_ENUM(NSUInteger, LSPlatform) {
    LSPlatformUnknown,
    LSPlatformIOS,
    LSPlatformAndroid,
    LSPlatformWP
};

/**
 * 协议版本
 */
typedef NS_ENUM(NSUInteger, LSProtocolVer) {
    LSProtocolVerA2 = 1,
    LSProtocolVerA3,
    LSProtocolVerA3_1,
    LSProtocolVerA4,
    LSProtocolVerA5_80,
    LSProtocolVerA5_AA,
};

/**
 * 获取设备信息类型
 */
typedef NS_ENUM(NSUInteger, LSGetDeviceInfoType) {
    /**
     * 读取flash信息
     */
    LSGetDeviceInfoTypeReadFlashInfo,
    /**
     * 用户信息
     */
    LSGetDeviceInfoTypeReadUserInfo,
    /**
     * 闹钟设置信息
     */
    LSGetDeviceInfoTypeReadAlarmClockInfo,
    /**
     * 来电提醒设置信息
     */
    LSGetDeviceInfoTypeReadCallReminderInfo,
    /**
     * 心率检测设置信息
     */
    LSGetDeviceInfoTypeReadCheckHRInfo,
    /**
     * 久不动提醒设置信息
     */
    LSGetDeviceInfoTypeReadSedentaryInfo,
    /**
     * 防丢设置信息
     */
    LSGetDeviceInfoTypeReadProtectLostInfo
};

/**
 * 步频信息
 */
typedef NS_ENUM(NSUInteger, LSStepFreqStatus) {
    /**
     * 跑步开始
     */
    LSStepFreqStatusRunStart,
    /**
     * 跑步结束
     */
    LSStepFreqStatusRunOver,
    /**
     * 跑步暂停
     */
    LSStepFreqStatusRunPause,
    /**
     * 跑步重新开始
     */
    LSStepFreqStatusRunReStart
};

/**
 * 每周目标
 */
typedef NS_ENUM(NSUInteger, LSWeekTarget) {
    /**
     * 步数
     */
    LSWeekTargetStep,
    /**
     * 卡路里
     */
    LSWeekTargetCalories,
    /**
     * 距离
     */
    LSWeekTargetDistance,
    /**
     * 运动量
     */
    LSWeekTargetExerciseAmount
};


/**
 * 震动方式
 */
typedef NS_ENUM(NSUInteger, LSShockType) {
    /**
     * 持续震动
     */
    LSShockTypeAlway,
    /**
     * 间歇震动，震动强度不变
     */
    LSShockTypeInterval,
    /**
     * 间歇震动，震动强度由小变大
     */
    LSShockTypeIntervalS2L,
    /**
     * 间歇震动，震动强度由大变小
     */
    LSShockTypeIntervalL2S,
    /**
     * 间歇震动，震动强度大小循环
     */
    LSShockTypeIntervalLoop,
};

typedef NS_ENUM(NSUInteger, LSWeek) {
    LSWeekNone,
    LSWeekMonday = 1,
    LSWeekTuesday,
    LSWeekWednesday,
    LSWeekThursday,
    LSWeekFriday,
    LSWeekSaturday,
    LSWeekSunday,
};

/**
 * Push来电提醒设置类型
 */
typedef NS_ENUM(NSUInteger, LSCallReminderAlertType) {
    /**
     * 来电提醒
     */
    LSCallReminderAlertTypeDefault,
    /**
     * 消息提醒
     */
    LSCallReminderAlertTypeMsg,
    /**
     * 断连提醒
     */
    LSCallReminderAlertTypeLost,
};


