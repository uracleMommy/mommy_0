//
//  GlobalData.m
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

static GlobalData *sharedGlobalData = nil;

+(GlobalData *) sharedGlobalData {
    
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

@end
