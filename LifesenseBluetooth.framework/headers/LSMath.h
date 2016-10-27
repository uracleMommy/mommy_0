//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_LSMATH_H
#define LSSDK_LSMATH_H

class LSMath {
public:
// 浮点型转整型，精度两位小数
// 低三个字节是数据，高一个字节是带符号数的10的指数
// 0X0013C3=5059
// 0XFE=-2
// 5059*10^(-2)=50.59Kg
    static int Float2Int(float value);
// 整型转浮点型
    static float Int2Float(int value);
// 把时分转换成short
    static short Time2Short(char hour, char minute);
// 把short转换成时分
    static void Short2Time(short time, char *hour, char *minute);
// 把short转换成sfloat
    static float Short2SFloat(short value);
};


#endif //LSSDK_LSMATH_H
