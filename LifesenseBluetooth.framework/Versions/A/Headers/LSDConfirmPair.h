//
//  LSDConfirmPair.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"
#import "LSConst.h"

@interface LSDConfirmPair : LSDBaseModel

@property (nonatomic, assign) double weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) LSWeekTarget target;
@property (nonatomic, assign) double targetValue;

@end
