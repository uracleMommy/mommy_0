//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_DATAPARSER_H
#define LSSDK_DATAPARSER_H

#include <string>
#include <vector>
#include "./tools/LSDef.h"
#include "LSEnumDef.h"
#include "./A5/LSA5Protocol.h"
#include "./A5/LSA5ProtocolAA.h"


#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID
#include <jni.h>
#elif LS_TARGET_PLATFORM == LS_PLATFORM_IOS
#endif

LS_BEGIN

class DataParser {
private:
    LSA5ProtocolAA *protocolA5AA;
    LSA5Protocol *protocolA580;

public:
    DataParser();
    ~DataParser();

    static std::vector<DataParserResult> createBindSuccess(LSProtocolVersion protocolVer);
    static std::vector<DataParserResult> createLoginResult(bool isLoginSuccess, int packageIndex, LSProtocolVersion protocolVer);

    static std::string decode(char *data, unsigned int size, int &cmd, LSProtocolVersion protocolVer);
    static std::vector<DataParserResult> encode(std::string json, int cmd, LSProtocolVersion protocolVer);

#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID
        bool appendProtocolPackage(jobject obj, char *data, uint length, std::string tag);
#elif LS_TARGET_PLATFORM == LS_PLATFORM_IOS
        bool appendProtocolPackage(NSObject *obj, char *data, uint length, std::string tag);
#endif

};

LS_END

#endif //LSSDK_DATAPARSER_H
