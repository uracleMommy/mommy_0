//
//  LSBluetoothStateChangeDelegate.h
//  LSBluetooth-Library
//
//  Created by caichixiang on 16/2/28.
//  Copyright © 2016年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSBluetoothStateChangeDelegate <NSObject>

-(void)bleManagerDidBluetotohStateChange:(BOOL)isOpen;
@end
