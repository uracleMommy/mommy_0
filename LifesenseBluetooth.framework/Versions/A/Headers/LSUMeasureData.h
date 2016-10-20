//
//  LSUMeasureData.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSUBaseModel.h"

@interface LSUMeasureData : LSUBaseModel

@property (nonatomic, assign)  int step;
@property (nonatomic, assign)  long long utc;
@property (nonatomic, assign)  double examount;
@property (nonatomic, assign)  double calories;
@property (nonatomic, assign)  int exerciseTime;
@property (nonatomic, assign)  int distance;
@property (nonatomic, assign)  int batteryLevel;
//    @property (nonatomic, assign)  int sleepStatus;
@property (nonatomic, assign)  int sportLevel;
@property (nonatomic, assign)  double batteryVoltage;


@end
