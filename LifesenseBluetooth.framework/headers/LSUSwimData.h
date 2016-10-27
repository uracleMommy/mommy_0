//
//  LSUSwimData.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSUBaseModel.h"

@interface LSUSwimData : LSUBaseModel
@property (nonatomic, assign) long long startUTC;
@property (nonatomic, assign) long long endUTC;
@property (nonatomic, assign) int laps;

@end
