//
//  LSDPushGetInfo.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"
#import "LSConst.h"

@interface LSDPushGetInfo : LSDBaseModel

@property (nonatomic, assign)  LSGetDeviceInfoType type;
@property (nonatomic, assign)  int flashType;
@property (nonatomic, assign)  int beginAddr;
@property (nonatomic, assign)  int endAddr;

@end
