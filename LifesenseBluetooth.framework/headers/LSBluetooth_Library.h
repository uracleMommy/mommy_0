//
//  LSBluetooth_Library.h
//  LSBluetooth-Library
//
//  Created by chixiang.cai on 14-11-14.
//  Copyright (c) 2014年 Lifesense. All rights reserved.
//  current version test_v1.0.5

#import <Foundation/Foundation.h>
#import "LSBLEDeviceManager.h"
#import "NSMutableArray+QueueAdditions.h"


FOUNDATION_EXPORT NSString *const BLUETOOTH_SDK_VERSION;

@interface LSBluetooth_Library : NSObject

/*
 * 版本V1.0.0
 * 1、修改内容，新增实时监听手机蓝牙状态改变的回调接口
 * 2、修改内容，修复查找目标设备广播内容失败的问题，当设备已被系统绑定后，设备不会再广播，导致该接口无返回
 * 3、修改启动数据接收服务的内部处理机制，新增定点扫描连接处理机制、默认时间段为7秒
 */


/*
 * 版本V1.0.1
 * 1、修改内容，新增蓝牙日志报告log模块，实现每个设备记录一个通讯日志文件
 *
 */

/*
 * 版本V1.0.2
 * 1、修改内容，新增log日志事件类型
 *
 */

/*
 * 版本V1.0.3
 * 1、修改内容，新增动态监听设备连接状态（每90秒监听一次），为避免设备断开后，无连接状态改变的回调，导致sdk内部实现不了重新连接的逻辑
 *
 */


/*
 * 版本V1.0.4
 * 1、修改内容，新增监听应用进入前后台的通知，
 * 2、修改单协议的微信手环在前后台的处理机制，当应用进入后台时，关闭微信通道，当应用重新从后台返回到前台时，重新打开微信通道
 *
 */

/*
* 版本V1.0.5
* 1、修改内容，新增监听应用退出、重新加载的通知
*
*
*/


@end
