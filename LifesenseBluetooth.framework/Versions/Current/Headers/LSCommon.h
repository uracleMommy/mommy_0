//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_LSCOMMON_H
#define LSSDK_LSCOMMON_H

#include "LSDef.h"


LS_BEGIN

class LSCommon {

public:
    static ushort ConvertShortEndian(ushort s);

    static uint ConvertIntEndian(uint n);

    static ullong CurrentTimestamp();
    
    static MTime_t CurrentTime();
    
    static MTime_t CurrentTimeWithTimeZone();
    

    static MTime_t TimestampToTime(long long utcTime);

    static MTime_t GetTimeFromSecond(uint second);

};

LS_END

#endif //LSSDK_LSCOMMON_H
