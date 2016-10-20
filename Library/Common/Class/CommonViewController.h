//
//  CommonViewController.h
//  co.medisolution
//
//  Created by OGGU on 2016. 8. 25..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumType.h"
#import "MommyRequest.h"
#import "AppDelegate.h"
#import "GlobalData.h"


#define GET_AUTH_TOKEN [GlobalData sharedGlobalData].authToken // 인증토큰

#define GET_USER_ID [GlobalData sharedGlobalData].userId // 유저 아이디

@interface CommonViewController : UIViewController

#pragma mark 인디케이터 관련

- (void) showIndicator; // 인디케이터 활성화

- (void) hideIndicator; // 인디케이터 비활성화

#pragma mark 키보드 매니저 관련

- (void) setKeyboardEnabled : (BOOL) enabled; // 키보드 자동 업 이벤트 활성화 비활성화

#pragma mark 게이트웨이 관련





















@end
