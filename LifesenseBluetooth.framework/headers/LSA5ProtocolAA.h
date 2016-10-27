//
// Created by lifesense on 16/1/7.
//

#ifndef LSSDK_LSA5PROTOCOLAA_H
#define LSSDK_LSA5PROTOCOLAA_H

#include <string>
#include <vector>
#include "../tools/LSDef.h"
#include "../LSEnumDef.h"
#include "../tools/LSSteamBuffer.h"
#include "../tools/rapidjson/document.h"

#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID

#include <jni.h>

#elif LS_TARGET_PLATFORM == LS_PLATFORM_IOS
#endif


LS_BEGIN

    class LSA5ProtocolAA {
    private:
            LSStreamBuffer *_recvData;
    public:
            LSA5ProtocolAA();
            ~LSA5ProtocolAA();

            static bool  isSupportProtocol(char *data);
#pragma mark 数据转换成协议数据
        // APP回复登录命令
        static std::vector<DataParserResult> createLoginResult(std::string &json);
        // 绑定产品成功的登录回包
        static std::vector<DataParserResult> createBindSuccess();
        // 回复计步器用户信息给设备
        static std::vector<DataParserResult> createPedometerUserInfo(std::string &json);
        // 回复接收数据结果,通用
        static std::vector<DataParserResult> createRecvResult(std::string &json);
        // 回复计步器配对确认信息
        static std::vector<DataParserResult> createPairConfirm(std::string &json);
        // 回复计步器信息
        static std::vector<DataParserResult> createDeviceInfo(std::string &json);
        //  push用户信息到蓝牙计步器
        static std::vector<DataParserResult> createPushWeekTarget(std::string &json);
        // push闹钟设置到蓝牙计步器
        static std::vector<DataParserResult> createPushAlarmSetting(std::string &json);
        // push来电提醒设置到蓝牙计步器
        static std::vector<DataParserResult> createPushCallReminderSetting(std::string &json);
        // push久不动（久坐）提醒设置到蓝牙计步器
        static std::vector<DataParserResult> createPushSedentarySetting(std::string &json);
        // push防丢设置到蓝牙计步器
        static std::vector<DataParserResult> createPushLostSetting(std::string &json);
        //  push心率检测设置到蓝牙手环
        static std::vector<DataParserResult> createPushHRSetting(std::string &json);
        //   push鼓励设置信息到蓝牙手环
        static std::vector<DataParserResult> createPushEncourageSetting(std::string &json);
        // push运动区间心率到蓝牙手环
        static std::vector<DataParserResult> createPushSportHRSetting(std::string &json);
        // push获取设备设置信息命令
        static std::vector<DataParserResult> createPushGetInfo(std::string &json);
        // push心率区间到蓝牙手环
        static std::vector<DataParserResult> createPushHeartSection(std::string& json);
#pragma mark 协议数据解析成协议对象
        // 设备登录APP
        static std::string parseLogin(LSStreamBuffer *buffer);
        // 发送请求计步器下载信息
        static std::string parseDownloadInfo(LSStreamBuffer *buffer);
        // 发送每天/每小时的测量数据
        static std::string parseMeasure(LSStreamBuffer *buffer);
        // 计步器睡眠压缩数据
        static std::string parseSleep(LSStreamBuffer *buffer);
        // 蓝牙计步器发送心率数据
        static std::string parseHeartRate(LSStreamBuffer *buffer);
        // 发送手环游泳圈数
        static std::string parseSwim(LSStreamBuffer *buffer);
        // 发送手环血氧数据
        static std::string parseBloodOxygen(LSStreamBuffer *buffer);
        // 发送跑步状态数据
        static std::string parseSportData(LSStreamBuffer *buffer);
        // 设备设置信息
        static std::string parseGetDeviceInfo(LSStreamBuffer *buffer) ;
#pragma mark 外部调用

        static std::vector<DataParserResult> encode(std::string &json, int cmd);

        static std::string decode(char *data, unsigned int size, int &cmdId);

#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID
        bool appendProtocolPackage(jobject obj, char *data, uint length, std::string tag);
#elif LS_TARGET_PLATFORM == LS_PLATFORM_IOS
        bool appendProtocolPackage(NSObject *obj, char *data, uint length, std::string tag);
#endif

        static ullong getUTC();

        static std::vector<DataParserResult> splitData(char *data, int dataSize, short packageIndex);
        static std::string getTimeZone(int timezone);
        static int getTimeZone(std::string timezone);

        static std::string documentToJsonStr(rapidjson::Document &document);
    };

LS_END

#endif //LSSDK_LSA5PROTOCOLAA_H
