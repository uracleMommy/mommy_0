//
//  LSProtocolBridge.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/12.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSConst.h"
#import "LSDBaseModel.h"
#import "LSUBaseModel.h"

@class LSProtocolBridge;

void ls_bridge_handler(NSObject *bridge, const char *szTag, unsigned int packageIndex, unsigned int packageLength, char *packagedata,
                       unsigned int cmdId, unsigned int srcDataLength, char *srcData, bool isSuccess, int protocolVer);

@protocol LSProtocolBridgeDelegate <NSObject>

- (void)handlePackage:(LSProtocolBridge *)bridge tag:(NSString *)tag packageIndex:(int)packageIndex cmd:(int)cmd packageData:(NSData *)packageData srcData:(NSData *)srcData protcolVer:(LSProtocolVer)protocolVer isSuccess:(BOOL)isSuccess;

@end


@interface LSProtocolBridge : NSObject

@property (nonatomic, weak) id<LSProtocolBridgeDelegate> delegate;
@property (nonatomic, weak) NSString *broadcastId;

/**
 * 协议拼包
 *
 * @param data        原始数据
 * @param tag         tag
 * @param protocolVer 协议版本
 * @return
 */
- (BOOL)appendData:(NSData *)data tag:(NSString *)tag protocolVer:(LSProtocolVer)protocolVer;

- (void)log:(NSString *)format,...;

/**
 * 创建登录回包
 *
 * @param isLoginSucess 是否登录成功
 * @param protocolVer   协议
 * @return
 */
+ (NSArray<NSData *> *)createLoginResp:(BOOL)isLoginSucess packageIndex:(int)packageIndex protocolVer:(LSProtocolVer)protocolVer;

/**
 * 绑定产品成功的登录回包
 *
 * @param protocolVer 协议
 * @return
 */
+ (NSArray<NSData *> *)createBindResp:(LSProtocolVer)protocolVer;

/**
 * 通用回复数据
 *
 * @param cmd         命令号
 * @param isSuccess   是否成功
 * @param protocolVer 协议版本
 * @return 有可能为null
 */
+ (NSArray<NSData *> *)createResultResp:(int)cmd isSuccess:(BOOL)isSuccess packageIndex:(int)packageIndex protocolVer:(LSProtocolVer)protocolVer;

/**
 * 把对象转换成byte[]列表
 *
 * @param model       对象
 * @param protocolVer 协议版本
 * @return 如果有错，将返回null
 */
+ (NSArray<NSData *> *)encode:(LSDBaseModel *)model protocolVer:(LSProtocolVer)protocolVer;


/**
 * 把数据转换成model对象
 *
 * @param data        蓝牙上传上来的数据
 * @param protocolVer 协议版本
 * @return 如果转换失败返回null
 */
+ (NSArray<LSUBaseModel *> *)decode:(NSData *)data protocolVer:(LSProtocolVer)protocolVer decodeJson:(NSString **)decodeJson;

@end