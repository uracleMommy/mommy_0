//
//  StreamBuffer.h
//  libCom
//
//  Created by Damein on 15/8/20.
//  Copyright (c) 2015年 Damein. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  流定位
 */
typedef NS_ENUM(NSUInteger, StreamSeek) {
    /**
     *  数据流开头
     */
    StreamSeekBegin = 0,
    /**
     *  当前位置
     */
    StreamSeekCur,
    /**
     *  数据流结尾
     */
    StreamSeekEnd,
};

/*
 * 数据流操作，基于C++版本修改而来
 */
@interface StreamBuffer : NSObject

@property (nonatomic,assign) BOOL little;

+ (instancetype)streamWithSize:(NSUInteger)size;

+ (instancetype)streamWithBuffer:(char *)buffer size:(NSUInteger)size;

- (instancetype)initWithBuffer:(char *)buffer size:(NSUInteger)size;

#pragma mark 读
- (char)readByte;
- (short)readShort;
- (int)readInt;
//- (int64_t)readInt64;
- (NSString*)readString;
- (int)readString:(char *)buffer;
- (int)read:(char *)buffer len:(int)len;

#pragma mark 写
- (int)writeByte:(char)c;
- (int)writeShort:(short)s;
- (int)writeInt:(int)n;
//- (int64_t)writeInt64:(int64_t)n;
- (int)writeString:(NSString *)str;
- (int)write:(const char*)buffer len:(int)len;
- (unsigned long)seek:(StreamSeek)seek offset:(int)offset;

#pragma mark 其它
- (void)rewind;
- (void)recordSize;
- (unsigned long)getPosition;
- (char *)getBuffer:(BOOL)bCopy;
- (NSData *)getBufferWithOffset:(int)offset size:(int)size;
- (unsigned long)getCapacity;
- (unsigned int)getSize;
- (void)clear;
- (void)close;
- (BOOL)resize:(unsigned int)addSize;


@end
