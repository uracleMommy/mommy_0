//
//  LSBleActionEvent.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/3/29.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"


@interface LSBleActionEvent : NSObject

@property(nonatomic) BleActionEventType eventType;          //事件类型
@property(nonatomic,strong) NSString *startTime;			//事件开始时间
@property(nonatomic,strong) NSString *status;				//事件状态，成功或失败
@property(nonatomic,strong) NSString *remark;				//事件备注
@property(nonatomic,strong) NSString *sourceData;			//事件原始数据
@property(nonatomic,strong) NSString *dataType;             //数据类型

@end
