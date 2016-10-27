//
//  LSDHeartSection.h
//  LSBluetooth-Library
//
//  Created by lifesense－mac on 16/5/25.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"

/**
 *  心率区间
 */
@interface LSHeartSection : NSObject
/**
 *  下限
 */
@property (nonatomic, assign) NSUInteger min;

/**
 *  上限
 */
@property (nonatomic, assign) NSUInteger max;

@end

/**
 *  APP push 心率区间到手环
 */
@interface LSDHeartSection : LSDBaseModel

/**
 *  年龄
 */
@property (nonatomic, assign) NSUInteger age;

- (BOOL)addHeartSection:(LSHeartSection *)heartSection;

@end
