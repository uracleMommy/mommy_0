//
// Created by lifesense on 15/12/4.
//

#ifndef LSSDK_LSStreamBuffer_H
#define LSSDK_LSStreamBuffer_H

#include "LSDef.h"
#include <iostream>

LS_BEGIN

    class LSStreamBuffer {

    public:
        LSStreamBuffer();
        ~LSStreamBuffer();
        LSStreamBuffer(uint lSize);
        LSStreamBuffer(uchar* buffer, uint lSize);

        uchar ReadByte();
        ushort ReadShort();
        uint	ReadInt();
        std::string ReadString();
        int ReadString(char *buffer);
        int Read(char *buffer, uint len);

        int WriteByte(uchar c);
        int WriteShort(ushort s);
        int WriteInt(uint n);
        int WriteString(const char *str);
        int Write(const char *buffer, uint len);

        uint GetPosition();

        uint GetCapacity();

        uint GetSize();

        bool Resize(uint addSize = 0);

        uint Seek(LSStreamSeek seek, int offset);

        void Close();

        void Clear();

        char* GetBuffer(bool bCopy = false);
        // 记得调用LSFREE来释放返回值
        char* GetBuffer(int offset, uint size);
        void Rewind();

        void SetLittleEndian(bool b){m_bLittle = b;}
        bool IsLittleEndian(){return m_bLittle;}

    protected:
        void RecordSize();
    protected:
        uchar* m_pSrc;
        uchar* m_pCur;
        uint m_nPos;
        uint m_nSize;
        bool m_bCanFree;
        uint m_nCapacity;
        bool m_bLittle;
    };

LS_END

#endif //LSSDK_LSStreamBuffer_H
