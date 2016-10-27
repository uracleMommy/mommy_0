//
//  LSBLEDeviceManager.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BleManagerProfiles.h"
#import "NSMutableArray+QueueAdditions.h"
#import "model.h"
#import "LSConst.h"
#import "BleDebugLogger.h"

typedef NS_ENUM(NSUInteger, LSOTAState) {
    LSOTAStateNotSetCentralManager,
    LSOTAStateNotAvailable,
    LSOTAStateNotFound,
    LSOTAStateHexFileNotFound,
    LSOTAStateHexFileInvalid,
    LSOTAStateConnectFailed,
    LSOTAStateDisconnected,
    LSOTAStateNotSupport,
    LSOTAStateEnterDFUModeFailed,
    LSOTAStateEnteredDFUMode,
    LSOTAStateUpgrading,
    LSOTAStateUpgradeFailed,
    LSOTAStateUpgradeCancel,
    LSOTAStateSuccess,
    LSOTAStateVERSIONHASUPGRADED,//此文件版本已经升级过了,升级失败
    LSOTAStateBATTERYLOW,//电量不足升级失败
    LSOTAStateCODEVERSIONNOCORRECT,//拒绝本次下载,升级失败
    LSOTAStateCHECKFAILURE,//文件校验失败,退出升级
    LSOTAStateBATTERYLOWUPDATEFAILURE, //电量不足更新失败，退出升级
};


typedef NS_ENUM(NSUInteger, OTADeviceType) {
    OTADeviceType_Mambo,
    OTADeviceType_MamboHR,
    OTADeviceType_MamboWatch,
};

// 配对状态回调
typedef void(^MatchBlock)(BOOL bMatch);


@protocol LSOTADelegate <NSObject>

- (void)otaState:(LSOTAState)state;

- (void)otaUpgradePercent:(NSInteger)percent;

@end

@interface LSBLEDeviceManager : NSObject
@property(nonatomic)BOOL isBluetoothPowerOn;
@property(nonatomic,strong,readonly)NSString *versionName;

//获取实例对象
+(instancetype)defaultLsBleManager;

//蓝牙状态检测
-(void)checkBluetoothStatus:(void(^)(BOOL isSupportFlags,BOOL isOpenFlags))checkCompletion;

//根据指定条件搜索乐心设备
-(BOOL)searchLsBleDevice:(NSArray *)deviceTypes ofBroadcastType:(BroadcastType)broadcastType searchCompletion:(void(^)(LSDeviceInfo* lsDevice))searchCompletion;

//停止搜索
-(BOOL)stopSearch;

//与设备进行配对
-(BOOL)pairWithLsDeviceInfo:(LSDeviceInfo *)lsDevice pairedDelegate:(id<LSBlePairingDelegate>)pairedDelegate;

//启动测量数据接收服务
-(BOOL)startDataReceiveService:(id<LSBleDataReceiveDelegate>)dataDelegate;

//停止测量数据接收服务
-(BOOL)stopDataReceiveService;

//绑定设备用户编号
-(BOOL)bindingDeviceUsers:(NSUInteger)userNumber userName:(NSString *)name;

//设置测量设备列表
-(void)setMeasureDeviceList:(NSArray *)deviceList;

//添加单个测量设备
-(BOOL)addMeasureDevice:(LSDeviceInfo *)lsDevice;

//根据广播ID删除单个测量设备
-(BOOL)deleteMeasureDevice:(NSString *)broadcastId;

//设置产品的用户信息，对于A3协议的脂肪秤
-(BOOL)setProductUserInfo:(LSProductUserInfo *)userInfo;

//设置计步器的用户信息
-(BOOL)setPedometerUserInfo:(LSPedometerUserInfo *)pedometerUserInfo;

//设置计步器的闹钟信息
-(BOOL)setPedometerAlarmClock:(LSPedometerAlarmClock *)alarmClock;

//set up enable scan device by broadcast name
-(BOOL)setEnableScanBrocastName:(NSArray*)enableDevices;

//new interface for bodyfat parse
-(LSWeightAppendData *)parseAdiposeDataWithResistance:(double)resistance_2 userHeight:(double)height_m userWeight:(double)weight_kg userAge:(int)age userSex:(UserSexType)sex;

//新增加接口，设置A2设备的声音振动提示功能
-(BOOL)setVibrationVoice:(LSVibrationVoice *)vibrationVoice;

//版本1.0.8新增接口，启动血压计开始测量
-(BOOL)startMeasuring;

//版本1.0.8新增接口，连接通过命令启动测量的血压计设备
-(BOOL)connectDevice:(LSDeviceInfo *)pairedDevice connectDelegate:(id<LSDeviceConnectDelegate>)connectDelegate;

//版本1.0.8新增接口，根据指定的设备类型、设备名称设置配对时采用固定的广播ID接口
-(BOOL) setCustomBroadcastID:(NSString *)customBroadcastID deviceName:(NSString *)deviceName deviceType:(NSArray*)deviceTypes;

