//
//  CommonViewController.m
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import "CommonViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"


@implementation CommonViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self setKeyboardEnabled:YES];
}

#pragma mark 인디케이터 관련

#pragma 인디케이터 활성화
- (void) showIndicator {
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate indicatorViewIn];
}

#pragma 인디케이터 비활성화
- (void) hideIndicator {
    
    AppDelegate *appDelegate =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate indicatorViewOut];
}

#pragma mark 키보드 매니저 관련

#pragma 키보드 자동 업 이벤트 활성화/비활성화
- (void) setKeyboardEnabled : (BOOL) enabled {
    
    [[IQKeyboardManager sharedManager] setEnable:enabled];
}


#pragma mark 네비게이션 버튼 관련










@end
