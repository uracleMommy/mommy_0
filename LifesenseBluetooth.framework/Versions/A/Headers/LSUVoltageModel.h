//
//  LSUVoltageModel.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/5/25.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUVoltageModel : NSObject
/**
 *  MAC地址
 */
@property (nonatomic,copy) NSString *macAddress;

/**
 *  是否在充電
 */
@property (nonatomic,assign) NSUInteger chargingSign;
/**
 *  電壓，單位：V（伏）
 */
@property (nonatomic,assign) float voltage;
@end
