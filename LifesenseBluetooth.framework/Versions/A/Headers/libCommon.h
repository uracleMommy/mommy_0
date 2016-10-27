//
//  libCommon.h
//  libCom
//
//  通用函数、宏
//
//  Created by Damein on 15/8/18.
//  Copyright (c) 2015年 Damein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSLog.h"

//#if (DEBUG == 1)
#define MLog(fmt,...) [LSLog log:@"app" isSave:NO format:fmt,##__VA_ARGS__]
#define MLogF(fmt,...) [LSLog log:@"app" isSave:YES format:fmt,##__VA_ARGS__]
#define MLogT(tag,fmt,...) [LSLog log:tag format:fmt,##__VA_ARGS__]

//#else
//#define MLog         // 忽略log信息
//#endif

#define RGB(r,g,b) [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a / 100.f]

// 一个空的block,没有返回值也没有参数
typedef void(^EmptyBlock)();

// 对分配和释放内存的封装
#define LSMalloc(type,size) (type*)malloc(size)
#define LSFree(inst) if(inst){free(inst);inst = NULL;}
#define BZero(inst,size) bzero(inst,size)

// 获取位,从0开始
#define GetBit(value, bit) (((value)&(1<<bit))?1:0)
// 设置位为1，从0开始
#define SetBit(value, bit) ((value)|(1<<bit))
// 设置位为0，从0开始
#define ClearBit(value, bit) ((value)&(~(1<<bit)))

#define NSSF(format,...) [NSString stringWithFormat:format,__VA_ARGS__]


#define NSUserDefaultsInst [NSUserDefaults standardUserDefaults]

// 屏幕宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

// 屏幕高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 创建一个weak变量
#define WeakVar(weakVar,var) __weak typeof(var) weakVar = var

// 创建一个strong变量
#define StrongVar(strongVar,var) __strong __typeof(var) strongVar = var

// 声明一个单例
#define Create_Singleton_Def() + (instancetype)shared

// 实现一个单例
#define Create_Singleton_Imp(cls) \
+ (instancetype)shared \
{ \
    static cls *_gs_cls = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (!_gs_cls) { \
            _gs_cls = [cls new]; \
        } \
    }); \
    return _gs_cls; \
} \

#pragma mark 通知中心

/**
 *  添加一个消息监听到通知中心
 *
 *  @param observer
 *  @param selector
 *  @param name     监听的名字
 */
void addPost(id observer, SEL selector,NSString *name);

/**
 *  通过名字删除消息监听
 *
 *  @param observer
 *  @param name     监听的名字
 */
void removePost(id observer,NSString *name);

/**
 *  发送一个消息监听
 *
 *  @param name   监听的名字
 *  @param object 发送的数据，没有就填nil
 */
void post(NSString *name,id object);

#pragma mark 其它

/**
 *  调用target里面的sel方法，新的SDK会报警告，这里统一调这个接口，可去掉警告
 *
 *  @param target 目标实例
 *  @param sel    selector方法
 *  @param object 要传的数据
 */
void performSelector(id target,SEL sel,id object);

// int大小端互转
unsigned short ConvertShortEndian(unsigned short s);

// short大小端互转
unsigned int ConvertIntEndian(unsigned int n);

#pragma mark block

/**
 *  在主线程调用block
 *
 *  @param block
 */
void runBlockInMain(dispatch_block_t block);

/**
 *  在子线程调用block
 *
 *  @param block
 */
void runBlockInAsync(dispatch_block_t block);

/**
 *  在子线程调用完block后回调到主线程的block
 *
 *  @param asyncBlock 子线程调用
 *  @param syncBlock  主线程调用
 */
void runBlock(dispatch_block_t asyncBlock, dispatch_block_t syncBlock);

#pragma mark 乐心通用函数
// 浮点型转整型，精度两位小数
// 低三个字节是数据，高一个字节是带符号数的10的指数
// 0X0013C3=5059
// 0XFE=-2
// 5059*10^(-2)=50.59Kg
int ls_Float2Int(float value);
// 整型转浮点型
float ls_Int2Float(int value);
// 把时分转换成short
short ls_Time2Short(char hour, char minute);
// 把short转换成时分
void ls_Short2Time(short time, char *hour, char *minute);
// 把short转换成sfloat
float ls_Short2SFloat(short value);

NSData *ls_strMac2DataMac(NSString *strMac);
NSString *ls_dataMac2StrMac(NSData *data);
