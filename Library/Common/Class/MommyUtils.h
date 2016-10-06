//
//  MommyUtils.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 5..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MommyUtils : NSObject

+ (MommyUtils *) sharedGlobalData;

- (NSString *) getMommyDate : (NSString *) dateFormatString;

- (NSString *) getMommyDateyyyyMMdd : (NSString *) dateFormatString;

@end
