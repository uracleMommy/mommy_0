//
//  LSDeviceProfiles.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 设备类型：01 体重秤、02 脂肪秤、03 身高、04 计步器、
 * 05  腰围尺、06 血糖仪、07 体温计、08 血压计
 */

typedef enum
{
    TYPE_UNKONW=0,
    LS_WEIGHT_SCALE=1,
    LS_FAT_SCALE = 2,
    LS_HEIGHT_MIRIAM = 3,
    LS_PEDOMETER =4,
    LS_WAISTLINE_MIRIAM=5,
    LS_GLUCOSE_METER=6,
    LS_THERMOMETER=7,
    LS_SPHYGMOMETER =8,
    LS_KITCHEN_SCALE = 9,
    LS_BAND, // 手环
}LSDeviceType;


@interface LSDeviceInfo : NSObject

@property(nonatomic, strong) NSString *deviceId;      //设备ID
@property(nonatomic, strong) NSString *deviceSn;      //设备SN
@property(nonatomic, strong) NSString *deviceName;    //设备名称
@property(nonatomic, strong) NSString *modelNumber;   //设备型号
@property(nonatomic, strong) NSString *password;      //密码
@property(nonatomic, strong) NSString *broadcastId;   //广播ID,A2,A3是广播ID,A4，A5是mac地址（无冒号的形式）
@property(nonatomic, strong) NSString *protocolType;      //协议类型
@property(nonatomic, assign) BOOL preparePair;                 //是否处于配对状态，不用保存在数据库，只是临时变量
@property(nonatomic, assign) LSDeviceType deviceType;          //设备类型
//@property(nonatomic, assign) NSUInteger supportDownloadInfoFeature;//支持下载用户信息的类型
@property(nonatomic, assign) NSInteger maxUserQuantity;          //最大用户数
@property(nonatomic, strong) NSString *softwareVersion;   //软件版本
@property(nonatomic, strong) NSString *hardwareVersion;   //硬件版本
@property(nonatomic, strong) NSString *firmwareVersion;   //固件版本
@property(nonatomic, strong) NSString *manufactureName;   //制造商名称
@property(nonatomic, strong) NSString *systemId;          //系统ID,暂时无值
@property(nonatomic, strong) NSString *timezone;   //时区，有些有
@property(nonatomic, assign) BOOL isInSystem;   // 是否在系统列表中


//new change for version 1.1.1
@property(nonatomic, strong) NSString *peripheralIdentifier;//系统蓝牙设备的id,可以唯一表示一个设备
@property(nonatomic, assign) NSUInteger deviceUserNumber;

// 版本 3.5增加
@property(nonatomic, strong) NSString *macAddress;        // 设备mac地址

@property(nonatomic,strong) NSNumber *rssi;

@end




