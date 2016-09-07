//
//  SignUpMain.h
//  co.medisolution
//
//  Created by uracle on 2016. 8. 10..
//  Copyright © 2016년 medisolution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface SignUpMain : UIViewController <UITextFieldDelegate, UIPickerViewDelegate>{
    UIViewController *scrollViewContoller;
}

@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@end

