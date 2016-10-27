//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_LSENUMDEF_H
#define LSSDK_LSENUMDEF_H


typedef struct _DataParserResult {
public:
    char *data;
    unsigned size;
}DataParserResult;


/**
 * 协议版本
 */
typedef enum _LSProtocolVersion {
    LSProtocolVersionA4 = 4, // 暂不支持
    LSProtocolVersionA5_80, // 0x80xx
    LSProtocolVersionA5_AA, // 0xAAxx
}LSProtocolVersion;

/**
 *  手机系统
 */
typedef enum _LSSystemPlatform {
        LSSystemPlatformUnKnown = 0,
            /**
             *  IOS
             */
            LSSystemPlatformIOS = 1,
            /**
             *  Android
             */
            LSSystemPlatformAndroid,
            /**
             *  WP
             */
            LSSystemPlatformWP,
}LSSystemPlatform;


#endif //LSSDK_LSENUMDEF_H
