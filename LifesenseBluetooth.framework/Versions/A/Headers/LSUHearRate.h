//
//  LSUHearRate.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSUBaseModel.h"

@interface LSUHearRate : LSUBaseModel
@property (nonatomic, assign) long long utc;
@property (nonatomic, assign) int restCount;
@property (nonatomic, assign) int collectTime;
@property (nonatomic, readonly) NSArray<NSNumber *> *heartRateList;
@property (nonatomic, readonly) NSData *srcData;

@end
