//
// Created by lifesense on 15/12/3.
//

#ifndef LSSDK_JNIHELPER_H
#define LSSDK_JNIHELPER_H
#include "LSDef.h"

#if LS_TARGET_PLATFORM == LS_PLATFORM_ANDROID
#include <jni.h>
#include <string>

LS_BEGIN

typedef struct JniMethodInfo_
{
    JNIEnv *    env;
    jclass      classID;
    jmethodID   methodID;
} JniMethodInfo;

class LSJniHelper
{
public:
    static std::string jstring2string(jstring str);
    static jstring string2jstring(const char *pat);
    static jstring string2jstring(std::string &pat);
    static jobject int2IntegerObject(int value);
    static jobject double2DoubleObject(double value);
    static jobject float2FloatObject(float value);
    static jobject long2FloatObject(long value);
    static jobject short2FloatObject(short value);


    static void setJavaVM(JavaVM *javaVM);
    static JavaVM* getJavaVM();
    static JNIEnv* getEnv();

    static bool setClassLoaderFrom(jobject activityInstance);
    static bool getStaticMethodInfo(JniMethodInfo &methodinfo,
                                    const char *className,
                                    const char *methodName,
                                    const char *paramCode);
    static bool getMethodInfo(JniMethodInfo &methodinfo,
                              const char *className,
                              const char *methodName,
                              const char *paramCode);

//    static jmethodID loadclassMethod_methodID;
//    static jobject classloader;

private:
    static JNIEnv* cacheEnv(JavaVM* jvm);

    static bool getMethodInfo_DefaultClassLoader(JniMethodInfo &methodinfo,
                                                 const char *className,
                                                 const char *methodName,
                                                 const char *paramCode);

    static JavaVM* _psJavaVM;


    };

LS_END
#endif

#endif //LSSDK_JNIHELPER_H
