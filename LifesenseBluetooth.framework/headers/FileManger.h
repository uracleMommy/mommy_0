//
//  FileManger.h
//  log文件工具类
//
//  Created by lifesense on 16/3/22.
//  Copyright © 2016年 彭涛. All rights reserved.
//
#import <Foundation/Foundation.h>
@class LSBleActionEvent;

@interface FileManger : NSObject
@property (nonatomic,copy)NSString *filepath;//文件夹路径
+(instancetype)filemanager;
//-(void)writeData:(LSBleActionEvent *)logModel andfilepath:(NSString *)filepath;

-(void)writeFileData:(LSBleActionEvent *)logModel andfilepath:(NSString *)filepath;
@end
