//
//  LSDDeviceInfo.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"

@interface LSDDeviceInfo : LSDBaseModel

@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSString *deviceId;

@end
