//
//  LogManager.h
//  log文件工具类
//  Created by lifesense on 16/4/1.
//  Copyright © 2016年 彭涛. All rights reserved.
//
#import <Foundation/Foundation.h>
@class LSBleActionEvent;
@class FileManger;
@interface LogManager : NSObject
@property (nonatomic,strong)NSString *logFolderPath;//当前文件夹路径
@property (nonatomic,strong)NSMutableDictionary *fileDic;
@property (nonatomic,strong)NSMutableDictionary *modelDic;
@property (nonatomic,strong)NSString *userID;
@property (nonatomic,strong)NSString *mac;
@property (nonatomic,strong)NSString *verSion;

-(void)setfilefolderpath:(NSString *)folderpath;
-(void)setuserID:(NSString *)userID andMac:(NSString *)mac andVersion:(NSString *)Version;
-(void)setLSBleActionEvent:(LSBleActionEvent *)LSBleActionEvent andMac:(NSString *)mac;
//-(NSArray *)GetAllfilepath;
@end
