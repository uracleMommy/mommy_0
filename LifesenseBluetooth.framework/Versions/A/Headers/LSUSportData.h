//
//  LSUSportData.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSUBaseModel.h"
#import "LSConst.h"

@interface LSStepFreqInfo : NSObject
@property (nonatomic, assign) long long utc;
@property (nonatomic, assign) LSStepFreqStatus status;

@end

@interface LSUSportData : LSUBaseModel
@property (nonatomic, assign)  int time;
@property (nonatomic, assign)  int step;
@property (nonatomic, assign)  double calories;
@property (nonatomic, assign)  int maxHR;
@property (nonatomic, assign)  int avgHR;
@property (nonatomic, assign)  int maxStepFreq;
@property (nonatomic, assign)  int avgStepFreq;
@property (nonatomic, readonly)  NSArray<LSStepFreqInfo *> *stepFreqList;

@end
