//
//  LSBleReportCentre.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/3/28.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"
#import "LSProtocolWorkflow.h"
#import "LSBleReportCentreDelegate.h"

@interface LSBleReportCentre : NSObject

//获取实例对象
+(instancetype)defaultReportCentre;
/**
 * 初始化蓝牙报告处理中心对象实例
 * @param appContext
 * @param sdkPermission
 * @param reportCentreistener
 */
-(void) initReportCentre:(BOOL)sdkPermission centreDelegate:(id<LSBleReportCentreDelegate>)reportCentreDelegate;
/**
 * 设置蓝牙sdk的权限
 * @param sdkPermission
 */
-(void)setBluetoothSdkPermission:(BOOL)permission;

/**
 * 初始化蓝牙报告工作者，一个设备对应一个报告
 * @param devicesMap
 */
-(void) initBleReportWorker:(NSDictionary *)devicesMap;


/**
 * 启动所有蓝牙报告工作者，开始记录日志信息
 */
-(void) startAllBleReportWorkers;

/**
 * 停止所有蓝牙报告工作者，形成日志文件
 */
-(void) stopAllBleReportWorkers;

/**
 * 添加统计信息类型
 * @param statisticType
 * @param macAddress
 */
-(void) addStatistic:(BleStatisticType)statisticType mac:(NSString *) macAddress;

/**
 * 添加异常断开统计信息
 * @param macAddress
 * @param workflow
 */
-(void) addStatisticForAbnormalDisconnect:(NSString * )macAddress flow:(ProtocolWorkflow)workflow;

/**
 * 添加连接失败统计信息
 * @param macAddress
 * @param status
 * @param newStatus
 */
-(void) addStatisticForConnectionFailed:(NSString *) macAddress status:(int)connectStatus;

/**
 * 添加正常数据接收统计信息
 * @param macAddress
 * @param type
 * @param packetCode
 * @param sourceData
 */
-(void) addStatisticForDataNormal:(NSString *)macAddress statisticType:(BleStatisticType)type packetCode:(NSString *)packetCode sourceData:(NSString *)data;
/**
 * 添加异常数据接收统计，或数据接收失败统计
 * @param macAddress
 * @param packetCode
 * @param sourceData
 */
-(void) addStatisticForDataAbnormal:(NSString *)macAddress packetCode:(NSString *)packetCode sourceData:(NSString *)sourceData;


/**
 * 添加事件日志记录
 * @param macAddress
 * @param eventType
 * @param isSuccess
 * @param sourceData
 * @param dataType
 */
-(void) addActionEventLog:(NSString *)macAddress eventType:(BleActionEventType)eventType isSuccess:(BOOL)isSuccess sourceData:(NSString *)sourceData dataType:(NSString *)dataType;

/**
 * 添加错误信息记录
 * @param macAddress
 * @param errorLog
 */
-(void) addBleErrorLog:(NSString *)macAddress errorType:(BleErrorType)type;





/**
 * 根据设备MacAddress,设置自动上传
 * @param macAddress
 * @param fileType
 */
-(void) setAutomaticUploadWorkers:(NSString *) macAddress fileType:(BleLogFileType)type;


/**
 * 根据指定文件类型，设置自动上传
 * @param fileType
 */
-(void) setAutomaticUploadForAllDevices:(BleLogFileType)type;

/**
 * 根据设备MacAddress,上传指定文件类型的日志报告至服务器
 * @param macAddress
 * @param fileType
 */
-(void) uploadBleReport:(NSString *) macAddress fileType:(BleLogFileType)type;


/**
 * 上传指定文件类型的日志报告至服务器
 * @param fileType
 */
-(void) uploadAllBleReport:(BleLogFileType)fileType;

/**
 * 设置蓝牙日志报告的保存路径
 * @param filePath
 * @param accountName
 * @param appVersion
 */
-(void) setBleReportFilePath:(NSString * )filePath accountName:(NSString * )accountName appVersion:(NSString *)appVersion;


/*
 * 打印log日志文件的内容 
 */
-(void)printlnFileMessage;

@end
