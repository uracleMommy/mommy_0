//
//  NSData+Ext.h
//  LSBluetooth-Library
//
//  Created by lifesense on 15/11/25.
//  Copyright © 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

unsigned int ls_crc32(char *data, int length);

@interface NSData (Ext)
/**
 *  CRC32位校验
 *
 *  @return CRC32位校验值
 */
- (unsigned int)crc32;

@end
