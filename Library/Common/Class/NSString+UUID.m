//
//  NSString+UUID.m
//  coreData数据库
//
//  Created by lifesense on 15/12/16.
//  Copyright © 2015年 彭涛. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)
+(NSString*)UUIDString
{
    CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
    NSString *UUIDString = (__bridge_transfer NSString *) CFUUIDCreateString(kCFAllocatorDefault, UUID);
    CFRelease(UUID);
    // Remove '-' in UUID
    return [[[UUIDString componentsSeparatedByString:@"-"] componentsJoinedByString:@""] lowercaseString];
}


@end
