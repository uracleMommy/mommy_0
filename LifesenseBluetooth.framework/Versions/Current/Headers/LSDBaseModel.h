//
//  LSDBaseModel.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/13.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSDBaseModel : NSObject

@property (nonatomic, assign) int COMMAND;
@property (nonatomic, assign) int packageIndex;

- (NSString *)toJson;

@end
