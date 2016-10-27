//
// Created by lifesense on 15/12/11.
//

#ifndef LSSDK_LSA5PROTOCOL_H
#define LSSDK_LSA5PROTOCOL_H

#include <string>
#include <vector>
#include "../tools/LSDef.h"
#include "../LSEnumDef.h"
#include "../tools/LSSteamBuffer.h"

#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID
#include <jni.h>
#elif LS_TARGET_PLATFORM == LS_PLATFORM_IOS
#endif


LS_BEGIN


/**
 *  命令字
 */
    typedef enum _LSA5ProtocolCommand {
        /**
         * 通用消息回复
         */
                LSProtocolCommandRespResult = 0,

        /**
          *  计步器下载信息
          */
                LSProtocolCommandDownloadInfo = 0x50,
        /**
         *  计步器每天的测量数据
         */
                LSProtocolCommandEverydayMeasureData,
        /**
         *  计步器睡眠压缩数据
         */
                LSProtocolCommandSleepData,
        /**
         *  计步器心率数据
         */
                LSProtocolCommandHeartRateData,
        /**
         *  计步器每20秒步数
         */
                LSProtocolCommandStepData,
        /**
         *  配对确认
         */
                LSProtocolCommandPairConfirm,
        /**
         *  计步器传感器采样数据到乐心服务器
         */
                LSProtocolCommandMeasureDataToServer,
        /**
         *  计步器每小时测量数据
         */
                LSProtocolCommandHourlyMeasureData = 0x57,
        /**
         *  push用户信息确认到乐心服务器
         */
                LSProtocolCommandUserInfoToServer = 0x61,
        /**
         *  Device Type, Device ID, manufacture Data等信息,注：微信使用,APP暂不管
         */
                LSProtocolCommandDeviceInfo,
        /**
         *  烧码模式
         */
                LSProtocolCommandOTAMode,
        /**
         *  计步器游泳圈数到乐心服务器
         */
                LSProtocolCommandSwimming,
        /**
         *  push用户信息到计步器
         */
                LSProtocolCommandPushUserInfo = 0x68,
        /**
         *  push闹钟设置到计步器
         */
                LSProtocolCommandPushAlarmClock = 0x69,
        /**
         *  push来电提醒设置到计步器
         */
                LSProtocolCommandPushCallReminder = 0x6A,
        /**
         *  push 心率检测设置到计步器
         */
                LSProtocolCommandPushHeartRate = 0x6D,
        /**
         *  push久不动（久坐）提醒设置到计步器
         */
                LSProtocolCommandPushSedentary = 0x6E,
        /**
         *  push防丢设置到计步器
         */
                LSProtocolCommandPushLost = 0x6F,
        /**
         *  push心率区间到手环
         */
        LSProtocolCommandPushHeartSection = 0x74,

    }LSA5ProtocolCommand;



    class LSA5Protocol {
    private:
        LSStreamBuffer *_recvData;
    public:
        LSA5Protocol();
        ~LSA5Protocol();
        
#pragma mark 数据转换成协议数据

        static std::vector<DataParserResult> createLoginResult(std::string& json,
                                                               short packageIndex);

        static std::vector<DataParserResult> createBindSuccess(short packageIndex);

        static std::vector<DataParserResult> createPedometerUserInfo(std::string& json,
                                                                     short packageIndex);

        static std::vector<DataParserResult> createRecvResult(std::string& json, short packageIndex);

        static std::vector<DataParserResult> createPairConfirm(std::string& json,
                                                               short packageIndex);

        static std::vector<DataParserResult> createPushUserInfo(std::string& json,
                                                                short packageIndex);

        static std::vector<DataParserResult> createPushAlarmSetting(std::string& json,
                                                                    short packageIndex);

        static std::vector<DataParserResult> createPushCallReminderSetting(std::string& json,
                                                                           short packageIndex);

        static std::vector<DataParserResult> createPushSedentarySetting(std::string& json,
                                                                        short packageIndex);

        static std::vector<DataParserResult> createPushLostSetting(std::string& json,
                                                                   short packageIndex);
        static std::vector<DataParserResult> createPushHeartSection(std::string& json,
                                                                           short packageIndex);
#pragma mark 协议数据解析成协议对象

        static std::string parseDownloadInfo(lifesense::LSStreamBuffer *buffer);

        static std::string parseMeasure(LSStreamBuffer *buffer);

        static std::string parseSleep(LSStreamBuffer *buffer);

        static std::string parseHeartRate(LSStreamBuffer *buffer);

        static std::string parse20SecondsStep(LSStreamBuffer *buffer);

        static std::string parseSwim(LSStreamBuffer *buffer);

#pragma mark 外部调用
        static std::vector<DataParserResult>  encode(std::string& json, LSA5ProtocolCommand cmd, short packageIndex);

        static std::string decode(char *data, unsigned int size, int &cmd);

#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID
        bool appendProtocolPackage(jobject obj, char *data, uint length, std::string tag);
#elif LS_TARGET_PLATFORM == LS_PLATFORM_IOS
        bool appendProtocolPackage(NSObject *obj, char *data, uint length, std::string tag);
#endif

#pragma mark 工具
        static bool isSupportCmdId(uchar cmdId);

        static bool isSupportProtocol(char *data);
    };


LS_END

#endif //LSSDK_LSA5PROTOCOL_H
