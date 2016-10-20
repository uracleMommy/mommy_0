//
// Created by lifesense on 15/12/15.
//

#ifndef LSSDK_LSLOG_H
#define LSSDK_LSLOG_H

#include "LSDef.h"
#include <iostream>

LS_BEGIN

class LSLog {
public:
    static void log(const char *format, ...);
    static void logd(int line, const char *funcName, const char *filePath, const char * format, ...);

    static void setIsSaveLogToFile(bool isSave);

};

LS_END

#endif //LSSDK_LSLOG_H
