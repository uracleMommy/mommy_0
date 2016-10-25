//
//  httpd.h
//  LSBluetooth-Library
//
//  Created by 陈俊铭 on 16/3/21.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#ifndef httpd_h
#define httpd_h
#include <string>

class HttpServer
{
public:
    int m_nPort;
    std::string m_strPath;
    int m_hSocket;
    bool m_bStop;
public:
    HttpServer(int port, const char *path);
    ~HttpServer();
        
    void start();
    void stop();
    
private:
    static void run(HttpServer *server);
};


#endif /* httpd_h */
