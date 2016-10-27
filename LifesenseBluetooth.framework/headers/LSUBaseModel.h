//
//  LSUBaseModel.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/13.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSConst.h"
@interface LSUBaseModel : NSObject
@property(nonatomic,assign)LSProtocolVer protocolVer;

- (void)parse:(NSDictionary *)dict;

@end
