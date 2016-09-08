//
//  SignUpMain.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "termsPopupViewController.h"
#import "AppDelegate.h"
#import "emoticonPopupViewController.h"

@interface SignUpMain : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, termsPopupViewDelegate>{
    UIViewController *scrollViewContoller;
}

@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

#pragma mark 정보동의 팝업 관련
@property (strong, nonatomic) termsPopupViewController *termsPopupView;

@end

