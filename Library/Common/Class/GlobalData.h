//
//  GlobalData.h
//  co.medisolution
//
//  Created by OGGU on 2016. 10. 4..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

+ (GlobalData *) sharedGlobalData;

@property (retain, nonatomic) NSString *authToken;

@end
