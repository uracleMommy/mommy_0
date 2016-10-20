//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_LSCRC_H
#define LSSDK_LSCRC_H

#include "LSDef.h"

LS_BEGIN

class LSCrc {

public:
    static uint crc32(char *data, int length);

private:
    static void init_crc_table(uint *crc_table);

};

LS_END

#endif //LSSDK_LSCRC_H
