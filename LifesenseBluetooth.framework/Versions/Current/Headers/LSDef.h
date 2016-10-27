//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_LSDEF_H
#define LSSDK_LSDEF_H

#define LSLOGC LSLog::log

#define JSONDESERIAL(doc, jsonText) \
    doc.Parse(jsonText.c_str());   \
    if (doc.HasParseError()) { \
        LSLOGC("json解析出错,代码:%d", doc.GetParseError());    \
        return std::vector<DataParserResult>();   \
    }

#define LSMALLOC(cls, size)	(cls*) malloc( sizeof(cls) * size)

#define LSFREE(inst)		\
if (inst)					\
{							\
free(inst);					\
inst = NULL;					\
}

#define LSDELETE(inst)		\
if (inst)					\
{							\
delete inst;					\
inst = NULL;					\
}

#define LSDELETE_ARRAY(inst)		\
	if (inst)					\
{							\
	delete[] inst;					\
	inst = NULL;					\
}

#define LSBZero(inst, size) bzero(inst,size)

// 获取位,从0开始
#define GetBit(value, bit) (((value)&(1<<bit))?1:0)
// 设置位为1，从0开始
#define SetBit(value, bit) ((value)|(1<<bit))
// 设置位为0，从0开始
#define ClearBit(value, bit) ((value)&(~(1<<bit)))

#define LS_BEGIN namespace lifesense {
#define LS_END }
#define USING_LS using namespace lifesense

#define LS_PLATFORM_UNKNOWN         -1
//#define LS_PLATFORM_WIN32           0
#define LS_PLATFORM_WINRT           1
#define LS_PLATFORM_ANDROID         2
#define LS_PLATFORM_IOS             3
//#define LS_PLATFORM_MAC             4

// Determine target platform by compile environment macro.
#define LS_TARGET_PLATFORM             LS_PLATFORM_UNKNOWN

// mac
//#if defined(TARGET_OS_MAC) || defined(__APPLE__)
//#undef  LS_TARGET_PLATFORM
//#define LS_TARGET_PLATFORM         LS_PLATFORM_MAC
//#endif

// iphone
#if defined(TARGET_OS_IPHONE)
#undef  LS_TARGET_PLATFORM
#define LS_TARGET_PLATFORM         LS_PLATFORM_IOS
#endif

// android
#if defined(ANDROID) || defined(__ANDROID__)
#undef  LS_TARGET_PLATFORM
#define LS_TARGET_PLATFORM         LS_PLATFORM_ANDROID
#endif

// win32
//#if defined(_WIN32) && defined(_WINDOWS)
//#undef  LS_TARGET_PLATFORM
//#define LS_TARGET_PLATFORM         LS_PLATFORM_WIN32
//#endif


// WinRT (Windows 8.1 Store/Phone App)
#if defined(WINRT)
#undef  LS_TARGET_PLATFORM
#define LS_TARGET_PLATFORM          LS_PLATFORM_WINRT
#endif

//////////////////////////////////////////////////////////////////////////
// post configure
//////////////////////////////////////////////////////////////////////////

// check user set platform
#if ! LS_TARGET_PLATFORM
#error  "Cannot recognize the target platform; are you targeting an unsupported platform?"
#endif

typedef unsigned short ushort;
typedef unsigned char uchar;
typedef unsigned int uint;
typedef unsigned long ulong;
typedef unsigned long long ullong;
typedef long long llong;


enum LSStreamSeek {
    LS_STREAM_SEEK_BEGIN = 0 ,
    LS_STREAM_SEEK_CUR       ,
    LS_STREAM_SEEK_END       ,
};


typedef struct _MTime_t {
    int nSecond;		/* 秒 – 取值区间为[0,59] */
    int nMinute;		/* 分 - 取值区间为[0,59] */
    int nHour;          /* 时 - 取值区间为[0,23] */
    int nMDay;          /* 一个月中的日期 - 取值区间为[1,31] */
    int nMonth;         /* 月份（从一月开始，0代表一月） - 取值区间为[0,11] */
    int nYear;          /* 年份，其值从1900开始 */
    int	nWDay;          /* 星期–取值区间为[0,6]，其中0代表星期天，1代表星期一 */
    int nYDay;          /* 从每年的1月1日开始的天数–取值区间为[0,365]，其中0代表1月1日，1代表1月2日 */
    int nDst;			/* 夏令时标识符，实行夏令时的时候，m_nDst为正。不实行夏令时的进候，m_nDst为0；不了解情况时，m_nDst为负。*/
    long nGmtOffset;		/* 指定了日期变更线东面时区中UTC东部时区正秒数或UTC西部时区的负秒数 */
    char szZone[128];	/* 当前时区的名字 */
    ullong nTimestamp;   /* 时间戳 */
}MTime_t;


#endif //LSSDK_LSDEF_H
