//
//  BleCommonProperties.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-9-19.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#ifndef LsBluetooth_Test_BleCommonProperties_h
#define LsBluetooth_Test_BleCommonProperties_h


//测量单位
typedef enum {
    UNIT_KG=0,
    UNIT_LB=1,
    UNIT_ST=2,
}MeasurementUnitType;

//性别类型，1表示男，2表示女
typedef enum {
    SEX_MALE=1,
    SEX_FEMALE=2
}UserSexType;

typedef enum{
    MANAGER_WORK_STATUS_IBLE=0,
    MANAGER_WORK_STATUS_SCAN=1,
    MANAGER_WORK_STATUS_PAIR=2,
    MANAGER_WORK_STATUS_UPLOAD=3,
    MANAGER_WORK_STATUS_CONNECT=4,
    MANAGER_WORK_STATUS_FIND_BROADCAST=5,
}ManagerWorkStatus;


typedef enum
{
    BROADCAST_TYPE_NORMAL=1,//支持除了血压计配对外其他本公司产品的配对模式
    BROADCAST_TYPE_PAIR=2,//只支持血压计配对模式
    BROADCAST_TYPE_ALL=3,//支持本公司所有产品的配对模式
}BroadcastType;

typedef enum {
    PAIRED_SUCCESS=1,
    PAIRED_FAILED=2,
}PairedResults;

typedef enum{
    DATA_UPLOAD_SUCCESS=1,
    DATA_UPLOAD_FAILED=2,
}DataUploadResults;

//连接状态
typedef enum{
    CONNECTED_SUCCESS=1,
    CONNECTED_FAILED=2,
    DISCONNECTED=3
}DeviceConnectState;

//A4设备上传的命令请求编码
typedef enum{
    COMMAND_REQUEST_C3=0xC3,
    COMMAND_REQUEST_C7=0xC7,
    COMMAND_REQUEST_C9=0xC9,
    COMMAND_REQUEST_CA=0xCA,
    COMMAND_REQUEST_CC=0xCC,
    COMMAND_REQUEST_CE=0xCE,
    COMMAND_REQUEST_80=0x80,
    COMMAND_REQUEST_82=0x82,
    COMMAND_REQUEST_83=0x83,
    COMMAND_REQUEST_8C=0x8C,
    COMMAND_REQUEST_8B=0x8B,

    
}CommandRequestCode;


//new change for version 2.1.o
//A5协议手环测量数据类型
typedef enum {
    /**
     * 设备信息
     */
    PacketTypeDeviceInfo,
    /**
     * 测量数据
     */
    PacketTypeMeasureData,
    /**
     * 20s的步数
     */
    PacketTypeIntervalSteps,
    /**
     * 睡眠数据
     */
    PacketTypeSleepData,
    /**
     * 心率数据
     */
    PacketTypeHeartRateData,
    /**
     * 游泳数据
     */
    PacketTypeSwimmingLaps,
}PacketType;

//push 命令
typedef enum {
    PushMessageUserInfo=0x68,
    PushMessageAlarmClock=0x69,
    PushMessageCallToReminder=0x6A,
    PushMessageHeartRateDetection=0x6D,
    PushMessageSedentary=0x6E,
    PushMessageAntiLost=0x6F,
    PushMessageHeartRateRange=0x71,
    PushMessageEncourageInfo=0x70,
    PushMessageQueryConfigInfo=0x66,
    
}PushMessage;

typedef enum
{
    Unknown_Event,
    Start_SDK,
    Start_Service,                    //启动数据接收服务
    Start_Scan,						 //开始扫描
    Stop_Scan,						 //停止扫描
    Connect_Device,					 //开始连接
    Connect_State_Change,           //连接状态改变
    Discover_Service,			 	//开始发现服务
    Read_Device_Info,               //读取设备信息
    Enable_Character,     			//开始使能通道
    Receive_Data,				     //接收数据
    Write_Response,					//写回包
    Write_Call_Msg,             	//写来电信息
    Write_Push_Msg,             	//写push命令
    Close_Bluetooth,                //手机蓝牙关闭
    Enable_Bluetooth,				//手机蓝牙打开
    Abnormal_Disconnect,			//异常断开
    Call_State_Changed,				//手机来电状态改变
    Cancel_Connection,				//断开连接
    Close_Gatt,						//关闭gatt
    App_Message,					//App自定义消息
    Stop_Service,					//停止数据接收服务
    Stop_SDK,                       //停止sdk，当App退出或用户退出登录
    Data_Parse,                     //数据解析
    Addd_Device,                    //添加设备
    Delete_Device,                  //删除设备
    Scan_Results,                   //扫描结果
    Check_Connected,                //检查系统已连接的设备
    Error_Message,                  //错误信息
    Warning_Message,                //警告信息
    Upgrade_Message,                //升级
    Data_Package,                   //数据包操作
    Close_Character,                //关闭通道
    

}BleActionEventType;

typedef enum
{
    UNKNOWN_ERROR=0X00,
    SCAN_ERROR=0x100,						//扫描错误
    GATT_CONNECT_ERROR=0X101,				//gatt连接错误
    GATT_DISCOVER_SERVICE_ERROR=0X102,		//发现服务错误
    SET_NOTIFY_OR_INDICATE_ERROR=0X103,     //使能通道错误
    READ_DEVICE_INFO_ERROR=0X104,          //读取设备信息错误
    PUSH_MESSAGE_ERROR=0X105,              //写push命令错误
    DATA_CRC_ERROR=0X106,						//数据错误，crc
    ABNORMAL_DISCONNECT_ERROR=0X107,       //异常断开
    PUSH_CALL_MESSAGE_ERROR=0X108,         //写来电信息错误
}BleErrorType;

typedef enum
{
    //扫描统计
    START_SEARCH_DEVICE=0X01,
    STOP_SEARCH_DEVICE=0X02,
    
    //系统连接统计
    START_SYSTEM_CONNECT_DEVICE=0X03,
    STOP_SYSTEM_CONNECT_DEVICE=0X04,
    
    //发现服务统计
    START_DISCOVER_SERVICE=0X05,
    STOP_DISCOVER_SERVICE=0X06,
    
    //协议连接统计
    START_PROTOCOL_CONNECT_DEVICE=0X07,
    STOP_PROTOCOL_CONNECT_DEVICE=0X08,
    
    //数据接收统计
    START_RECEIVE_DATA=0X09,
    STOP_RECEIVE_DATA=0X10,
    
    //异常断开统计
    ABNORMAL_DISCONNECT=0X11,
    
    //重连连接统计
    START_RECONNECT_DEVICE=0X12,
    STOP_RECONNECT_DEVICE=0X13,
    
    //扫描错误
    SCAN_FAILED=0XE0,
    
    //连接失败统计
    CONNECTION_FAILED=0XE1,
    
    ABNORMAL_DATA=0XE2,
    
}BleStatisticType;

typedef enum
{
    BleLogFileAll,
    BleLogFileError,
    BleLogFileAction,
    BleLogFileStatistic,
    
} BleLogFileType;

typedef enum
{
    //前台
    ApplicationStateForeground,
    
    //后台
    ApplicationStateBackground,
} ApplicationState;


#endif
