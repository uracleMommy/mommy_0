//
//  MommyUtils.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "MommyUtils.h"

@implementation MommyUtils

static MommyUtils *sharedGlobalData = nil;

+(MommyUtils *) sharedGlobalData {
    
    if (sharedGlobalData == nil) {
        
        sharedGlobalData = [[super allocWithZone:nil] init];
    }
    
    return sharedGlobalData;
}

- (id) init{
    
    if (self = [super init]) {
        // 초기화 작업
    }
    
    return self;
}

#pragma mark 마미앤 날짜 형식 변환기(yyyy.MM.dd a hh:mm)
- (NSString *) getMommyDate : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"yyyy.MM.dd a hh:mm"];
    NSString *yyyymmdd = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmdd;
}

#pragma mark 마미앤 날짜 형식 변환기(yyyy.MM.dd)
- (NSString *) getMommyDateyyyyMMdd : (NSString *) dateFormatString {
    
    NSString *dateString = dateFormatString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *yyyymmdd = [dateFormatter stringFromDate:dateFromString];
    
    return yyyymmdd;
}

@end
