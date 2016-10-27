//
//  LSFlashData.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/1/14.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    
    FlashDataBluetoothChip=0X00,   //读取蓝牙芯片flash信息
    FlashDataExternalFlashChip=0X01,//读取外挂flash芯片信息
    FlasDataExternalMcuFlashChip=0X02,//读取外挂MCU中flash信息
    
    
}FlashDataType;

@interface LSFlashData : NSObject

@property(nonatomic,strong)NSString *startAddress;
@property(nonatomic,strong)NSString *endAddress;
@property(nonatomic)FlashDataType flashDataType;
@property(nonatomic,strong)NSData *flashData;

@end
