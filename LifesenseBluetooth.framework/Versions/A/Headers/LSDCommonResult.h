//
//  LSDCommonResult.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"

@interface LSDCommonResult : LSDBaseModel

@property (nonatomic, assign)   int cmd;
@property (nonatomic, assign)   int packageIndex;
@property (nonatomic, assign)   BOOL isSuccess;

@end
