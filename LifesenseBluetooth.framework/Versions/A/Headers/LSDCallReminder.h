//
//  LSDCallReminder.h
//  LSBluetooth-Library
//
//  Created by lifesense on 16/1/17.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import "LSDBaseModel.h"
#import "LSConst.h"

@interface LSDCallReminder : LSDBaseModel


@property (nonatomic, assign)   LSCallReminderAlertType type;
@property (nonatomic, assign)   BOOL isOpen;
@property (nonatomic, assign)   int shockDelay;
@property (nonatomic, assign)   LSShockType shockType;
@property (nonatomic, assign)   int shockTime;
@property (nonatomic, assign)   int shockLevel1;
@property (nonatomic, assign)   int shockLevel2;


@end