-(void) setDispatchQueue:(dispatch_queue_t)dispatchQueue;

//版本V2.0.0新增接口，设置是否允许输出log调试信息
-(void) setDebugModeWithPermissions:(NSString *)key;

#pragma mark A5、A4/Wechat

/**
 * 更新用户信息到指定设备
 */
- (BOOL)setUserInfo:(LSDeviceInfo *)deviceInfo userInfo:(LSDUserInfo *)userInfo;

/**
 * 设置设备的闹钟信息
 */
- (BOOL)setAlarmClock:(LSDeviceInfo *)deviceInfo isOpenAlert:(BOOL)isOpenAlert alarmClockInfos:(NSArray<LSAlarmClock *> *)alarmClockInfos;

/**
 * 设置设备久坐提醒信息
 */
- (BOOL)setSedentaryInfo:(LSDeviceInfo *)deviceInfo isOpenAlert:(BOOL)isOpenAlert sedentaryInfos:(NSArray<LSSedentaryClock *> *)sedentaryInfos;

/**
 * 设置设备来电提醒信息
 */
- (BOOL)setCallReminderInfo:(LSDeviceInfo *)deviceInfo setting:(LSDCallReminder *)setting;

/**
 * 设备是否防丢模式
 */
- (BOOL)setLostSetting:(LSDeviceInfo *)deviceInfo isOpen:(BOOL)isOpen;

/**
 * 设置每周目标
 */
- (BOOL)setWeekTarget:(LSDeviceInfo *)deviceInfo target:(LSWeekTarget)target targetValue:(float)targetValue;

/**
 *  设置鼓励
 *
 *  @param deviceInfo 设备
 *  @param isOpen     是否打开
 *  @param step       目标步数
 *
 */
- (BOOL)setEncourageSetting:(LSDeviceInfo *)deviceInfo isOpen:(BOOL)isOpen step:(int)step;

/**
 *  心率检测设置
 *
 *
 */
-(BOOL)setHeartRateSetting:(LSDeviceInfo *)deviceInfo isOpen:(BOOL)isOpen startHour:(int)starthour startMinute:(int)startminute endHour:(int)endhour endMinute:(int)endminute;
/**
 *  设置心率区间(Watch)
 *
 *  @param deviceInfo 设备
 *  @param age        年龄
 *
 *  @return 成功返回YES
 */
- (BOOL)setHeartRateSection:(LSDeviceInfo *)deviceInfo age:(NSUInteger)age;

/**
 *  运动区间心率上下限设置(Watch)
 *
 *
 */
-(BOOL)setSportHeartRateSetting:(LSDeviceInfo *)deviceInfo MaxHeartRateZone:(int)maxHeartRateZone MinHeartRateZone:(int)minHeartRateZone;

//获取设备设置信息命令
-(BOOL)setPushGetInfor:(LSDeviceInfo *)deviceInfo GetDeviceInfoType:(LSGetDeviceInfoType)GetDeviceInfor FlashType:(int)flashType BeginAddr:(int)beginAddr EndAddr:(int)endAddr;

/**
 * 设置Log目录地址, 全路径
 */
- (void)setLogDirectory:(NSString *)logPath;

/*
 * 是否保存log文件
 */
- (void)setIsSaveLog:(BOOL)isSaveLog;


/**
 *  @brief 获取设备电压（异步）
 *  @brief 通过@see LSBleDataReceiveDelegate的bleManagerDidReceiveBatteryInfo:device:接口回调
 *
 *  @param device 设备
 *
 *  @return 是否调用成功
 */
- (BOOL)getVoltageInfo:(LSDeviceInfo *)deviceInfo;

/**
 *  设置时区
 *
 *  @param timezone 时区
 */
- (void)setDeviceTimeZone:(NSInteger)timezone;

#pragma mark OTA

// OTA升级
- (void)upgradeWithMacAddress:(NSString *)macAddr hardwareVer:(NSString *)hardwareVer softwareVer:(NSString *)softwareVer deviceType:(OTADeviceType)deviceType filePath:(NSURL *)filePath delegate:(id <LSOTADelegate>)delegate;

//查找目标设备的广播
-(void)findDeviceBroadcast:(NSString *)macAddress deviceType:(LSDeviceType)type findCompletion:(void(^)(BOOL isSuccess))findCompletion;


-(void)cancelFindDeviceBroadcast;


-(void)checkPhoneBluetoothStatus:(id<LSBluetoothStateChangeDelegate>)stateChangeDelegate;

- (void)checkMatchWithMacAddr:(NSString *)macAddr matchBlock:(MatchBlock)matchBlock;

#pragma mark -获取系统已连接的设备
-(NSArray *)checkConnectedPeripheral:(NSArray *)targetServices;

-(void)cancelUpgradeDevice;

-(void)printlnReportlog;

/**
 *  SDK版本
 *
 *  @return 如T1.0.0
 */
+ (NSString *)version;

@end
