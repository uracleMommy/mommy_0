//
//  LSBleReportWorker.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/3/29.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"
#import "LSBleReportCentreDelegate.h"
#import "LSProtocolWorkflow.h"
#import "LSDeviceInfo.h"

@interface LSBleReportWorker : NSObject

//设置处理回调对象
@property(nonatomic,strong)id<LSBleReportCentreDelegate> reportCentreDelegate;
@property(nonatomic,strong)NSString *defaultFilePath;
@property(nonatomic,strong)NSString *userAccountName;
@property(nonatomic,strong)NSString *appVersion;
@property(nonatomic,strong)LSDeviceInfo *currentDevice;


/**
 * 添加统计分析类型
 * @param statisticType
 */
-(void) addStatistic:(BleStatisticType) statisticType;


/**
 * 添加异常断开状态统计分析
 * @param workflow
 */
-(void) addStatisticForAbnormalDisconnect:(ProtocolWorkflow) workflow;


/**
 * 添加连接失败状态统计信息
 * @param status
 * @param newStatus
 */
-(void) addStatisticForConnectionFailed:(int) status;

/**
 * 添加正常数据接收统计信息
 * @param type
 * @param packetCode
 * @param sourceData
 */
-(void)  addStatisticForDataNormal:(BleStatisticType)type packetCode:(NSString *)packetCode sourceData:(NSString*)sourceData;

/**
 * 添加异常数据接收统计，或数据接收失败统计
 * @param packetCode
 * @param sourceData
 */
-(void) addStatisticForDataAbnormal:(NSString*)packetCode sourceData:(NSString *) sourceData;

/**
 * 开始记录报告日志
 */
-(void) startWorking;

/**
 * 停止记录报告日志
 */
-(void) stopWorking;
/**
 * 添加错误记录信息
 * @param errorCode
 */
-(void) addErrorRecord:(BleErrorType)errorCode;

/**
 * 添加蓝牙sdk事件处理信息
 * @param eventType
 * @param isSuccess
 * @param sourceData
 * @param dataType
 */
-(void)  addActionEventRecord:(BleActionEventType)eventType isSuccess:(BOOL)isSuccess sourceData:(NSString*)sourceData dataType:(NSString *)dataType;

/**
 * 上传指定文件类型的蓝牙日志报告
 * @param fileType
 */
-(void)uploadBleLogFile:(BleLogFileType)fileType;


/**
 * 根据文件类型，设置自动上传处理机制
 * @param fileType
 */
-(void)setAutomaticUpload:(BleLogFileType)fileType;



/*
 * 输出log日志文件内容
 */
-(void)exportFileMessage;


@end
