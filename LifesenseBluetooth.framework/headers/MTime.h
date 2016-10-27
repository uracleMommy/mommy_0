//
//  MTime.h
//  libCom
//
//  Created by Damein on 14/05/20.
//  Copyright (c) 2014年 Damein. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _MTime_t {
    int nSecond;		/* 秒 – 取值区间为[0,59] */
    int nMinute;		/* 分 - 取值区间为[0,59] */
    int nHour;          /* 时 - 取值区间为[0,23] */
    int nMDay;          /* 一个月中的日期 - 取值区间为[1,31] */
    int nMonth;         /* 月份（从一月开始，0代表一月） - 取值区间为[0,11] */
    int nYear;          /* 年份，其值从1900开始 */
    int	nWDay;          /* 星期–取值区间为[0,6]，其中0代表星期天，1代表星期一 */
    int nYDay;          /* 从每年的1月1日开始的天数–取值区间为[0,365]，其中0代表1月1日，1代表1月2日 */
    int nDst;			/* 夏令时标识符，实行夏令时的时候，m_nDst为正。不实行夏令时的进候，m_nDst为0；不了解情况时，m_nDst为负。*/
    long nGmtOffset;		/* 指定了日期变更线东面时区中UTC东部时区正秒数或UTC西部时区的负秒数 */
    char szZone[128];	/* 当前时区的名字 */
}MTime_t;


/**
 *  日期时间相关类
 */
@interface MTime : NSObject

/**
 * 秒
 */
@property (assign,nonatomic,readonly) int second;

/**
 *  分
 */
@property (assign,nonatomic,readonly) int minute;

/**
 *  时
 */
@property (assign,nonatomic,readonly) int hour;

/**
 *  一个月中的日期 - 取值区间为[1,31]
 */
@property (assign,nonatomic,readonly) int mDay;

/**
 * 月份
 */
@property (assign,nonatomic,readonly) int month;

/**
 * 年份
 */
@property (assign,nonatomic,readonly) int year;

/**
 * 星期,取值区间为[1,7]，其中7代表星期天，1代表星期一
 */
@property (assign,nonatomic,readonly) int wDay;

/**
 * 从每年的1月1日开始的天数–取值区间为[1,366]，其中1代表1月1日，2代表1月2日
 */
@property (assign,nonatomic,readonly) int yDay;

/**
 * 夏令时标识符，实行夏令时的时候，dst为正。不实行夏令时的进候，dst为0；不了解情况时，dst为负。
 */
@property (assign,nonatomic,readonly) int dst;

/**
 * 指定了日期变更线东面时区中UTC东部时区正秒数或UTC西部时区的负秒数
 */
@property (assign,nonatomic,readonly) long gmtoff;

/**
 *  当前时区的名字
 */
@property (strong,nonatomic,readonly) NSString *zone;

/**
 *  原始数值
 */
@property (assign,nonatomic,readonly) long long value;

/**
 *  原始时间结构
 */
@property (assign,nonatomic,readonly) MTime_t tm;

/**
 *  当前对象的时间戳
 */
@property (assign,nonatomic,readonly) long long timestamp;

/**
 *  从时间戳创建
 *
 *  @param timestamp 时间戳
 *
 *  @return MTime实例
 */
+ (MTime *)timeWithTimestamp:(long long)timestamp;

/**
 *  从符合NSDateFormatter的日期字符串创建
 *
 *  @param dateStr 日期字符串
 *  @param format  格式化日期格式,如:yyyy-MM-dd HH:mm:ss
 *
 *  @return MTime实例
 */
+ (MTime *)timeWithDateString:(NSString *)dateStr format:(NSString *)format;

/**
 *  从一个日期对象创建
 *
 *  @param date 日期对象
 *
 *  @return MTime实例
 */
+ (MTime *)timeWithDate:(NSDate *)date;

/**
 *  获取当前时间戳
 *
 *  @return 当前时间戳
 */
+ (long long)getCurTimestamp;

/**
 *  把日期字符串转换成起对象
 *
 *  @param dateStr 日期字符串,如:2015-02-01 10:12:40
 *  @param format  格式化日期格式,如:yyyy-MM-dd HH:mm:ss
 *
 *  @return 时间戳
 */
+ (NSDate *)getDateByDateString:(NSString *)dateStr format:(NSString *)format;

/**
 *  把日期转换成日期字符串
 *
 *  @param date   日起对象
 *  @param format 转换格式,如:yyyy-MM-dd HH:mm:ss
 *
 *  @return 日期字符串
 */
+ (NSString *)getDateStringFromDate:(NSDate *)date format:(NSString *)format;

/**
 *  把日期对象转换成时间戳
 *
 *  @param date 日期对象
 *
 *  @return 时间戳
 */
+ (long long)getTimestampByDate:(NSDate *)date;

/**
 *  把时间戳转换成日期对象
 *
 *  @param timestamp 时间戳
 *
 *  @return 日期对象
 */
+ (NSDate *)getDateByTimestamp:(long long)timestamp;

- (instancetype)initWithTimestamp:(long long)timestamp;

- (instancetype)initWithDateString:(NSString *)dateStr format:(NSString *)format;

- (instancetype)initWithDate:(NSDate *)date;

@end