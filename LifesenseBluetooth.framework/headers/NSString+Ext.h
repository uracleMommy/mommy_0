//
//  NSString+Ext.h
//  gqspace
//
//  Created by Chanbo on 15/8/18.
//  Copyright (c) 2015年 Chanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Ext)

/**
 *  json字符串转对象
 *
 *  @return NSArray或NSDictionary
 */
- (id)jsonToObject;


/**
 *  转换成NSData
 *
 *  @return 转换后的data
 */
- (NSData *)toData;

@end
