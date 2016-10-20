//
//  LSLog.h
//  LSOTA
//
//  Created by lifesense on 15/12/23.
//  Copyright © 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLog : NSObject

+ (void)log:(NSString *)tag format:(NSString *)format, ...;

+ (void)log:(NSString *)tag isSave:(BOOL)isSave format:(NSString *)format, ...;

+ (NSArray *)logfiles:(NSString *)tag;

+ (void)setIsSave:(BOOL)isSave;

+ (BOOL)IsSave;

@end
