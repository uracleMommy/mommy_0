//
//  LSDSportHeartRate.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"

@interface LSDSportHeartRate : LSDBaseModel

/**
 * 运动区间心率上限
 */
@property (nonatomic, assign) int maxHeartRateZone;
/**
 * 运动区间心率下限
 */
@property (nonatomic, assign) int minHeartRateZone;
@end
