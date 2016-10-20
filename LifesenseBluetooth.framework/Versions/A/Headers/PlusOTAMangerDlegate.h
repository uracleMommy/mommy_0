//
//  PlusOTAMangerDlegate.h
//  LSBluetooth-Demo
//  Created by lifesense on 16/2/20.
//  Copyright © 2016年 Lifesense. All rights reserved.
#import <Foundation/Foundation.h>
enum DeviceUpgradeStatus {
    UNKNOWN,				//未知状态
    UPGRADE_SUCCESS,		//升级成功
    UPGRAGE_FAILURE,		//升级失败
};
enum DeviceUpgradeReason{
  NORMAL,      //升级正常
  FILEURLNULL, //升级文件URL为空
  VERSIONHASUPGRADED,//此文件版本已经升级过了,升级失败
  BATTERYLOW,//电量不足升级失败
  CODEVERSIONNOCORRECT,//拒绝本次下载,升级失败
  CHECKFAILURE,//文件校验失败,退出升级
  BATTERYLOWUPDATEFAILURE, //电量不足更新失败，退出升级
  OTHERREASONS,//升级失败
  UpgradeMode,//升级模式
  EnterUpgrade,//进入升级...
  BluetoothDisconnect,//蓝牙断开
  DisconnectTimeout,//连接超时
  DeviceNotFound, // 设备找不到
  CancelUpgrade, // 取消
};
@protocol PlusOTAMangerDlegate <NSObject>
@optional
-(void)onDeviceUpdradeStatus:(DeviceUpgradeStatus)upgradeStatus Code:(DeviceUpgradeReason)FailureReason;
//升级的百分比
-(void)PlusUpgradePercentage:(NSInteger)percentage;
//testLOG日志
-(void)logString:(NSString *)LogStr;
@end
