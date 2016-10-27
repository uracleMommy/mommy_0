//
//  LSOTAManager.h
//  LSOTA
//
//  Created by lifesense on 15/12/18.
//  Copyright © 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSUInteger, LSOTAManagerCode) {
    LSOTAManagerCodeNotSetCentralManager,
    LSOTAManagerCodeNotAvailable,
    LSOTAManagerCodeNotFound,
    LSOTAManagerCodeHexFileNotFound,
    LSOTAManagerCodeHexFileInvalid,
    LSOTAManagerCodeConnectFailed,
    LSOTAManagerCodeDisconnected,
    LSOTAManagerCodeNotSupport,
    LSOTAManagerCodeEnterDFUModeFailed,
    LSOTAManagerCodeEnteredDFUMode,
    LSOTAManagerCodeUpgrading,
    LSOTAManagerCodeUpgradeFailed,
    LSOTAManagerCodeUpgradeCancel,
    LSOTAManagerCodeSuccess,
};

@class LSOTAManager;

@protocol LSOTAManagerDelegate <NSObject>

/**
 * 设备相关的回调
 */
- (void)lsOTAMgrUpgradeState:(LSOTAManagerCode)code macAddr:(NSString *)macAddr;

/**
 * 上传进度
 */
- (void)lsOTAMgrUploadPercent:(NSInteger)percent macAddr:(NSString *)macAddr;

@end

@interface LSOTAManager : NSObject

/**
 * 超时时间,默认60s
 */
@property (nonatomic, assign) NSUInteger timeout;

/**
 * 是否记录日志
 */
@property (nonatomic, assign) BOOL isSaveLog;

/**
 * 回调委托
 */
@property (nonatomic, weak) id<LSOTAManagerDelegate> delegate;

+ (instancetype)shared;

- (void)setCentralManager:(CBCentralManager *)centralMgr;

/**
 * 根据mac地址升级设备,调用前一定要调用setCentralManager,
 * CBCentralManager的queue不要放到主线程
 */
- (void)upgradeWithMacAddress:(NSString *)macAddr filePath:(NSURL *)filePath isSpecial:(BOOL)isSpecial;

- (NSArray *)getLogFiles;

/*
 * 取消升级
 */
- (void)cancelUpgrade;

- (void)reinit;

@end
